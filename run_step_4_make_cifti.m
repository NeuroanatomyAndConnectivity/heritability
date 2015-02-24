function[] = run_step_4_make_cifti()
% Create output cifti file with three values (h^2, se, p)
% From: out_new_1.dir/out_new_1.csv_results.txt 
% 

dirs = % list local out_? directories



%	Trait	node_2_INORM   H2r	0.0976056	SE 0.0937017	P	0.1441557	%CovVarianceExpl	0.0028442

i = 1;
filename = ['out_new_' num2str(i) '.dir/out_new_' num2str(i) '.csv_results.txt'];
fid = fopen(filename,'r');
A = fscanf(fid,'\t %s \t %s \t %s \t %f \t %s \t %f \t %s \t %f \t %s \t %f \n',[20,inf])';
fclose(fid);
