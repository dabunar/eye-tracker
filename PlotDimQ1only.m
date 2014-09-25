%  Time courve for the QUESTIONS : Space and Time Dimensions irrelevant the order. 
% do this with close and far events. this makes more sense

function PlotSwitch(nip,varargin)

% SpaceDim = find(matrix(:,4)==1);    % find the indexes for question : Space
% B = equalPSdataQ(SpaceDim,:);       % find the equivalent lines for your PS data for Space and put it into B, so B contains all PSdata for Space
% C=(nanmean(B,1));                   % take the mean and ignor the Nans of your Space PS data and put it into C
% 
% TimeDim = find(matrix(:,4)==2);    % find the indexes for question : Time
% D = equalPSdataQ(TimeDim,:);       % find the equivalent lines for your PS data for time
% E = (nanmean(D,1));                % take the mean od all your TimeDim data and ignor the Nans
% 
% figure (1)
% plot(C)                             % plot all the means
% hold on
% plot(E,'r')                           % plot all the means
% title('Space(blue) and Time(red) Dimension') % title
% xlabel('Time')
% ylabel('Pupilsize in arbitrary units')
% 
% 
% %% 
% 
%  % Dummycode for the Dimensions
%                                 % Space Space = 1
%                                 % Space Time = 2
%                                 % Time Time = 3
%                                 % Time Space = 4
% 
% % S==>S (blue)
% SpaceSpaceDim = find(matrix(:,5)==1);    % find the indexes for question : Space Space
% B = equalPSdataQ(SpaceSpaceDim,:);       % find the equivalent lines for your PS data for Space and put it into B, so B contains all PSdata for Space
% C=(nanmean(B,1));                   % take the mean and ignor the Nans of your Space PS data and put it into C
% 
% figure (2)
% plot(C,'color',[0 0 1])                             % plot all the means
% 
% 
% % T==>S (blue light purple)
% TimeSpaceDim = find(matrix(:,5)==4);    % find the indexes for question : Time Space
% D = equalPSdataQ(TimeSpaceDim,:);       % find the equivalent lines for your PS data for Space and put it into B, so B contains all PSdata for Space
% E=(nanmean(D,1));                       % take the mean and ignor the Nans of your Space PS data and put it into C
% 
% hold on
% plot(E,'color',[0.5 0 1])                             % plot all the mean
% 
% TimeSpaceDim = [];E =[];D = [];

%% 
% T==>T 
TimeTimeDim = find(matrix(:,5)==3);    % find the indexes for question : TimeTime
B = equalPSdataQ(TimeTimeDim,:);       % find the equivalent lines for your PS data for Space and put it into B, so B contains all PSdata for Space
C=(nanmean(B,1));                   % take the mean and ignor the Nans of your Space PS data and put it into C

hold on
plot(C,'r')                             % plot all the means

TimeTimeDim  = [];B =[];C = [];

% S==>T 
SpaceTimeDim = find(matrix(:,5)==2);    % find the indexes for question : SpaceTime
B = equalPSdataQ(SpaceTimeDim,:);       % find the equivalent lines for your PS data for Space and put it into B, so B contains all PSdata for Space
C=(nanmean(B,1));                   % take the mean and ignor the Nans of your Space PS data and put it into C

hold on
plot(C,'color',[1 0 0.7])                             % plot all the means
xlabel('Time')
ylabel('Pupilsize in arbitrary units')

legend('S==>S','T==>S','T==>T','S==>T')

% mark events
hold on
line([1000 1000],[1500 2000])


























% 
% 
% 
% 
% %
% 
% We want to know if the switch between dimensions changes something in the
% PS data. therefore we use the Dummy codes from the matrix and plot the 4
% different conditions
% 
% S_S = find(matrix(:,5)==1);    % find the indexes for Question1 Space followed by Question2 Space
% 
% S_S_PS = equalPSdataQ(S_S,:);      % find the equivalent lines for your PS data for Space
% 
% S_S_PSmean=(nanmean(S_S_PS,1));               % take the mean and ignor the Nans
% 
% figure (3)
% plot(S_S_PSmean)
% title('Space Space') % title
% xlabel('Time')
% ylabel('Pupilsize in arbitrary units')
% 
% 
% 
% 
% S_T = find(matrix(:,5)==2);    % find the indexes for Question1 Space followed by Question2 Time
% 
% S_T_PS = equalPSdataQ(S_T,:);       % find the equivalent lines for your PS data for Space
% 
% S_T_PSmean=(nanmean(S_T_PS,1));                % take the mean and ignor the Nans
% 
% figure (4)
% plot(S_T_PSmean)
% title('Space Time') % title
% xlabel('Time')
% ylabel('Pupilsize in arbitrary units')
% 
% 
% 
% 
% T_T = find(matrix(:,5)==3);    % find the indexes for Question1 Time followed by Question2 Time
% 
% T_T_PS = equalPSdataQ(T_T,:) ;      % find the equivalent lines for your PS data for Time
% 
% T_T_PSmean=(nanmean(T_T_PS,1));                % take the mean and ignor the Nans
% 
% figure (5)
% plot(T_T_PSmean)
% title('Time Time') % title
% xlabel('Time')
% ylabel('Pupilsize in arbitrary units')
% 
% 
% 
% 
% T_S = find(matrix(:,5)==4);    % find the indexes for Question1 Time followed by Question2 Space
% 
% T_S_PS = equalPSdataQ(T_S,:);       % find the equivalent lines for your PS data for Space
% 
% T_S_PSmean=(nanmean(T_S_PS,1));                % take the mean and ignor the Nans
% 
% figure (6)
% plot(T_S_PSmean)
% title('Time Space') % title
% xlabel('Time')
% ylabel('Pupilsize in arbitrary units')
% 
% 
% 
% 
% % EVENTS Close vs Far
% 
% 
% 
% FarEvents = find(matrix(:,6)==1);    % find the indexes for Distance 1: Far, 2: Close
% FarEv = equalPSdataE(FarEvents,:);       % find the equivalent lines for your PS data for Space and put it into B, so B contains all PSdata for Space
% FarEventsTC=(nanmean(FarEv,1));                   % take the mean and ignor the Nans of your Space PS data and put it into C
% 
% CloseEvents = find(matrix(:,6)==2);    % find the indexes for Distance 1: Far, 2: Close
% CloseEv = equalPSdataE(CloseEvents,:);       % find the equivalent lines for your PS data for Space and put it into B, so B contains all PSdata for Space
% CloseEventsTC=(nanmean(CloseEv,1));                   % take the mean and ignor the Nans of your Space PS data and put it into C
% 
% 
% figure (1)
% plot(FarEventsTC, 'r')
% hold on
% plot(CloseEventsTC)    
% # vertical line
% hold on
% line([min_lengthE min_lengthE], [1500 2000])
% title('Close (blue line) and Far (red line) Events') % title
% xlabel('Time')
% ylabel('Pupilsize in arbitrary units')
% 
% 
% 
% 
