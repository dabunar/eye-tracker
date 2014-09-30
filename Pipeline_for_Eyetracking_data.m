

close all
clear all
clc

% HOME
% addpath(genpath('C:\Users\Bonner\Desktop\Matlab_Eyetracking_data'))
% data_path = ('C:\Users\Bonner\Desktop\Matlab_Eyetracking_data\eyelink_data\sl130503\');

% % USB Holystick
%  addpath(genpath('G:\'));
%  script_path = ('G:\final scripts');
%  results_path = ('G:\Results');

% % LINUX
addpath(genpath('/neurospin/meg/meg_tmp/Karin_2013/Matlab_Eyetracking_data'));
script_path = (' /neurospin/meg/meg_tmp/Karin_2013/Matlab_Eyetracking_data/scripts/');
results_path = ('/neurospin/meg/meg_tmp/Karin_2013/Matlab_Eyetracking_data/Results');

niplist = {'sl130503';'lm130479';'ma100253';'sg120518';'tk130502';...
    'sb120316';'jm100042';'wl130316';'mm130405';...
    'dm130250';'hr130504';'mp140019';'mb140004'};

runlist1 ={{'run1';'run2';'run3';'run4'};...    % 1 sl
    {'run1';'run2';'run3';'run4'};...  % 2 lm
    {'run1';'run2';'run3';'run4';'run5'};...  % 3 ma
    {'run1';'run2';'run3';'run4';'run5' };...   % 4 sg was mit run5?
    {'run1';'run2';'run3';'run4';'run5'};...  % 6 tk
    {'run1';'run5'};...  % 7 sb_run4 can not be converted to asci file
    {'run1';'run4'};...      % 10 jm100042
    {'run1';'run2';'run3';'run4';'run5'};...   % 11 wl
    {'run1';'run2';'run3';'run4'};...              % 12 mm
    {'run1';'run2';'run3';'run4';'run5'};...  % 12 dm: run4 und1 pb Miniblock
    {'run1';'run2';'run3';'run4'};...   %13 hr
    {'run1';'run2';'run3'; 'run4'};...          %14 mp
    {'run1';'run2';'run3';'run4';'run5'}};   % 15 mb



runlist ={{'Run1';'Run2';'Run3';'Run4'};...    % 1 sl
    {'Run1';'Run2';'Run3';'Run4'};...  % 2 lm
    {'Run1';'Run2';'Run3';'Run4';'Run5'};...  % 3 ma
    {'Run1';'Run2';'Run3';'Run4';'Run5' };...   % 4 sg was mit Run5?
    {'Run1';'Run2';'Run3';'Run4';'Run5'};...  % 5 tk
    {'Run1';'Run5'};...  % 6 sb_Run4 can not be conveRted to asci file
    {'Run1';'Run4'};...      % 7 jm100042
    {'Run1';'Run2';'Run3';'Run4';'Run5'};...   % 8 wl
    {'Run1';'Run2';'Run3';'Run4'};...              % 9 mm
    {'Run1';'Run2';'Run3';'Run4';'Run5'};...  % 10 dm: Run4 und1 pb Miniblock
    {'Run1';'Run2';'Run3';'Run4'};...   %11 hR
    {'Run1';'Run2';'Run3'; 'Run4'};...          %12 mp
    {'Run1';'Run2';'Run3';'Run4';'Run5'}};   % 13 mb



load(['/neurospin/meg/meg_tmp/Karin_2013/Matlab_Eyetracking_data/scripts/samplelist&Miniblock.mat']);
% load(['G:\final scripts\samplelist&Miniblock.mat']);

niplistOriginal = {'sl130503';'lm130479';'ma100253';'sg120518';'ms130534';'tk130502';...
    'sb120316';'jm100109';'rb130313';'jm100042';'wl130316';'mm130405';...
    'dm130250';'hr130504';'mp140019';'mb140004'};

RunlistOriginal = {{'run1_GD';'run2_GD';'run3_DG';'run4_DG'};...    % 1
    {'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'};...
    {'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'};...
    {'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'};...
    {'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'};...    %5
    {'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'};...
    {'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'};...
    {'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'};...
    {'run2_GD';'run3_DG';'run4_DG'};...
    {'run1_GD';'run3_DG';'run4_DG'};...                         %10
    {'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'};...
    {'run1_GD';'run2_GD';'run3_DG';'run4_DG'};...
    {'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'};...
    {'run1_GD';'run2_GD';'run3_DG';'run4_DG'};...
    {'run1_GD';'run2_GD';'run3_DG';'run4_DG'};...               % 15
    {'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'}};


for i = 1: length(niplist)   % take all subjects from your niplist (without ms,jm, rb)
    
    
    data_path = (['/neurospin/meg/meg_tmp/Karin_2013/Matlab_Eyetracking_data/eyelink_data/' niplist{i} '/']);  % go to the subj
    %    data_path = (['G:\eyelink_data\' niplist{i} '\']);
    %    script_path = ('G:\final scripts');
    % %
    for j = 1:length(runlist{i})    % der Run den du gerade benutzt
        
        
        clearvars K
        clearvars L
        
        if (i == 1 && j == 3) || (i == 10 && j == 1) || (i == 12 && j == 2)
            continue
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%
        for k = 1:length(niplistOriginal)       % k= subjetname from the original SubjList
            if niplistOriginal{k} == niplist{i}   % wenn deine Liste mit der originalen übereinstimmt dann mach K draus.
                K =k;
            end
        end
        
        for l = 1:length(RunlistOriginal{K})     % the original number of Runs
            
            if strfind(lower(RunlistOriginal{K}{l}), lower(runlist{i}{j}))==1    % if the arrey is empty il will give u a 1 if there are numbers then its not empty thus 0.
                L = l;                                                           % wenn also runlist und runlistOriginal gleich sind, dann ist eigtl 1
                % und dann soll der sagen, dass es nicht empty ist
            end
        end
        
        
        
        
        %%%%%%%%%%%%%%%%%%%%%%%
        % filter .asci file
        data = [];
        data = analiza_datos([data_path runlist1{i}{j} '.asc']);
        
        %%%%%%%%%%%%%%%%%%%%%%%
        % Blink interpolation
        data = blinkInterpolationCode_v4(data);
        
        %%%%%%%%%%%%%%%%%%%%%%%
        % Creates Runstructure :
        Run = [];
        Run = RunstrComplete(data, niplist{i}, runlist{i}{j});   % i is the subj and j us the runnumber
        
        
        Runbis = MatchTitles_v3(Run, samplelist, MiniBlock, niplistOriginal, RunlistOriginal, K, L);  %check subj and run
        clearvars Run
        
        %%%%%%%%%%%%%%%%%%%%%%%
        % creates a matrix for each event (Question, Event, Reponse). the matrixes
        % contains all PS data for one event, they have the same size as they
        % are filled with NaNs until the end.
        
        MatrixQ = equalsizePSdataQ(Runbis);
        MatrixE = equalsizePSdataE(Runbis);    % PS during Event  not yet finished
        % equalsizePSdataR  % PS during Response  not yet finished
        
                baselinedQ = BaselinedQ(MatrixQ, 500,1000);     % beginsample und endsample werden hier definiert
        
%         baselinedQ = BaselinedQ(matrices, MatrixQ, 500,1000);     % beginsample und endsample werden hier definiert
        
        %%%%%%%%%%%%%%%%%%%%%%%
        % THE MATRIX fct to have one matrix with all information
        matrix = TheMatrix(Runbis);
        matrices{i}{j}.subject_id = niplist{i};  % nom du sujet
        matrices{i}{j}.matrix = matrix;  % cree la strucutre matrix pour tous les sujets et tous les runs
        matrices{i}{j}.Runbis = Runbis;   % ta runstructure avec toutes des données
        matrices{i}{j }.MatrixQ = MatrixQ;       % PS data for all TrailID, c la matrix avec la meme taille de vecteurs (pour les plots)
        matrices{i}{j}.MatrixE = MatrixE        % PS data for all eventID
        matrices{i}{j}.BaselinedQ = baselinedQ
    end     % ends for runlist
    
    
    %%%%%%%%%%%%%%%%%%%%%%%
%     % Plot time courses and Bars for all subjects with mean etc
     PlotSwitchForAllSubj(matrices);
     saveas(gcf,'SwitchPlot.fig')
    
   
    % save subject-specific matrix data
    subj_matrix = matrices{i};
    save(['/neurospin/meg/meg_tmp/Karin_2013/Matlab_Eyetracking_data/Results/', niplist{i}, 'subj_matrix'] , 'subj_matrix', '-v7.3');
    
end         % ends for niplist

save('/neurospin/meg/meg_tmp/Karin_2013/Matlab_Eyetracking_data/Results/final_matricesBASELINE200bis1000' , 'matrices', '-v7.3');

% ............................................

% You can use this if you want to use epoch and average:
%         fs = 1000; % sampling freq
%         tb = 0.2; % baseline time in secs
%         Nblocks = 33;
%         Ntrials = 8;
%         cond = 1; % condition
%         d = epoch_v2(data,Run,cond,Nblocks,Ntrials,tb,fs);
%         [m,sd,bdata,peaks,slope] = averages_after_eliminating_NaN(d,tb,fs);

%        save([data_path '\Run' num2str(run) '.mat'], 'run', 'Run', 'Pct_blinks', 'data', 'd', 'm', 'peaks', 'slope')





