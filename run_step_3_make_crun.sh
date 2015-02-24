#! /bin/sh
# this is a universal ICBM processing script


# don't modify after this line

dir_list=`ls -d ${1}*.dir`
echo  $dir_list

spath=`pwd`

# Lets make solar_run file
for cur_dir in $dir_list
do
	fname="crun_${cur_dir}"
	basename=`echo $cur_dir | awk -F. '{print $1}'` 
	
  	echo "executable = /scr/litauen1/Dropbox/workingManuscripts/Project_Solar_Code/margulies/x.runCondor_solar.sh" > ${fname}
	echo "arguments = $spath $cur_dir $basename" >> ${fname}
	echo "output = /scr/litauen1/Dropbox/misc/yeoTopo/condor/${cur_dir}.out" >> ${fname}
	echo "error = /scr/litauen1/Dropbox/misc/yeoTopo/condor/${cur_dir}.error" >> ${fname}
	echo "log = /scr/litauen1/Dropbox/misc/yeoTopo/condor/${cur_dir}.log" >> ${fname}
	
	echo "universe = vanilla" >> ${fname}
	echo "request_memory = 2000" >> ${fname}
	echo "request_cpus = 1" >> ${fname}
	echo "getenv = True" >> ${fname}
	echo "Notification = Error" >> ${fname}
	echo "queue" >> ${fname}
	
	condor_submit ${fname}
done
