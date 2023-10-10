########## title ##########
# Author: Myrthe Leijnse

### Libraries ###
library(xlsx)
library(readxl)

### Directory ###
setwd("E:/2_causality/Data")
setwd("C:/Users/5738091/Downloads")

### Functions ###

### Reading Data ###
WaterUse_df <- read.csv("water-rights-water-use-reported-2019-on.csv", sep = ",", nrows = 2000) 

WaterUse_df_2 <- read.csv("water-rights-water-use-reported-2019-on.csv", sep = ",")

### Execution ###

### Plotting ###