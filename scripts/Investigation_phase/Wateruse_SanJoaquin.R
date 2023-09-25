########## title ##########
# Author: Myrthe Leijnse

# Data: USGS Sectoral Water Use San Joaquin county
# Spatialres: county
# Timeref: 1985-2015; 5-year 
# Unit : Mgal/d
# Definition: Sectoral water use (see definitions table)

### Libraries ###
library(xlsx)
library(readxl)

### Directory ###
setwd("E:/2_causality/Data")

### Functions ###

### Reading Data ###
water_use_sanjoaquin <- read.csv("WaterUse/water_use_SanJoaquin.csv", sep = ";")
water_use_sanjoaquin <- water_use_sanjoaquin[2:8,]
water_use_sanjoaquin[water_use_sanjoaquin == "-"] <- NA

#TODO change variable names
View(t(water_use_sanjoaquin))
water_use_sanjoaquin_filtered <- subset(water_use_sanjoaquin, select = c(1,5,6,10,16,28,31,34,61,64,69, 
                                                                         "Mining.self.supplied.groundwater.withdrawals..fresh..in.Mgal.d",
                                                                         "Mining.total.self.supplied.withdrawals..groundwater..in.Mgal.d",
                                                                         "Mining.total.self.supplied.withdrawals..in.Mgal.d", 
                                                                         "Irrigation..Total.self.supplied.groundwater.withdrawals..fresh..in.Mgal.d",
                                                                         "Irrigation..Total.self.supplied.surface.water.withdrawals..fresh..in.Mgal.d",
                                                                         "Irrigation..Total.total.self.supplied.withdrawals..fresh..in.Mgal.d"))

### Execution ###

### Plotting ###