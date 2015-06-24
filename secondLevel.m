function [ ws ] = secondLevel(ws)

ws.second_level_conditions = {'P', 'F', 'S', 'G'};
ws.third_level_conditions = {'GF', 'GP', 'FP', 'GS', 'FS', 'PS'};

% distribute fsf files in functional dirs and run second level Feat
for i = 1:length(ws.second_level_conditions);
    fid = fopen(fullfile(ws.template_dir,[ws.second_level_conditions{i} '.fsf'])) ;
    X = fread(fid) ;
    fclose(fid) ;
    X = char(X.') ;
    % replace string subj_name with ws.subj_name
    Y = strrep(X, 'subj_name', ws.subj_name) ;
    fid2 = fopen(fullfile(ws.root_dir, 'functional', 'fsfs',...
                                [ws.second_level_conditions{i}, '.fsf']) ,'wt') ;
    fwrite(fid2,Y) ;
    fclose (fid2) ;
    cmd = ['fsl5.0-feat ' fullfile(ws.root_dir, 'functional', 'fsfs',...
                                    [ws.second_level_conditions{i}, '.fsf'])];
    execute( cmd, ws.log_file );
end

% distribute fsf files in functional dirs and run third level Feat
for i = 1:length(ws.third_level_conditions);
    fid = fopen(fullfile(ws.template_dir,[ws.third_level_conditions{i} '.fsf'])) ;
    X = fread(fid) ;
    fclose(fid) ;
    X = char(X.') ;
    % replace string subj_name with ws.subj_name
    Y = strrep(X, 'subj_name', ws.subj_name) ;
    fid2 = fopen(fullfile(ws.root_dir, 'functional', 'fsfs',...
                                [ws.third_level_conditions{i}, '.fsf']) ,'wt') ;
    fwrite(fid2,Y) ;
    fclose (fid2) ;
    cmd = ['fsl5.0-feat ' fullfile(ws.root_dir, 'functional', 'fsfs',...
                                    [ws.third_level_conditions{i}, '.fsf'])];
    execute( cmd, ws.log_file );
end



end

