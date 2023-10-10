# -*- coding: utf-8 -*-
"""
Created on Tue Sep 26 14:14:58 2023

@author: 5738091
"""

# Imports
import numpy as np
import matplotlib
from matplotlib import pyplot as plt
# %matplotlib inline     
## use `%matplotlib notebook` for interactive figures
# plt.style.use('ggplot')
import sklearn

import tigramite
from tigramite import data_processing as pp
from tigramite import plotting as tp
from tigramite.pcmci import PCMCI
from tigramite.independence_tests import ParCorr, GPDC, CMIknn, CMIsymb
from tigramite.models import LinearMediation, Prediction

np.random.seed(42)
# links_coeffs = {0: [],
#                 1: [((0, -1), 0.5)],
#                 2: [((1, -1), 0.5)],
#                 }
links_coeffs = {0: [((0,-1), 0.8)],
                1: [((1,-1), 0.8), ((0, -1), 0.5)],
                2: [((2,-1), 0.8), ((1, -1), 0.5)],
                }
var_names = [r"$X$", r"$Y$", r"$Z$"]
    
data, true_parents = pp.var_process(links_coeffs, T=1000)

# Initialize dataframe object, specify time axis and variable names
dataframe = pp.DataFrame(data, 
                         var_names=var_names)
med = LinearMediation(dataframe=dataframe)
med.fit_model(all_parents=true_parents, tau_max=4)