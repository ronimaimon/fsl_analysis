function [ output_args ] = execute( cmd, log_file )
   
unix(cmd); dlmwrite(log_file ,cmd ,'-append');

end

