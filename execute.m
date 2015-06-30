function [ output_args ] = execute( cmd, log_file )
   
unix(cmd); 
% open the file with permission to append
fid = fopen(log_file,'a');
myformat = '%s \n';
% write values at end of file
fprintf(fid, myformat, cmd);

% close the file 
fclose(fid);

end

