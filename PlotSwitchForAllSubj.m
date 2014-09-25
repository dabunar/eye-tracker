function vectors = PlotSwitchForAllSubj(matrices)

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
n_subjects = length(matrices);      % amount of subjects
MaxiMatrixE = 0;
MaxiMatrixQ = 0; % max(length(matrices{subj}{1:2}.MatrixQ));
for subj = 1:n_subjects                     % take the maximum of subjects
for run =1:length(matrices{subj})           % take the maximum of runs
    if length(matrices{subj}{run}) == 0     % if there is no run than continue
        continue
    end
    
    if length(matrices{subj}{run}.MatrixQ) > MaxiMatrixQ    % Where do we ask for the maximum MatrixQ?
        MaxiMatrixQ = length(matrices{subj}{run}.MatrixQ);   % We only ask for the length no?
    end
    if length(matrices{subj}{run}.MatrixE) > MaxiMatrixE    % Where do we ask for the maximum MatrixQ?
        MaxiMatrixE = length(matrices{subj}{run}.MatrixE);   % We only ask for the length no?
    end
end
end

a = zeros(1, MaxiMatrixQ);
b = zeros(1, MaxiMatrixQ);
c = zeros(1, MaxiMatrixQ);
d = zeros(1, MaxiMatrixQ);

figure(1)
figure(2)

for subj = 1: n_subjects %length(matrices);  % Nimm alle Subj von matrices 

    
for run = 1:length(matrices{subj});     % Anzahl von Runs in einem Subject, vom ersten Run bis zum Ende der Anzahl von Runs von einem Probanden
    
%      baseline = max(length(matrices{1:subj}{1:run}.BaselinedQ));   % take the maximum size of MatrixQ of all runs for this subject and put it into o


%% Plot one subjects all his runs together
    if length(matrices{subj}{run}) == 0
        continue
    end
    matrix = matrices{subj}{run}.matrix;   %  nimm die matrix vom n-ten Run und call it matrix
    MatrixQ = nan(264, MaxiMatrixQ);           % MatrixQ ist jetzt die grösste MatrixQ als Maximum gefüllt mit NaNs
    MatrixQ(:,1:length(matrices{subj}{run}.BaselinedQ)) = matrices{subj}{run}.BaselinedQ;    % mach mir alle anderen MatrixQ in diese Datei rein
    
    SpaceDim = find(matrix(:,4)==1);    % find the indexes for question : Space in der matrix vom entsprenden Run
    B = MatrixQ(SpaceDim,:);            % find the equivalent lines for your PS data for Space and put it into B, so B contains all PSdata for Space
    
    SpaceMean(run, :)=(nanmean(B,1));                   % take the mean and ignor the Nans of your Space PS data and put it into C
    
    TimeDim = find(matrix(:,4)==2);      % find the indexes for question : Time
    D = MatrixQ(TimeDim,:);              % find the equivalent lines for your PS data for time
    TimeMean(run,:) = (nanmean(D,1));           % take the mean od all your runs TimeDim data and ignor the Nans
    
end             % ends loof for the runs for one subj

vectors{subj}.TimeMean = TimeMean;
vectors{subj}.SpaceMean = SpaceMean;

figure(1)
subplot(3, 5, subj);
xlim([500., 4000.]);

% plot(C{1});       % to verify if its the mean or the
% hold on
% plot(C{2});
% hold on

plot(nanmean(SpaceMean,1))  ;                           % plot all the means
hold on
plot(nanmean(TimeMean,1),'r')  ;

% plot(E,'r')                           % plot all the means
title('Space(blue) and Time(red) Dimension') % title
xlabel('Time')
ylabel('Pupilsize in arbitrary units')



%%
% Compare Condition1 vs Condition2 thus check for any switch cost in PS data
for run = 1: length(matrices{subj});           % geh durch alle Runs von Proband x
   if length(matrices{subj}{run}) == 0
        continue
    end
    matrix = matrices{subj}{run}.matrix;       % nimm die matrix für jeden Probanden und Run und pack die in matrix
    MatrixQ = nan(264, MaxiMatrixQ);        % mach 264 linien und den maximum and Spalten die du davor shcon ausgerechnet hattest
    MatrixQ(:,1:length(matrices{subj}{run}.BaselinedQ)) = matrices{subj}{run}.BaselinedQ;  % mach in den 500-1000 sample die baseline rein (=0)
    
    MatrixE = nan(264, MaxiMatrixE); 
    MatrixE(:,1:length(matrices{subj}{run}.MatrixE)) = matrices{subj}{run}.MatrixE;
    
    % S==>S (blue)
    SpaceSpaceDim = find(matrix(:,5)==1);    % find the indexes for question : Space Space
    SpaceSpaceCloseDim = find(matrix(:,5)==1 & matrix(:,6)==1);
    SpaceSpaceFarDim = find(matrix(:,5)==1 & matrix(:,6)==2);
    B = MatrixQ(SpaceSpaceDim,:);       % find the equivalent lines for your PS data for Space and put it into B, so B contains all PSdata for Space
    SpaceSpaceMean(run,:)=(nanmean(B,1));                   % take the mean and ignor the Nans of your Space PS data and put it into C
    B = MatrixE(SpaceSpaceCloseDim,:);
    SpaceSpaceCloseMean(run,:)=(nanmean(B,1));
    1
end

a = a + nanmean(SpaceSpaceMean,1);
vectors{subj}.SpaceSpaceDim = SpaceSpaceDim;

figure(2)
subplot(3, 5, subj);
plot(nanmean(SpaceSpaceMean,1),'color',[1 0 1])                        % plot all the means
xlim([500., 4000.]);

% T==>S (blue light purple)
for run = 1: length(matrices{subj});
    if length(matrices{subj}{run}) == 0
        continue
    end
    matrix = matrices{subj}{run}.matrix;
    MatrixQ = nan(264, MaxiMatrixQ);
    MatrixQ(:,1:length(matrices{subj}{run}.BaselinedQ)) = matrices{subj}{run}.BaselinedQ;
    
    TimeSpaceDim = find(matrix(:,5)==4);    % find the indexes for question : Time Space
    D = MatrixQ(TimeSpaceDim,:);            % find the equivalent lines for your PS data for Time Space and put it into D, so D contains all PSdata for Time followed by Space
    TimeSpaceMean(run,:)=(nanmean(D,1));                       % take the mean and ignor the Nans of your data and put it into E
    
end

b = b + nanmean(TimeSpaceMean,1);
vectors{subj}.TimeSpaceDim = TimeSpaceDim;

hold on

plot(nanmean(TimeSpaceMean,1),'color',[0 0 1])

% hold on
%  plot(E{1},'color',[1 0 1])                             % plot all the means
% hold on
%  plot(E{2},'color',[1 1 0])

TimeSpaceDim = []; TimeSpaceMean =[];D = [];

%%
% T==>T

for run = 1: length(matrices{subj});
    if length(matrices{subj}{run}) == 0
        continue
    end
    matrix = matrices{subj}{run}.matrix;
    MatrixQ = nan(264, MaxiMatrixQ);
    MatrixQ(:,1:length(matrices{subj}{run}.BaselinedQ)) = matrices{subj}{run}.BaselinedQ;
    
    TimeTimeDim = find(matrix(:,5)==2);    % find the indexes for question : TimeTime
    F = MatrixQ(TimeTimeDim,:);       % find the equivalent lines for your PS data for Space and put it into B, so B contains all PSdata for Space
    TimeTimeMean(run,:)=(nanmean(F,1));                   % take the mean and ignor the Nans of your Space PS data and put it into C
    
end

c = c + nanmean(TimeTimeMean,1);
vectors{subj}.TimeTimeDim = TimeTimeDim;

hold on
plot(nanmean(TimeTimeMean,1),'green')
% plot(G,'green')                             % plot all the means

TimeTimeDim  = [];F =[]; TimeTimeMean = [];



% S==>T

for run = 1: length(matrices{subj});
    if length(matrices{subj}{run}) == 0
        continue
    end
    matrix = matrices{subj}{run}.matrix;
    MatrixQ = nan(264, MaxiMatrixQ);
    MatrixQ(:,1:length(matrices{subj}{run}.BaselinedQ)) = matrices{subj}{run}.BaselinedQ;
    SpaceTimeDim = find(matrix(:,5)==3);    % find the indexes for question : SpaceTime
    H = MatrixQ(SpaceTimeDim,:);       % find the equivalent lines for your PS data for Space and put it into B, so B contains all PSdata for Space
    SpaceTimeMean(run,:)=(nanmean(H,1));                   % take the mean and ignor the Nans of your Space PS data and put it into C
    
end

d = d + nanmean(SpaceTimeMean, 1);
vectors{subj}.SpaceTimeDim = SpaceTimeDim;

hold on
plot(nanmean(SpaceTimeMean,1),'color',[1 0 0])
% plot(I,'color',[1 0 0])                             % plot all the means

SpaceTimeDim  = [];F =[]; SpaceTimeMean = [];

xlabel('Time')
ylabel('Pupilsize in arbitrary units')

end % subj loop

a = a / n_subjects;
b = b / n_subjects;
c = c / n_subjects;
d = d / n_subjects;
figure(2);
subplot(3, 5, 13:15)
plot(a,'color',[1 0 1])
hold on
plot(b,'color',[0 0 1])
hold on
plot(c,'color', 'green')
hold on
plot(d,'color',[1 0 0])
xlim([500., 4000.]);
legend('S==>S','T==>S','T==>T','S==>T')



%% mark events like Question or Event and Response... but doesnt work for now
% hold on
% line([1000 1000],[1500 2000])


