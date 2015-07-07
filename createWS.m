function [ ws ] = createWS()
%% SET WS VARAIABLES
clear ws;
ws.conditions = {'run1', 'run2', 'run3','loc' ,'run4', 'run5', 'run6', 'run7', 'run8'};
%ws.conditions = {'run4', 'run5', 'run6', 'run7', 'run8'};
ws.subj_dir = uigetdir('.', 'please choose the raw subj dir');
ws.subj_name = strsplit(ws.subj_dir, '_'); ws.subj_name = ws.subj_name{4};
root_dir = strsplit(ws.subj_dir, filesep);
root_dir = [root_dir(1:end-2) 'FSL_analyzed' ws.subj_name];
ws.root_dir = [filesep fullfile(root_dir{:})];
ws.template_dir = [filesep fullfile(root_dir{1:end-2}, 'Templates')];
%create log file
ws.log_file = fullfile(ws.root_dir, 'log.txt');
ws.pre_nii_func = @emptyFunc;
end

