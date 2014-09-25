function run_struct = MatchTitles_v3(run_struct, samplelist, MiniBlock, niplistOriginal, RunlistOriginal, K, L)

% HOME
% addpath(genpath('C:\Users\Bonner\Desktop\Matlab_Eyetracking_data'))
% data_path = ('C:\Users\Bonner\Desktop\Matlab_Eyetracking_data\eyelink_data');

% % LINUX
addpath = ('/neurospin/meg/meg_tmp/Karin_2013/Matlab_Eyetracking_data/scripts/');
data_path = ('/neurospin/meg/meg_tmp/Karin_2013/Matlab_Eyetracking_data/eyelink_data/');

% % USB
% addpath = ('G:\final scripts' )
% data_path = ('G:\eyelink_data')
% load(['G:\final scripts\samplelist&Miniblock.mat']);

% listnipeye = ls([data_path '\eyelink_data']);


% for n = 2 %:length(niplist)       % n= subject(s) from the niplist, if n=1: only the first subj, if its 16 its the last sbj
subj = [];                 % create variable to put the subjects name in it
subj = niplistOriginal{K};          % put the name from the subject into the variable

%     if isempty(strfind(listnipeye, nip)) == 0  % find MEG subject NIP in the list of Eyetracking NIP if so =1, but make it as 0.
%        for L = 1:length(eyelist{n,:})      % find each L from the list which contains all the runs for subject n
% L is from first run1 until
% the end, so if no run1 exists
% we have to write it from the
% existing ones until the end.

%  if isempty(strfind(reshape(listnipeye.',1,[]), nip)) == 0   %HOME
%
%       for  L= 5 %:length(eyelist{n,:})   % tell which L you want to label

count = [0 0 0 0 0];             % counter for the Refs


for blockindex = 1:33    % blockindex = each BLOCK
    run_struct(1,blockindex).Ref = samplelist{K,L}(3,blockindex);  % write into your Blockstructure /now : run_structstructure the order of the Refs that you find in samplelist, third line
    
%     if run_struct(1,blockindex).Ref == 6
%         continue
        
    % qt(index) is a vector that contains the numbers for time and space
    
    if run_struct(1,blockindex).Ref == 1    % if first line and 33 coloumns from blocknumber the Refs is 1
        count(1) = count(1) + 1;     % make count = 1
        qt = GetMEGTriggers_v2(MiniBlock,K,L,[6 7],1,count);      %L the fct GetMEGTriggers(MiniBlock,sunjectsname,L,triggers(Dimension),ref,count)
        dist = GetMEGDistance_v2(MiniBlock,K,L,[16 17 18 19],1,count);
        %                    EventTrig = GetMEGEvents(MiniBlock,K,L,[37:72],1,count);
        for qtindex = 1:length(qt)
            run_struct(1,blockindex).block(1,qtindex).Question = qt(qtindex);  % line 1 and then depending on the Blocknumber
            run_struct(1, blockindex).block(1, qtindex).trial(1,2).type = dist(qtindex);
            %                        run_struct(1, blockindex).block(1, qtindex).trial(1, 2) = event(qtindex);
        end
        
        
    elseif run_struct(1,blockindex).Ref == 2       % if the Ref is 2
        count(2) = count(2) + 1;      %
        qt = GetMEGTriggers_v2(MiniBlock,K,L,[8 9],2,count);
        dist = GetMEGDistance_v2(MiniBlock,K,L,[20 21 22 23],2,count);
        %                    EventTrig = GetMEGEvents(MiniBlock,K,L,[37:72],2,count);
        for qtindex = 1:length(qt)
            run_struct(1,blockindex).block(1,qtindex).Question = qt(qtindex);
            run_struct(1, blockindex).block(1, qtindex).trial(1,2).type = dist(qtindex);
            %                        run_struct(1, blockindex).block(1, qtindex).trial(1, 2) = event(qtindex);
        end
        
    elseif run_struct(1,blockindex).Ref == 3
        count(3) = count(3) + 1;
        qt = GetMEGTriggers_v2(MiniBlock,K,L,[10 11],3,count);
        dist = GetMEGDistance_v2(MiniBlock,K,L,[24 25 26 27],3,count);
        %                    EventTrig = GetMEGEvents(MiniBlock,K,L,[37:72],3,count);
        for qtindex = 1:length(qt)
            run_struct(1,blockindex).block(1,qtindex).Question = qt(qtindex);
            run_struct(1, blockindex).block(1, qtindex).trial(1,2).type = dist(qtindex);
            %                        run_struct(1, blockindex).block(1, qtindex).trial(1, 2) = event(qtindex);
        end
        
        
    elseif run_struct(1,blockindex).Ref == 4
        count(4) = count(4) + 1;
        qt = GetMEGTriggers_v2(MiniBlock,K,L,[12 13],4,count);
        dist = GetMEGDistance_v2(MiniBlock,K,L,[28 29 30 31],4,count);
        %                    EventTrig = GetMEGEvents(MiniBlock,K,L,[37:72],4,count);
        for qtindex = 1:length(qt)
            run_struct(1,blockindex).block(1,qtindex).Question = qt(qtindex);
            run_struct(1, blockindex).block(1, qtindex).trial(1,2).type = dist(qtindex);
            %                        run_struct(1, blockindex).block(1, qtindex).trial(1, 2) = event(qtindex);
        end
        
        
    elseif run_struct(1,blockindex).Ref == 5
        count(5) = count(5) + 1;
        qt = GetMEGTriggers_v2(MiniBlock,K,L,[14 15],5,count);
        dist = GetMEGDistance_v2(MiniBlock,K,L,[32 33 34 35],5,count);
        %                    EventTrig = GetMEGEvents(MiniBlock,K,L,[37:72],5,count);
        for qtindex = 1:length(qt)
            run_struct(1,blockindex).block(1,qtindex).Question = qt(qtindex);
            run_struct(1, blockindex).block(1, qtindex).trial(1,2).type = dist(qtindex);
            %                        run_struct(1, blockindex).block(1, qtindex).trial(1, 2) = event(qtindex);
        end
        
    end   % gives the Refnumber in the Structure
    
end       % loop to use all 33 blocks

%  save([data_path '\' RunlistOriginal{K}{L} '.mat'], 'subj', 'L','run_struct')

end   % ends loop for runs









%%%%%%%%%%%  When you want to change the Participant, you have to change
%%%%%%%%%%%  the line from Samplelist. Be careful that you L the correct
%%%%%%%%%%%  Block when you L this lines.

%
% If Ref = 3 , then Q = 10 or 11 in MiniBlock.
% If Q = 10 then write in Blockstructure "Time"
% If Q = 11 than write in Blockstructure "Space".


%  for i = 1:33 % i = each BLOCK
%
%      for t =1:8 % t = trials
%
%          for k = 1:length(a) % k = line containing the QUESTION
%
%              if MiniBlock{1, 1}.FutPar{1, 1}(a(k)-1,2) == 3 && MiniBlock{1,1}.FutPar{1,1}(a(k),2) == 10
%                  Block(i).trial(t).event(1).type = 'Time';
%              elseif MiniBlock{1, 1}.FutPar{1, 1}(a(k)-1,2) == 3 && MiniBlock{1,1}.FutPar{1,1}(a(k),2) == 11
%                  Block(i).trial(t).event(1).type = 'Space';
%              end
%
%          end
%      end
%  end






