 function [data] = blinkInterpolationCode_v4(data);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Detects vertical drops and eliminates them. 

dataclean = (data.samples(:,4));  % data clean contains only the PS data

for intervall = 101:(length(dataclean)-120) % fenetre de 20 msec Partala.... (-20 is for the last 20 samples)
    if abs(dataclean(intervall)-dataclean(intervall+19))>80; % see pic in block. take 20msec intervall and check if in each step
                                                   % there is a change in pupilsize from about 100/400 units
        dataclean((intervall-100):(intervall+189))=ones(290,1)*NaN;   % put NaNs for the peaks enleve 2à s a gauche et 39 a droite
        
      
     end                                        
end

% 40 (fig1)
% 20 (fig2)
% 50 (fig3)
% 70 4
% 90 7
% 120 8
% % 150 9
% 

% fct OUTLIER
alpha = 0.05;
for intervall = 1:30e3:(length(dataclean)-30e3)  
    X = []; X = dataclean(intervall:((intervall+30e3)-1));
    Y = []; out = [];
    [Y out]=outliers(X,'quartile',alpha);
    X(out) = NaN;
end

% % you have to uncomment to see the blinks
% figure (16)
% plot(data.samples(:,4), 'r')   % to compare with the original data
% hold on
% plot(dataclean)  % data without the peaks but not yet interpolated


% fct HAMPEL
% alpha = 0.05;
% datacleanclean = [];
% for intervall = 1:30e3:(length(dataclean)-30e3)  % from the first sample in 30er steps until the end - the last 30 samples
%     X = []; X = dataclean(intervall:((intervall+30e3)-1));  % PS data in the time window
%     YY = [];
%     DX  = 3*nanmedian((X(2:end)-X(1:end-1)));
%     T   = 3;
%     [YY,I,Y0,LB,UB] = hampel(intervall:((intervall+30e3)-1),X,DX,T,'Adaptive',0.1);  % fct hampel
%     datacleanclean(intervall:((intervall+30e3)-1)) = YY;
% end

% figure (1)
% plot(dataclean,'r')
% hold on
% plot(datacleanclean) % datacleanclean is the data without the outlier

% --> your new data is called dataclean and deleted almost all the vertical drops by replacing them with NaNs
% now you need to interpolate this data

 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% interpolation of the blinks

dataclean = inpaint_nans(dataclean); % take method 4 or 5 for the interpoaltion, than it looks almost fine (fig13 and fig15), but there are still some peaks left

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot the interpolation (uncomment it)

% figure (94)
% plot(dataclean, 'b')  % blue line data without the peaks and interpolated 
% methode 4 und 5 sind gut (siehe script "inpaint_nan").


data.samples(:,4)=inpaint_nans(dataclean);


 end