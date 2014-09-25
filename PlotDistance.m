function PlotDistance(matrices)


% EVENTS Close vs Far
% here we make a time courve for close and far events 


n_subjects = 1:length(matrices);      % amount of subjects
MaxiMatrixE = 0; % max(length(matrices{subj}{1:2}.MatrixQ));
for subj = 1:n_subjects                     % take the maximum of subjects
for run =1:length(matrices{subj})           % take the maximum of runs
    if length(matrices{subj}{run}) == 0     % if there is no run than continue
        continue
    end
    
    if length(matrices{subj}{run}.MatrixE) > MaxiMatrixE    % Where do we ask for the maximum MatrixQ?
        MaxiMatrixE = length(matrices{subj}{run}.MatrixE);   % We only ask for the length no?
    end
end
end

for subj = 1: n_subjects %length(matrices);  % Nimm alle Subj von matrices 
    
for run = 1:length(matrices{subj});     % Anzahl von Runs in einem Subject, vom ersten Run bis zum Ende der Anzahl von Runs von einem Probanden
    
%      baseline = max(length(matrices{1:subj}{1:run}.BaselinedQ));   % take the maximum size of MatrixQ of all runs for this subject and put it into o


%% Plot one subjects all his runs together
    if length(matrices{subj}{run}) == 0
        continue
    end

    matrix = matrices{subj}{run}.matrix;   %  nimm die matrix vom n-ten Run und call it matrix
    MatrixE = nan(264, MaxiMatrixE);           % MatrixQ ist jetzt die grösste MatrixQ als Maximum gefüllt mit NaNs
%     MatrixE(:,1:length(matrices{subj}{run}.BaselinedQ)) = matrices{subj}{run}.BaselinedQ;    % mach mir alle anderen MatrixQ in diese Datei rein
    
    FarEvents = find(matrix(:,6)==2);    % find the indexes for Distance 1: Far, 2: Close
    FarEv = MatrixE(FarEvents,:);       % find the equivalent lines for your PS data for Space and put it into B, so B contains all PSdata for Space
    FarEventsTC=(nanmean(FarEv,1));                   % take the mean and ignor the Nans of your Space PS data and put it into C

    CloseEvents = find(matrix(:,6)==1);    % find the indexes for Distance 1: Far, 2: Close
    CloseEv = MatrixE(CloseEvents,:);       % find the equivalent lines for your PS data for Space and put it into B, so B contains all PSdata for Space
    CloseEventsTC=(nanmean(CloseEv,1));                   % take the mean and ignor the Nans of your Space PS data and put it into C


end             % ends loof for the runs for one subj

end             % ends loof for the loop for subj


%% Time courve plot
% figure (1)
% plot(FarEventsTC, 'r')
% hold on
% plot(CloseEventsTC)    
% %  vertical line
% hold on
% line([1000 1000], [1500 2000])
% title('Close (blue line) and Far (red line) Events') % title
% xlabel('Time')
% ylabel('Pupilsize in arbitrary units')


%% BarPlot Time vs Space 4 conditions
  


case1close = SpaceSpaceDim(CloseEventsTC,:) ;        % take all close events during SS condition

case2close = TimeTimeDim(CloseEventsTC,:);
    
case3close = SpaceTimeDim(CloseEventsTC,:);

case4close = TimeSpaceDim(CloseEventsTC,:);


case1far = SpaceSpaceDim(FarEventsTC,:) ;        % take all far events during SS condition

case2far = TimeTimeDim(FarEventsTC,:);
    
case3far = SpaceTimeDim(FarEventsTC,:);

case4far = TimeSpaceDim(FarEventsTC,:);

figure(3)
bar(case1close, case2close, case3close,case4close, case1far, case2far, case3far, case4far ) 
title('Plot for Distance effect') % title
xlabel('Conditions')
ylabel('Pupilsize in arbitrary units')
set(gca,'ylim',[1400,2000])



