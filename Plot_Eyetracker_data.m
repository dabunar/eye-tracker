%   function figures = Plot_Eyetracker_data (Run)

%% Pupil size changes for both conditions

% HOME
% addpath(genpath('C:\Users\Bonner\Desktop\Matlab_Eyetracking_data'))
% data_path = ('C:\Users\Bonner\Desktop\Matlab_Eyetracking_data\eyelink_data');
% 

% LINUX
addpath(genpath('/neurospin/meg/meg_tmp/Karin_2013/Matlab_Eyetracking_data'))
data_path = ('/neurospin/meg/meg_tmp/Karin_2013/Matlab_Eyetracking_data/eyelink_data/');

% % USB
% data_path= ('G:\');

niplist= {'sl130503';'lm130479';'ma100253';'sg120518';'tk130502';...
    'sb120316';'jm100042';'wl130316';'mm130405';...
    'dm130250';'hr130504';'mp140019';'mb140004'};

eyelist = {{'Run1';'Run2'; 'Run4';};...  %sl
    {'Run2'};...         % lm
    {'Run1';'Run2';'Run3';'Run4';'Run5'};... %ma
    {'Run1'};... %sg
    {'Run2'; 'Run3'; 'Run4'; 'Run5'};...  %tk : Run1 deleted because of error
    {'Run1'; 'Run5'};... %sb
    {'Run4'};... %jm  Run1: same pb (no Question vorhanden...)
    {'Run1'; 'Run4'};... %wl
    {'Run3'};...  %mm
    {'Run2';'Run3'};... %dm
    {'Run1'; 'Run3'};...  %hr
    {'Run2'};... % mp
    {'Run1'; 'Run4';}};%mb  %put back 'Run4'


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%  QUESTION / DIMENSION / TIME vs SPACE SUCCESSION  %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Condition1 =[];     % is a vector containing all pupilsize data for the same succession of question (TRIALID)
                    % but we need for each condition 2 vectors containing
                    % the data for the first question and one for the
                    % following question
dataneededQ1 = []   %Pupilsize for the first Question for condtition1
dataneededQ2 = []   %Pupilsize for the following question for condition1

%

Condition2 =[];     % is a vector containing all pupilsize data for different succession of question (TRIALID)
                    % we need as well 2 vectors for Q1 and Q1+1
dataneededQ3 = []   %Pupilsize for the first Question for condtition2
dataneededQ4 = []   %Pupilsize for the following question for condition2               
                    
Condition1mean =[];     % create empty variables for the mean of the pS questions, where he can put your data for condition1
Condition2mean =[];

for n = 1 :length(niplist)        % starts loop across subjs to load all data/ runs from all subjects you need to define them again and tell where they are
    subj = [];
    subj = niplist{n};
    
    Condition1 =[];
    dataneededQ1 = []
    dataneededQ2 = []
    
    Condition2 =[];
    dataneededQ3 = []
    dataneededQ4 = []
    
       
    subj
    for  run= 1 : length(eyelist{n,:})  % starts loop across run
       
        
        load([data_path subj '\Updated_v3_' char(eyelist{n,:}(run)) '.mat'])
%         load('Updated_v3_Run2.mat')
        for block_num =1:33   % starts the block numerb with 1 until 33
            for trial_num = 1:7    % starts the trial number 1-8, but there are only 7 jumps
            
                if strcmpi(Run(1, block_num).block(1,(trial_num)).Question,Run(1, (block_num)).block(1,(trial_num+1)).Question)  % tiral type eingeben, strcmpi looks if they are the same and if so than its a 1 and goes to condition1, if not it goes to contion2
                    dataneededQ1 = Run(1, block_num).block(1,(trial_num)).trial(1,1).pupilsize;  % Question 1 wenn dieselbe Q
                    dataneededQ2 = Run(1, block_num).block(1,(trial_num+1)).trial(1,1).pupilsize; % Question 2
%                     Condition1mean = [Condition1mean; mean(~isnan(dataneededQ1)); mean(~isnan(dataneededQ2 ))]; 
%                     Condition1 = [Condition1; mean(dataneededQ1(~isnan(dataneededQ1))) (dataneededQ2(~isnan(dataneededQ2)))];   % shell we use the minimum of the length of the data?
                Condition1 = [Condition1 {dataneededQ1(~isnan(dataneededQ1))} {dataneededQ2(~isnan(dataneededQ2))}];    % 
                
                else    % wenn die Q unterschiedlich sind
                    dataneededQ3 = Run(1, block_num).block(1,(trial_num)).trial(1,1).pupilsize;
                    dataneededQ4 = Run(1, block_num).block(1,(trial_num+1)).trial(1,1).pupilsize;
%                     Condition2mean = [ Condition2mean; mean(~isnan(dataneededQ3)); mean(~isnan(dataneededQ4)) ];
%                     Condition2 = [Condition2; mean(dataneededQ3(~isnan(dataneededQ3))) (dataneededQ4(~isnan(dataneededQ4)))];       
                Condition2 = [Condition2 {dataneededQ3(~isnan(dataneededQ3))} {dataneededQ4(~isnan(dataneededQ4))}]; 
                end % ends loop IF
               
            end   % ends trial
        end   % ends block
        
     end      % ends loop across run


%%%%%%%%%%%%% PLOTTING QUESTION / DIMENSION / TIME vs SPACE SUCCESSION  %%%%%%%%%%%
     
     %%%%   Condition 1 (same Questions)
     
     figure(1)
     % errorbar([mean(Condition1mean{1,1}(~isnan(Condition1mean{1,1}))),'b', mean(Condition1mean{1,2}(~isnan(Condition1mean{1,2}))),'g']);
     bar([mean(Condition1{1,1}(~isnan(Condition1{1,1}))),mean(Condition1{1,2}(~isnan(Condition1{1,2})))]);
     title('Plot of Condition 1 (succession of same Dimensions)') % title
     xlabel('Condition')
     ylabel('Pupilsize in arbitrary units')
     set(gca,'xtickLabel',{'First Question', 'Second Question'})
     set(gca,'ylim',[1400,2000])
     
     %%%% Condition 2 (diff Questions)
     
     figure(2)
     % errorbar([mean(Condition1mean{1,1}(~isnan(Condition1mean{1,1}))),'b', mean(Condition1mean{1,2}(~isnan(Condition1mean{1,2}))),'g']);
     bar([mean(Condition2{1,1}(~isnan(Condition2{1,1}))),mean(Condition2{1,2}(~isnan(Condition2{1,2})))]);
     title('Plot of Condition 2 (succession of different Dimensions)') % title
     xlabel('Condition')
     ylabel('Pupilsize in arbitrary units')
     set(gca,'xtickLabel',{'First Question', 'Second Question'})
     set(gca,'ylim',[1400,2000])
     
     % --> jetzt musst du nur noch eine Abbildung haben wo du alle means hast
     % und somit eine zusammenfassung f�r alle machst (mit errorbars und std)
     
end    % ends loop across sub



%%%%%%%%%%%%% PLOTTING QUESTION / DIMENSION / TIME vs SPACE SUCCESSION  %%%%%%%%%%%



%% plots the mean for Cond1 and for Cond2
figure(3)
for n = 1 :length(niplist)        % starts loop across subjs to load all data/ runs from all subjects you need to define them again and tell where they are
    plot(mean(Condition1mean{n,1}),'b', mean(Condition1mean{n,2}),'g')
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%               DISTANCE EFFECT BAR PLOTS           %%%%%%%%%%%%%%% 
%%%%%%%%% mit den Mittelwerten arbeiten und BAR plot machen %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% I want to know if in this field is written 'Far', if so, then take these
% PS data into dataneededFar, so we can create a vector which contains all
% PS data for all subjects and runs to further plot them. 


% PB: auch hier dass er nur den letzten Block und Trial plottet

FarAll = [];        % f�r den mean aller Probanden wenn event Far ist
CloseAll = [];

for n = 1 :length(niplist)        % starts loop across subjs to load all data/ runs from all subjects you need to define them again and tell where they are
    subj = [];
    subj = niplist{n};
    subj
    Far =[];     % is a vector containing all pupilsize data for far events
    Close = [];     % is a vector containing all pupilsize data for close events
    
    for run= 2 % 1: length(eyelist{n,:})  % starts loop across run
        run
        
        load([data_path subj '\Updated_v3_' char(eyelist{n,:}(run)) '.mat'])
        
        for block_num = 1:33   % starts the block numerb with 1 until 33
            for trial_num = 1:8    % starts the trial number 1-8, but there are only 7 jumps
                
                
                dataneededFar = [];  % puts all the far pupil size datas into the Far vector
                dataneededClose = [];    % puts all the close PS date into the close vector
                
               
                if  strcmp(Run(1, block_num).block(1,(trial_num)).trial(1,2).type(1,1), 'Far')
                    dataneededFar = Run(1, block_num).block(1,(trial_num)).trial(1,2).pupilsize;
                    Far = [Far; mean(dataneededFar(~isnan(dataneededFar)))];   % Far contains the PS mean for all Far conditions in this run
                else
                    % strcmp(Run(1, block_num).block(1,(trial_num)).trial(1,2).type(1,1), 'Close')
                    dataneededClose = Run(1, block_num).block(1,(trial_num)).trial(1,2).pupilsize;
                    Close = [Close; mean(dataneededClose(~isnan(dataneededClose)))];  % Close contains all PS data from close events for the whole run
                end
                
            end   % ends trial loop
            
        end   % ends block loop
        
        
        % create some vectors with the mean for the conditions
        
        FarAll = [FarAll; mean(Far(~isnan(Far)))];   % is the mean for the whole run for all PS data in Far Conditions 
        CloseAll = [CloseAll; mean(Close(~isnan(Close)))];  % is the mean for all Close Conditions for the whole run
        all = [FarAll CloseAll];    % are both means of the total Far PS data and total CLose PS data in one vector
        
        
    end      % ends loop across run
    
end    % ends loop across sub
 
%%%%%    Plot Far vs close events in a bar plot

% plotte mir den mean von allen Far PS data
figure(3)
bar([mean(Far(~isnan(Far))), mean(Close(~isnan(Close)))]);
title('Distance effect') % title
xlabel('Condition')
ylabel('Pupilsize in arbitrary units')
set(gca,'xtickLabel',{'Far', 'Close'})
set(gca, 'ylim',[1400,2000])

% --> scalar �ndern, dass der nicht bei 0 anf�ngt & errorbars und mean


% average (farall and close all) the means of all far and close PS data for
% all subjects.
% there is only one bar... I don�t know why

figure(4)
bar([mean(FarAll(~isnan(FarAll))), mean(CloseAll(~isnan(CloseAll)))]);
title('Plot for Distance effect for all subjects') % title
xlabel('Condition')
ylabel('Pupilsize in arbitrary units')
set(gca,'xtickLabel',{'Far', 'Close'})
set(gca, 'ylim',[1400,1600])





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
        
        if length(Run(1,block_num).block(1,trial_num).trial)>2  % 0 falsch, 1 richtig. if Trail >2 dann soll er die next steps machen. % Falls es keine Antwort gab, also falls trial > als 2 dann mach auch die Resp
            
            PS_Trial= [1:1:length(Run(1,block_num).block(1,trial_num).trial(1,1).pupilsize)]; % QUESTION PS data
            
            if isempty(Run(1,block_num).block(1,trial_num).trial(1,2).pupilsize)==1  % Wenn leer ist dann ists 1 und dann soll er weiter machen. returns 1 (true) if is an empty array and logical and 0 (false) otherwise
                continue
            else                % wenn 0 (also nicht empty-false) dann soll er das in PS_Event reinmachen. Falls es kein Event gab (Trial fertig), also falls trial > als 1 (question) dann mach auch Event
                PS_Event = [length(PS_Trial)+ 1:1:(length(PS_Trial)+length(Run(1,block_num).block(1,trial_num).trial(1, 2).pupilsize))];
            end   % end if loop for missing events
            
            PS_Resp = [length(PS_Trial)+length(PS_Event)+ 1:1:(length(PS_Trial)+length(PS_Event)+length(Run(1, block_num).block(1,trial_num).trial(1,3).pupilsize))];    
       
%         end   % ends loop for the 8 trials
%     end        % ends loop for the 33 blocks
    
    % Pupilsize pos
    figure(5)
    hold on
    plot(PS_Trial,(Run(1,block_num).block(1,trial_num).trial(1,1).pupilsize))
    plot(PS_Event,(Run(1,block_num).block(1,trial_num).trial(1,2).pupilsize),'r')
    plot(PS_Resp,(Run(1,block_num).block(1,trial_num).trial(1,3).pupilsize),'g')
    
end     % Block loop