 function figures = Plot_timecourseBars (run)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%               TRIAL Time COURSE PLOTS               %%%%%%%%%%%%%
%%%%%%%%% Plot Timecourse for Pupilsize from Question to Resp %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% from script ..._PartII : here is a nice time course figure for the last Block and last Trial.


% 1) we have to delete the blinks (and few samples before the blinks) --> DONE
% 2) take an average for the line for each participant and finally for the
% whole group

% creates vectors which accumulate the PSdata first for TrialID, then EventID, then RespID

for block_num = 1 : 33  
 for trial_num = 1: 8

          
     PS_Trial = [1:1:length(Run(1,block_num).block(1,trial_num).trial(1,1).pupilsize)]; %
     PS_Event = [length(PS_Trial)+ 1:1:(length(PS_Trial)+length(Run(1,block_num).block(1,trial_num).trial(1, 2).pupilsize))];

     if length(Run(1,block_num).block(1,trial_num).trial)>2   % Falls es keine Antwort gab, also falls trial > als 2 dann mach auch die Resp
         PS_Resp = [length(PS_Trial)+length(PS_Event)+ 1:1:(length(PS_Trial)+length(PS_Event)+length(Run(1, block_num).block(1,trial_num).trial(1,3).pupilsize))];
     end
     
     
 end % ends the trial loop
end % ends the block loop 

% Pupilsize pos
 figure(1) 
 hold on
 plot(PS_Trial,(Run(1,block_num).block(1,trial_num).trial(1,1).pupilsize))
 plot(PS_Event,(Run(1,block_num).block(1,trial_num).trial(1,2).pupilsize),'r')
 plot(PS_Resp,(Run(1,block_num).block(1,trial_num).trial(1,3).pupilsize),'g')
 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% % Die Kurven fangen alle bei 0 an. Deshlab sind diese Abbildungen für die
% timecourse nicht wirklich gut, da wir ja den Verlauf / die Veränderung während des Trial sehen wollen.

% figure(1)
% plot(Run(1).block(1).trial(2).pupilsize, 'g')
% hold on
% plot(Run(1).block(2).trial(2).pupilsize, 'b')
% hold on
% plot(Run(1).block(3).trial(2).pupilsize, 'r')
% 
% 
% % Macht dasselbe.. ich kriege die nicht nebeneinander...
% figure (2)
% a= 1:10000;
% x= Run(1).block(1).trial(2).pupilsize, 'g';
% hold on
% y= Run(1).block(2).trial(2).pupilsize, 'b';
% hold on
% z= Run(1).block(3).trial(2).pupilsize,'r';
% 
% plot(a(1:length(x)),x,a(1:length(y)),y,a(1:length(z)),z)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%               DISTANCE EFFECT BAR PLOTS           %%%%%%%%%%%%%%% 
%%%%%%%%% mit den Mittelwerten arbeiten und BAR plot machen %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% PB: auch hier dass er nur den letzten Block und Trial plottet

TrialID = [];       % fï¿½r die gesammelten PS daten
Far = [];
Close = [];
RESPID = [];
TrialID_ALL = [];     % nimm einen mean von all deinen Daten und pack den in deinen vaktor
FarAll = [];  
CloseAll = [];
RespAll = [];
all = [];
 
 
for block_num = 1:33    % starts loop for all 33 Blocks
    for trial_num = 1:8     % starts loop for all 8 trials

%aus irgendeinem Grund macht der TrialID nur wenn du es einzelnd
%einlaufen lï¿½sst (also mit F9). dann geht auch der plot.

 if strcmp(Run(1, block_num).block(1,(trial_num)).trial(1,1).type(1,1), 'TRIALID ');  % find the PS data in Runstr for the Question
    dataneededTrialID = Run(1, block_num).block(1,(trial_num)).trial(1,1).pupilsize; % packe alle PS datas für die Question in einen vektor called dataneededTrialID
    TrialID = [TrialID; mean(dataneededTrialID(~isnan(dataneededTrialID)))];   % nimm alle NaNs aus deinem Vektor mit den PS raus und mach dann den Mean davon und dann pack die means in den vektor

 elseif strcmp(Run(1, block_num).block(1,(trial_num)).trial(1,2).type(1,1), 'Far');  % finde die PS fï¿½r Far
     dataneededFar = Run(1, block_num).block(1,(trial_num)).trial(1,2).pupilsize;   % pack alle PS in einen Vectore
     Far = [Far; mean(dataneededFar(~isnan(dataneededFar)))];    
 
 elseif strcmp(Run(1, block_num).block(1,(trial_num)).trial(1,2).type(1,1), 'Close');
     dataneededClose = Run(1, block_num).block(1,(trial_num)).trial(1,2).pupilsize;
     Close = [Close; mean(dataneededClose(~isnan(dataneededClose)))];
 
 else strcmp(Run(1, block_num).block(1,(trial_num)).trial(1,3).type(1,1), 'RESPID ');
     dataneededResp = Run(1, block_num).block(1,(trial_num)).trial(1,2).pupilsize;
     RESPID = [RESPID; mean(dataneededResp(~isnan(dataneededResp)))];
    
 end    % ends the if loop (taking all PS data and put them into vectors)
    end  % ends loop for the 8 trials
end   % ends loop for the 33 Blocks

  
 % nimm einen mean von all deinen Daten und pack den in deinen vektor 
 TrialID_ALL = [TrialID_ALL; mean(TrialID(~isnan(TrialID)))];    
 FarAll = [FarAll; mean(Far(~isnan(Far)))];  
 CloseAll = [CloseAll; mean(Close(~isnan(Close)))];
 RespAll = [RespAll; mean(RESPID(~isnan(RESPID)))];
 all = [TrialID_ALL FarAll CloseAll RespAll];


figure(2)  
bar([mean(TrialID_ALL(~isnan(TrialID_ALL))), mean(FarAll(~isnan(FarAll))), mean(CloseAll(~isnan(CloseAll))), mean(RespAll(~isnan(RESPID)))]);
title('Plot for Distance effect') % title


figure(3)  
bar([mean(FarAll(~isnan(FarAll))), mean(CloseAll(~isnan(CloseAll)))]);
title('Plot for Distance effect') % title


 end