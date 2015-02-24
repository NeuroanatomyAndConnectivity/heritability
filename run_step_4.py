# -*- coding: utf-8 -*-
# <nbformat>3.0</nbformat>

# <codecell>

import pandas as pd
import numpy as np
import scipy.io as sio
import os, os.path
import sys

# Set variables:
prefix = str(sys.argv[1])
csv_lim = int(sys.argv[2])
print prefix
print csv_lim

# Read in data:
h2r = np.zeros(32492)
p = np.zeros(32492)
cov = np.zeros(32492)
se = np.zeros(32492)

# Number of directories
numDir = len([name for name in os.listdir('.') if (name.startswith(prefix) and name.endswith('.dir'))])
for filename in xrange(0,numDir):
    tab = pd.read_table((
        "/scr/litauen1/Dropbox/workingManuscripts/Project_Solar_Code/margulies/%s%s.dir/%s%s.csv_results.txt" 
        % (prefix, filename, prefix, filename)), 
        index_col=2, header=None, skipinitialspace=True, delimiter="\t")
	#na_values=['\t','NA', 'NaN'], keep_default_na='True', 
    
    ids = []
    for row in tab.index:
        ids.append(row.strip().replace("node_","").replace("_INORM",""))  
    
    for ind in xrange(0,len(ids)):
        indAll = (np.int(ids[ind]) - 1) + (csv_lim * filename)
        h2r[indAll] = tab[4][ind]
        p[indAll] = tab[7][ind]
        cov[indAll] = tab[9][ind]
        se[indAll] = tab[5][ind].strip().replace("SE ","")

# Write out data:
sio.savemat('data.mat', {'h2r':h2r, 'p':p, 'cov':cov, 'se':se})

# Read gifti data: 
#from nibabel import gifti as gii
# Write new data:
#gii.giftiio.write(data, 'test.gii')

# <codecell>
