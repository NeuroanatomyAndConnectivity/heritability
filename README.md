A directory called clean_pedi is necessary to run these scripts. This is the directory from where you can run all your analyses.

**Step 0: Creates pheno files in .csv format**

Files should be out_*.csv

Edit brainDataName to match brain data you'd like to include.

`run_step_0_make_csv();`

**Step 1: Simply copies clean_pedi into several new directories - one per phenotype file containing X number of traits.**

`./run_step_1_make_dirs`

**Step 2: Makes solar running files. It uses the following script - run_make_solar_file_inorm**

`./run_step_2_make_runfiles`

**Step 3: Runs it on the Condor cluster**

`./run_step_3_make_crun`

**Step 4: Reassemble input surface**
The summary of the results of the analysis will be saved in the se_out.out in each directory.
Such as:

>Trait	node_1266_INORM     	H2r	0.5574053	SE 0.1048703	P	0.0000005	%CovVarianceExpl	0.0052763

The full models and outputs are saved in the trait directory. 
Then you simply parse the se_out.out file and fill your array with these outcomes. 

`python run_step_4.py [prefix] [csv_lim]`

**Step 5: Visualize results**

`matlab &
run_step_5...m`


