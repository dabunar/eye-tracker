function matrixQ = equalsizePSdataQ(run_struct)


%%%% creats MATRIX mit PS data und NaNs wenns sie zu kurz sind

% find the maximum of one run only for Question and put it into the vector A. 
A=[];
for block_num = 1:33
    for trial_num= 1:8
        A = [A; length(run_struct(block_num).block(trial_num).trial(1,1).pupilsize)]; % A = is a coloum with all the lengths for each question
    end
end

max_lengthQ= max(A); % für all blocks, y achse
min_lengthQ= min(A);


n = [];
matrixQ=[];
n= length(A);  % Anzahl von Trials (x achse)

matrixQ = NaN(n,max_lengthQ);  % Matrix with the size of the trialsstuff and filled with NaNs


% (block_num-1)*8+trial_num = wenn du in block 1 bist bist hast du 0 aber er fängt bei trial 1 an und geht weiter bis 8 (vom ersten block)
for block_num = 1:33
    for trial_num= 1:8
       matrixQ((block_num-1)*8+trial_num,1:length(run_struct(block_num).block(trial_num).trial(1,1).pupilsize))= run_struct(block_num).block(trial_num).trial(1,1).pupilsize ;
    end 
end



%%% --> Am Ende hast du eine Matrix mit allen PS datas (gleichlang und am Ende mit NaNs gefüllt) die während der
%%% Question auf kamen
