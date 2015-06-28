function ws = runFeat( ws )
%RUNFEAT Summary of this function goes here
%   Detailed explanation goes here
% distribute fsf files in functional dirs and run first level Feat
    for i = 1:length(ws.conditions);
        fid = fopen(fullfile(ws.template_dir,[ws.conditions{i} '.fsf'])) ;
        X = fread(fid) ;
        fclose(fid) ;
        X = char(X.') ;
        % replace string subj_name with ws.subj_name
        Y = strrep(X, 'subj_name', ws.subj_name) ;
        fid2 = fopen(fullfile(ws.root_dir, 'functional', 'fsfs' ,[ws.conditions{i}, '.fsf']) ,'wt') ;
        fwrite(fid2,Y) ;
        fclose (fid2) ;
        cmd = ['fsl5.0-feat ' fullfile(ws.root_dir, 'functional', 'fsfs', [ws.conditions{i}, '.fsf '])];
        execute( cmd, ws.log_file );
    end

end

