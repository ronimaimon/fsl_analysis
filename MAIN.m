clc; clear all; close all;



ws = createWS();


addpath('matan/');
createSubjectTreeFromDcm(ws)

%run bet with three different parameter sets
ws.anatomical_niis = dir(fullfile(ws.root_dir, 'anatomy')); 
ws.anatomical_nii = ws.anatomical_niis(find(strncmpi('co', {ws.anatomical_niis.name},2)));

cmd = ['fsl5.0-bet '  fullfile(ws.root_dir, 'anatomy', ws.anatomical_nii.name) ' '...
                        fullfile(ws.root_dir, 'anatomy', 'brain_v1') ' -f 0.5 -g 0'];
execute( cmd, ws.log_file );
cmd = ['fsl5.0-bet '  fullfile(ws.root_dir, 'anatomy', ws.anatomical_nii.name) ' '...
                        fullfile(ws.root_dir, 'anatomy', 'brain_v2') ' -f 0.2 -g 0'];
execute( cmd, ws.log_file );
cmd = ['fsl5.0-bet '  fullfile(ws.root_dir, 'anatomy', ws.anatomical_nii.name) ' '...
                        fullfile(ws.root_dir, 'anatomy', 'brain_v3') ' -f 0.8 -g 0'];
execute( cmd, ws.log_file );

system(['LD_LIBRARY_PATH=/usr/lib fslview ' ...
    fullfile(ws.root_dir, 'anatomy', ws.anatomical_nii.name) ' '...
    fullfile(ws.root_dir, 'anatomy', 'brain_v2') ' -l Blue -t 0.8 '...
    fullfile(ws.root_dir, 'anatomy', 'brain_v1') ' -l Red -t 0.8 '...
    fullfile(ws.root_dir, 'anatomy', 'brain_v3') ' -l Green -t 0.8 &']);

%ask for user's choice
choice = menu('please choose the best extracted brain',...
    'v1 (the red one)', 'v2 (the blue one)', 'v3 (the green one)', 'they are all bad. let me choose the parameters myself');
if choice == 4;
    good_or_not = 2;
    while good_or_not == 2
        answers = inputdlg({'threshold (default is 0.5)', 'gradient (default is 0)'});
        cmd = ['fsl5.0-bet '  fullfile(ws.root_dir, 'anatomy', ws.anatomical_nii.name) ' '...
            fullfile(ws.root_dir, 'anatomy', 'brain_v4') ' -f ' num2str(answers{1}) ' -g ' num2str(answers{2})];
        execute( cmd, ws.log_file );
        system(['LD_LIBRARY_PATH=/usr/lib fslview ' ...
            fullfile(ws.root_dir, 'anatomy', ws.anatomical_nii.name) ' '...
            fullfile(ws.root_dir, 'anatomy', 'brain_v4') ' -l Blue -t 0.8 &']);
        good_or_not = menu('good?', 'yes', 'no');
    end
end
%change chosen file's name
movefile([fullfile(ws.root_dir, 'anatomy', 'brain_v') num2str(choice) '.nii.gz'], ...
            fullfile(ws.root_dir, 'anatomy', 'brain.nii.gz'));
ws.extracted_brain = fullfile(ws.root_dir, 'anatomy', 'brain.nii.gz');

% RUN FEAT
% ws = runFeat(ws);

%% RUN SECOND LEVEL FEAT
% ws = secondLevel(ws);

