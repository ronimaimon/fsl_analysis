function [ ws ] = createSubjectTreeFromDcm( ws )
%CREATESUCJECTTREEFROMDCM Summary of this function goes here
%   Detailed explanation goes here
    ws.temp_subj_dir   = [ws.subj_dir '_temp'];
    copyfile(ws.subj_dir, ws.temp_subj_dir);
    ws.files = dir(ws.temp_subj_dir);
    ws.anatomical_dir  = ws.files(find(~cellfun(@isempty,strfind({ws.files.name}, 'MPRAGE'))));
    functional_indices = find(~cellfun(@isempty,strfind({ws.files.name}, 'bold')));
    irrelevant_indices = find(~cellfun(@isempty,strfind({ws.files.name}, 'ignore')));
    ws.functional_dirs = ws.files(setxor(functional_indices, irrelevant_indices));
    if size(ws.functional_dirs,1) ~= size(ws.conditions, 2)
        error ('number of conditions do not match number of runs');
    end

    % create root dir
    if ~exist(ws.root_dir, 'dir')
      mkdir(ws.root_dir); mkdir([ws.root_dir filesep 'anatomy']); 
      mkdir([ws.root_dir filesep 'functional']);
      mkdir([ws.root_dir filesep 'functional' filesep 'fsfs']);
    end


    %run customized function 
    ws.pre_nii_func(ws);

    %% dcm2nii

    %anatomical
    cmd = ['dcm2nii -o ' fullfile(ws.root_dir, 'anatomy') ' ' fullfile(ws.temp_subj_dir, ws.anatomical_dir.name)];
    execute( cmd, ws.log_file );
    %functional
    for i = 1:size(ws.functional_dirs,1)
        condition = ws.conditions{i};
        if ~exist(fullfile(ws.root_dir,'functional', condition), 'dir')
          mkdir(fullfile(ws.root_dir,'functional', condition))
        end
        cmd = ['dcm2nii -o ', fullfile(ws.root_dir, 'functional', condition), ' ',...
            fullfile(ws.temp_subj_dir, ws.functional_dirs(i).name)];
        execute( cmd, ws.log_file );
        file = dir(fullfile(ws.root_dir, 'functional', condition, '*.nii.gz'));
        movefile(fullfile(ws.root_dir, 'functional', condition,file.name), ...
            fullfile(ws.root_dir, 'functional', condition, [condition '.nii.gz']));
    end

    %% remove temp dir

    rmdir(ws.temp_subj_dir, 's');
end

