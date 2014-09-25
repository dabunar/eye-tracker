function Run = Runstr(data, nip,run)


data_path = (['/neurospin/meg/meg_tmp/Karin_2013/Matlab_Eyetracking_data/eyelink_data/' nip ]);
% data_path = (['G:\eyelink_data\' nip '\']);   

% this script creates a Stucture which contains all data. Run it after
% analyza_datos und blink interpolation. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

message_searched = 'REF';            % message to search for marking the beginning of each block
block = 0;  % counter for blocks
BLOCK = [ ];
POS = [];


for count =1:size(data.msg,1)   % counter for time points
    
    message = data.msg{count};  % gets the message number "count"
    if findstr(message, message_searched)
        POS = [POS count]; % if REF appears, a new block: save the counter
    end
end



whos POS % number of blocks (Postition of all REFs)


MSGS = {'TRIALID',...    messages to look for within each block
    'EVENTID',...
    'RESPID'};


for block = 1:length(POS)                                  % for all blocks
    block
    
    if block ==length(POS)
        Trial = {data.msg{POS(block)+1:end}};
        Time =  data.msgtime(POS(block)+1:end);
    else
        Trial = {data.msg{POS(block)+1:POS(block+1)}};         % get the messages from begining to end of block
        Time =  data.msgtime(POS(block)+1:POS(block+1));       % and the time of each message
    end
    
  for C=1:8                                              % for each trial within the block
        events = 0;
        
        for m = 1:length(MSGS)                             % and each possible message (trial, event, response)
            message = [MSGS{m},' ',num2str(C)];
            D=[];
            for tr =1:length(Trial)                        % finds the position of that message within the block
                D = findstr(Trial{tr},message);             % D is when the message and Trial correspond to each other
                if D,break,end
            end
     
           if not(isempty(D))    % if there is such a message (sometimes there is no response)
                events = events + 1;
                Run(block).block(C).trial(events).type   = message;         % saves message type
                Run(block).block(C).trial(events).starttime   = Time(tr)-1000;    % saves start time
                ini = find(data.samples(:,1) == Time(tr)-1000);      % find in data samples the index when your event occurs
                
                if tr<length(Trial)
                    fin = find(data.samples(:,1) == Time(tr+1)+1000);
                else
                    fin=size(data.samples+1000,1);
                end
                
                fin;               
                
             if not(isempty(fin))
                    datasac = ones(1,length(data.samples(ini:fin,2)));  % serie de donnes contenant info surs les saccades. NaNs quand t'as un blink ?
                    tsac = find(data.lesac(:,1) >=ini & data.lesac(:,1) < fin);  %tsac is the starting and endpoint of your saccadess that you want to delete afterwards in your timecours
                    block     % pour afficher a quel essai on est
                    for sac = 1:length(tsac)
                        datasac(data.lesac(tsac(sac),1)-ini+1:data.lesac(tsac(sac),1)-ini+1+data.lesac(tsac(sac),3)) =NaN;
                    end
                    
                    Run(block).block(C).trial(events).saccade = datasac;
             end
                    

             
                    Run(block).block(C).trial(events).xpos = data.samples(ini:fin,2); % saves X
                    Run(block).block(C).trial(events).ypos = data.samples(ini:fin,3); % saves Y
                    Run(block).block(C).trial(events).pupilsize = data.samples(ini:fin,4);  % saves pupil size
                    Run(block).block(C).trial(events).endtime = Time(tr) + length(data.samples(ini:fin ,2)) - 1;  % save endtime
                 
                   
                end  % ends loop for creation of blockstruc
        end   % ends loop for all MSGS
  end       % ends loop for the 8 trials
end         % ends loop for the 33 blocks
    
    Pct_blinks=100*sum(data.lebli(data.lebli(:,3)>20,3))/size(data.samples,1);
   
    save([data_path '/' num2str(run) '.mat'], 'Pct_blinks', 'run', 'Run', 'data')

end