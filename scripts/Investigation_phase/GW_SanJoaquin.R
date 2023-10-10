########## Investigation GW data California ##########
# Author: Myrthe Leijnse

# Data: Periodic Groundwater Level Measurements
# Spatialres: station
# Timeref: 1927-2023 
# Definition: Groundwater elevation in feet above mean sea level, referenced to the North American Vertical Datum of 1988 (NAVD88).

### Libraries ###
library(tidyverse)
library(ggplot2)

### Directory ###
setwd("E:/2_causality/Data")

### Functions ###

### Reading Data ###
gw_cali = read.csv('GWdepletion/GWmeasurementsCalifornia.csv',sep=',')

### Execution ###
gw_locations_cali <- read.csv('GWdepletion/GWstationsCalifornia.csv',sep=';')
gw_locations_sanjoaquin <- filter(gw_locations_cali, county_name == "San Joaquin")

# Filter San Joaquin long records
# gw_sanjoaquin <- filter(gw_cali, site_code == "377143N1214459W001")
# for(station in gw_locations_sanjoaquin$site_code){
#   print(station)
#   station_gwdata <- gw_cali[gw_cali$site_code %in% station, ]
#   if (nrow(station_gwdata) > 1000){
#     gw_sanjoaquin <- rbind(gw_sanjoaquin, station_gwdata)
#   }
# }

# Chosen station
gw_381376N1212740W <- filter(gw_cali, site_code == "381376N1212740W001")
gw_381376N1212740W$msmt_date <- as.POSIXct(gw_381376N1212740W$msmt_date)


### Plotting ###
ggplot(gw_381376N1212740W, aes(msmt_date, gwe)) +
  #geom_line(color = "steelblue", lwd = 2) +
  geom_point(color = "steelblue") +
  geom_line(aes(msmt_date, wlm_gse), color = "brown", lwd = 2) +
  labs(title = "Ground water elevation (381376N, 1212740W)", x = "Time", y = "Groundwater elevation (ft above msl)") +
  theme_minimal()

### Write ###
# write.csv(gw_sanjoaquin, file = 'GWdepletion/GWmeasurementsSanJoaquin.csv', row.names = F)
