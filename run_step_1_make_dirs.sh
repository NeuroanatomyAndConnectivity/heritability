#! /bin/sh
# this is a universal ICBM processing script


# don't modify after this line

pheno_list=`ls ${1}*.csv`
echo  $pheno_list

# Lets make solar_run file
for cur_dir in $pheno_list
do

	basename=`echo $cur_dir | awk -F. '{print $1}'`

	cp -r clean_pedi $basename.dir
	mv $basename.csv $basename.dir
	mv $basename.header $basename.dir 

done

