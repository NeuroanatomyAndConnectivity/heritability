function[] = run_step_0_make_csv(prefix, csv_lim, smoothing)
% Based on matlab script in /scr/litauen1/toro/dist_...
%% Variables:
% Set directory prefix:
% prefix = 'out_new_';

% set to number of pheno values per csv file (analysis):
% csv_lim = 300;

% Set FWHM smoothing in mesh units:
% smoothing = 10;

% Modify brainDataName to the location of the brain data to be included
dir = '/a/documents/connectome/_all/';
brainDataDir = ['/MNINonLinear/fsaverage_LR32k/'];
hemi = 'L';
brainDataFile = ['.' hemi '.thickness.32k_fs_LR.shape.gii'];	

if smoothing > 0
    surf_gii = gifti(['/scr/murg2/HCP_new/HCP_Q1-Q6_GroupAvg_Related440_Unrelated100_v1/Q1-Q6_R440.' hemi '.inflated.32k_fs_LR.surf.gii']);
    surf.coord = surf_gii.vertices';
    surf.tri = surf_gii.faces;
end

%% %%%%%%%%%%%%%%%% RUN %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Read pheno_orig.csv to get sublist and basic info. 
% 	Use as basis for subsequent pheno files. 

pheno_orig = readtable('pheno_orig.csv');

sublist = str2num(num2str(pheno_orig{:,2}));

% Read in brain data for sublist:
newSublist = [];
newList = [];
data = [];
count = 1;
for i = 1:length(sublist)
	
	sub =  num2str(sublist(i));
	
	% read data
	brainDataName = [dir sub brainDataDir sub brainDataFile];

	if exist(brainDataName, 'file')
		% get list of subjects for whom the data exists
		newSublist = [newSublist; sub]; 
        newList = [newList; i];
        dataSub = gifti(brainDataName);
        if smoothing == 0
            data(count,:) = dataSub.cdata;
        else
            data(count,:) = SurfStatSmooth(dataSub.cdata', surf, smoothing);
	    disp(sub);
        end
        count = count + 1;
	end
end

% Select out newSublist from pheno_orig
new_pheno_orig = pheno_orig(newList,:);

% Write out data into out_?.csv for each set of [csv_lim] gifti files.
count = 0;
for i = 1:csv_lim:size(data,2)
	
	% new csv includes pheno_orig and data(:,i:i+(csv_lim-1)) for any included subjects
	filename = ['./' prefix num2str(count) '.csv'];
	
    mrid = new_pheno_orig{:,1};	
	id = str2num(num2str(new_pheno_orig{:,2})); 
    age = new_pheno_orig{:,3};
    sex = new_pheno_orig{:,4};
    if size(data,2) < i+csv_lim-1
        node = data(:,i:size(data,2));
    else
        node = data(:,i:i+csv_lim-1); 
    end
	
    T = table(mrid, id, age, sex, node);
    writetable(T,filename);
    unix(['./x.removeSpaces.sh ' filename]);
    unix(['./x.makeHeader.sh ' num2str(count) ' ' num2str(size(node,2)) ' ' prefix]);
	
	count = count + 1;
end
