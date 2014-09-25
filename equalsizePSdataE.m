function matrixE = equalsizePSdataE(run_struct)

%%%% MATRIX mit PS data und NaNs wenns sie zu kurz sind

% find the maximum of one run only for Question and put it into the vector A. 
A=[];
for block_num = 1:33
    for trial_num= 1:8
        A = [A; length(run_struct(block_num).block(trial_num).trial(1,2).pupilsize)]; % A = is a coloum with all the lengths for each event
    end
end

max_lengthE= max(A); % für all blocks, y achse
min_lengthE= min (A);

n = [];
matrixE=[];
n= length(A);  % Anzahl von Trials (x achse)

matrixE = NaN(n,max_lengthE);  % Matrix with the size of the trialsstuff and filled with NaNs


% (block_num-1)*8+trial_num = wenn du in block 1 bist bist hast du 0 aber er fängt bei trial 1 an und geht weiter bis 8 (vom ersten block)
for block_num = 1:33
    for trial_num= 1:8
       matrixE((block_num-1)*8+trial_num,1:length(run_struct(block_num).block(trial_num).trial(1,2).pupilsize))= run_struct(block_num).block(trial_num).trial(1,2).pupilsize ;
    end 
end


