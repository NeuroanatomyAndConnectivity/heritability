#!/bin/bash

prefix=out_new2_
csv_lim=200
smoothing=10

matlab -nodisplay -nosplash -r "run_step_0_make_csv('${prefix}', ${csv_lim}, ${smoothing}); exit"  # removed: -nojvm
./run_step_1_make_dirs.sh ${prefix}
./run_step_2_make_runfiles.sh ${prefix}
./run_step_3_make_crun.sh ${prefix}

