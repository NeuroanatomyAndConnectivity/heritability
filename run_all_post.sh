#!/bin/bash

prefix=${1} 
csv_lim=${2}

python run_step_4.py ${prefix} ${csv_lim}

matlab -nodisplay -nosplash -r "run_step_5_vis_results('${prefix}'); exit"  # removed: -nojvm
