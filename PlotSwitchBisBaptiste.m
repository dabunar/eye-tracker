function PlotSwitchBis(matrices, i , j)

%  Time courve for the QUESTIONS for one subject and all his runs : Space and Time Dimensions irrelevant the order.
%  % Dummycode for the Dimensions
%                                 % Space Space = 1
%                                 % Space Time = 3
%                                 % Time Time = 2
%                                 % Time Space = 4
%


%%  Compare Time Time Dimension with Space Space Dimension
% MatrixQ is the complete PS data (-1000msec before and +2000msc after the Question)


%% Plot all subjects 
       

for subj = 1: length(matrices)  % Nimm alle Subj von matrices 
    
  
for run = 1: length(matrices{i}) ;     % Anzahl von Runs in einem Subject
    
    biggestMatrixQofAllSubj = max(length(matrices{subj}{run}.MatrixQ));     % schau welcher den längsten MatrixQ hat
   
    o = max(length(matrices{i}{1:m}.MatrixQ));   % take the maximum size of MatrixQ of all runs for this subject and put it into o

end
end

%% Plot one subjects all his runs together
                 % vom ersten Run bis zum Ende der Anzahl von Runs von einem Probanden
    matrix = matrices{i}{run}.matrix;   %  nimm die matrix vom nten Run und call it matrix
    MatrixQ = nan(264, o);           % MatrixQ ist jetzt die grösste MatrixQ mit l als Maximum gefüllt mit NaNs
    MatrixQ(:,1:length(matrices{i}{run}.MatrixQ)) = matrices{i}{run}.MatrixQ;    % mach mir alle anderen MatrixQ in diese Datei rein
    
    SpaceDim = find(matrix(:,4)==1);    % find the indexes for question : Space in der matrix vom entsprenden Run
    B = MatrixQ(SpaceDim,:);            % find the equivalent lines for your PS data for Space and put it into B, so B contains all PSdata for Space
    
    C(run,:)=(nanmean(B,1));                   % take the mean and ignor the Nans of your Space PS data and put it into C
    
    TimeDim = find(matrix(:,4)==2);      % find the indexes for question : Time
    D = MatrixQ(TimeDim,:);              % find the equivalent lines for your PS data for time
    E(run,:) = (nanmean(D,1));           % take the mean od all your runs TimeDim data and ignor the Nans
    
end

figure (1)

% plot(C{1});       % to verify if its the mean or the
% hold on
% plot(C{2});
% hold on

plot(nanmean(C,1))  ;                           % plot all the means
hold on
plot(nanmean(E,1),'r')  ;

% plot(E,'r')                           % plot all the means
title('Space(blue) and Time(red) Dimension') % title
xlabel('Time')
ylabel('Pupilsize in arbitrary units')



%%
% Compare Condition1 vs Condition2 thus check for any switch cost in PS data
for run = 1: m
    matrix = matrices{i}{run}.matrix;
    MatrixQ = nan(264, o);
    MatrixQ(:,1:length(matrices{i}{run}.MatrixQ)) = matrices{i}{run}.MatrixQ;
    
    % S==>S (blue)
    SpaceSpaceDim = find(matrix(:,5)==1);    % find the indexes for question : Space Space
    B = MatrixQ(SpaceSpaceDim,:);       % find the equivalent lines for your PS data for Space and put it into B, so B contains all PSdata for Space
    C(run,:)=(nanmean(B,1));                   % take the mean and ignor the Nans of your Space PS data and put it into C
end

figure (2)

plot(nanmean(C,1),'color',[1 0 1])                             % plot all the means


% T==>S (blue light purple)
for run = 1:m
    matrix = matrices{i}{run}.matrix;
    MatrixQ = nan(264, o);
    MatrixQ(:,1:length(matrices{i}{run}.MatrixQ)) = matrices{i}{run}.MatrixQ;
    
    TimeSpaceDim = find(matrix(:,5)==4);    % find the indexes for question : Time Space
    D = MatrixQ(TimeSpaceDim,:);            % find the equivalent lines for your PS data for Time Space and put it into D, so D contains all PSdata for Time followed by Space
    E(run,:)=(nanmean(D,1));                       % take the mean and ignor the Nans of your data and put it into E
    
end

hold on

plot(nanmean(E,1),'color',[0 0 1])

% hold on
%  plot(E{1},'color',[1 0 1])                             % plot all the means
% hold on
%  plot(E{2},'color',[1 1 0])

TimeSpaceDim = [];E =[];D = [];

%%
% T==>T

for run = 1:m
    matrix = matrices{i}{run}.matrix;
    MatrixQ = nan(264, o);
    MatrixQ(:,1:length(matrices{i}{run}.MatrixQ)) = matrices{i}{run}.MatrixQ;
    
    TimeTimeDim = find(matrix(:,5)==2);    % find the indexes for question : TimeTime
    F = MatrixQ(TimeTimeDim,:);       % find the equivalent lines for your PS data for Space and put it into B, so B contains all PSdata for Space
    G(run,:)=(nanmean(F,1));                   % take the mean and ignor the Nans of your Space PS data and put it into C
    
end

hold on
plot(nanmean(G,1),'green')
% plot(G,'green')                             % plot all the means

TimeTimeDim  = [];F =[];G = [];



% S==>T

for run = 1:m
    matrix = matrices{i}{run}.matrix;
    MatrixQ = nan(264, o);
    MatrixQ(:,1:length(matrices{i}{run}.MatrixQ)) = matrices{i}{run}.MatrixQ;
    SpaceTimeDim = find(matrix(:,5)==3);    % find the indexes for question : SpaceTime
    H = MatrixQ(SpaceTimeDim,:);       % find the equivalent lines for your PS data for Space and put it into B, so B contains all PSdata for Space
    I(run,:)=(nanmean(H,1));                   % take the mean and ignor the Nans of your Space PS data and put it into C
    
end

hold on
plot(nanmean(I,1),'color',[1 0 0])
% plot(I,'color',[1 0 0])                             % plot all the means


xlabel('Time')
ylabel('Pupilsize in arbitrary units')

legend('S==>S','T==>S','T==>T','S==>T')


end % subj loop


%% mark events like Question or Event and Response... but doesnt work for now
% hold on
% line([1000 1000],[1500 2000])



