#! /bin/sh
# this is a universal ICBM processing script


spath=`pwd`
# don't modify after this line

dir_list=`ls -d ${1}*.dir`

for cur_dir in $dir_list
do
	cd $cur_dir
	pheno_list=`ls -d ${1}*.csv`
	echo  $pheno_list

	# Lets make solar_run file
	for cur_phen in $pheno_list
	do
		header=`echo $cur_phen | awk -F. '{print $1}'`
		../make_se_file_inorm.sh $header.header $cur_phen
	done

	cd $spath
done




