function [] = removeTRs( ws )

to_remove = {[18 9], [0 0], [0 0], [0 0], [18 9], [0 0], [0 0], [0 0]};
for i = 1:size(ws.functional_dirs,1)
    cur_to_remove = to_remove{i};
    cmd = ['find ', fullfile(ws.temp_subj_dir, ws.functional_dirs(i).name), ' -type f | sort | head -', num2str(cur_to_remove(1)), ' | xargs rm'];
    execute( cmd, ws.log_file );
    cmd = ['find ', fullfile(ws.temp_subj_dir, ws.functional_dirs(i).name), ' -type f | sort | tail -', num2str(cur_to_remove(2)), ' | xargs rm'];
    execute( cmd, ws.log_file );
    cmd = ['find ', fullfile(ws.temp_subj_dir, ws.functional_dirs(i).name), ' -type f | wc -l'];
    execute( cmd, ws.log_file );end

end

