% plot all PS data for Question once original interpolated data and once the smoothed
% (in red)


for block_num = 1: 33
    for trial_num = 1:8
smoothedData= smooth(Run(block_num).block(trial_num).trial(1).pupilsize)

figure(1)
plot(Run(block_num).block(trial_num).trial(1).pupilsize)
hold on
plot(smoothedData, 'r')

    end 
end


% ok du hast jetzt die rohdaten und die gesmoothen daten vom ganzen Run. und du willst jetzt eigtl Q1 und Q2 
% nebeneinander haben. Q1 und Q2 sollten nebeneinander geplottet sein.

S_S = find(matrix(:,5)==1)  % wenn Q1= Space und Q2= Space dann nimm mir die index für Space vom ganzen Run

S_S_PS1 = equalPSdataQ(S_S-1,:)'   % vector PS data Space during first Q for the whole Run
S_S_PS2 = equalPSdataQ(S_S,:)'  % vector with all PSdata Space during second Q for the whole Run

% 
meanS_S_PS1= mean(nanmean(S_S_PS1))   % gives you the mean for the whole Run for the first Question Space

meanS_S_PS2= mean(nanmean(S_S_PS2))   % gives you the mean for the whole Run for the second Question Space

figure (2)
plot(meanS_S_PS1, meanS_S_PS2)



% for block_num=1:33
%     for trial_num=1:8


% Bar plot 


figure (2)
plot([meanS_S_PS1' meanS_S_PS2'])   % Abbildung fürn Arsch

plot(mean(smoothedS_S_PS1))
hold on
plot(mean(smoothedS_S_PS2))

% smoothed data bar plot

smoothedS_S_PS1 = smooth(S_S_PS1);   % smoothe mir die daten
smoothedS_S_PS2 = smooth(S_S_PS2);

figure (3)
plot([mean(smoothedS_S_PS1) mean(smoothedS_S_PS2)])   % Abbildung fürn Arsch

plot(mean(smoothedS_S_PS1))
hold on
plot(mean(smoothedS_S_PS2))


% Boxplot
[zeros(length(smoothedS_S_PS1),1);ones(length(smoothedS_S_PS2),1)]

S_PS1_S_PS2 = [smoothedS_S_PS1;smoothedS_S_PS2];
S_PS1_S_PS2_2 = [S_PS1_S_PS2 [zeros(length(smoothedS_S_PS1),1);ones(length(smoothedS_S_PS2),1)]]
boxplot(S_PS1_S_PS2_2(:,1),S_PS1_S_PS2_2(:,2))



% time courve

count = 1:length(S_S_PS(:,1));

times1=[1:1:length(equalPSdataQ(S_S,:))]';
times2=[length(times1)+1:1:(length(times1)+length(equalPSdataQ(S_S,:)))]';  % hier ist was falsch, weil ich ihm nirgends sage dass er vom nächsten die daten nehmen soll, wobei er es aus irgendnem grund trotzdem tut lol 


pupilquestion1 = [S_S_PS; nanmean(S_S_PS(count,:))]  %PROBLEM: we need the mean of each line not coloumn



pupilquestion1 = S_S_PS(count,:)';    % this is the PS data from the first Question for Space
pupilquestion2 = S_S_PS(count+1,:)';   % this is the PS data from the second Question for Space


% smoothed time courve S_S 
figure(4)
plot(times1,smooth(pupilquestion1,50),'b')
hold on
plot(times2,smooth(pupilquestion2,50),'r')


%%%%%%%%%%%%% Bar PLOTTING QUESTION   %%%%%%%%%%%

%%%%   Condition 1 (same Questions)

a=nanmean(pupilquestion1)
b=nanmean(pupilquestion2)

figure(1)
% errorbar ?
bar([a,b]);
title('Plot of Condition 1 (succession of same Dimensions)') % title
xlabel('Condition')
ylabel('Pupilsize in arbitrary units')
set(gca,'xtickLabel',{'First Question "Space"', 'Second Question "Space"'})
set(gca,'ylim',[1400,2000])

%  boxplot
figure(3)
boxplot([pupilquestion1,pupilquestion2])
title('Plot of Condition 1 (succession of same Dimensions)') % title
ylabel('Pupilsize in arbitrary units')
set(gca,'xtickLabel',{'First Question "Space"', 'Second Question "Space"'})
set(gca,'ylim',[1400,2000])

%  Time courve for the QUESTIONS : Space and Time Dimensions 
% We want to know if the switch between dimensions changes something in the
% PS data. therefore we use the Dummy codes from the matrix and plot the 4
% different conditions

S_S = find(matrix(:,5)==1)    % find the indexes for Question1 Space followed by Question2 Space (Spalte 5= Dummycodes)

S_S_PS = equalPSdataQ(S_S,:)       % find the equivalent lines for your PS data for Space followed by Space
smoothedS_S_PS = smooth(equalPSdataQ(S_S,:))
S_S_PSmean=(nanmean(S_S_PS,1))          % take the mean and ignor the Nans for eacht timepoint of your Space PS data followed by Space PS data and put it into S_S_PSmean

figure (3)
plot(S_S_PSmean)
hold on
plot(smoothed(S_S_PS, 'r'))
title('Space Space') % title
xlabel('Time')
ylabel('Pupilsize in arbitrary units')




S_T = find(matrix(:,5)==2)    % find the indexes for Question1 Space followed by Question2 Time

S_T_PS = equalPSdataQ(S_T,:)       % find the equivalent lines for your PS data for Space

S_T_PSmean=(nanmean(S_T_PS,1))                % take the mean and ignor the Nans

figure (4)
plot(S_T_PSmean)
title('Space Time') % title
xlabel('Time')
ylabel('Pupilsize in arbitrary units')




T_T = find(matrix(:,5)==3)    % find the indexes for Question1 Time followed by Question2 Time

T_T_PS = equalPSdataQ(T_T,:)       % find the equivalent lines for your PS data for Space

T_T_PSmean=(nanmean(T_T_PS,1))                % take the mean and ignor the Nans

figure (5)
plot(T_T_PSmean)
title('Time Time') % title
xlabel('Time')
ylabel('Pupilsize in arbitrary units')




T_S = find(matrix(:,5)==4)    % find the indexes for Question1 Time followed by Question2 Space

T_S_PS = equalPSdataQ(T_S,:)       % find the equivalent lines for your PS data for Space

T_S_PSmean=(nanmean(T_S_PS,1))                % take the mean and ignor the Nans

figure (6)
plot(T_S_PSmean)
title('Time Space') % title
xlabel('Time')
ylabel('Pupilsize in arbitrary units')




