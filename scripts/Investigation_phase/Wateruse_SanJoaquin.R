########## title ##########
# Author: Myrthe Leijnse

# Data: USGS Sectoral Water Use San Joaquin county
# Spatialres: county
# Timeref: 1985-2015; 5-year 
# Unit : Mgal/d
# Definition: Sectoral water use (see definitions table) https://pubs.usgs.gov/circ/1441/circ1441.pdf

### Libraries ###
library(xlsx)
library(readxl)
library(ggplot2)
library(tidyr)
library(dplyr)
library(zoo)

### Directory ###
setwd("E:/2_causality/Data")

### Functions ###

### Reading Data ###
water_use_sanjoaquin <- read.csv("WaterUse/water_use_SanJoaquin.csv", sep = ";")
water_use_sanjoaquin <- water_use_sanjoaquin[2:8,]
water_use_sanjoaquin[water_use_sanjoaquin == "-"] <- NA

water_use_sanjoaquin_filtered <- subset(water_use_sanjoaquin, select = c("year",
                                                                         "Total.Population.total.population.of.area..in.thousands",
                                                                         #"Public.Supply.self.supplied.groundwater.withdrawals..fresh..in.Mgal.d",
                                                                         "Public.Supply.total.self.supplied.withdrawals..fresh..in.Mgal.d",
                                                                         #"Domestic.self.supplied.groundwater.withdrawals..fresh..in.Mgal.d",
                                                                         #"Domestic.self.supplied.surface.water.withdrawals..fresh..in.Mgal.d",
                                                                         "Domestic.total.self.supplied.withdrawals..fresh..in.Mgal.d",
                                                                         #"Industrial.self.supplied.groundwater.withdrawals..fresh..in.Mgal.d",
                                                                         #"Industrial.self.supplied.surface.water.withdrawals..fresh..in.Mgal.d",
                                                                         "Industrial.total.self.supplied.withdrawals..fresh..in.Mgal.d",
                                                                         #"Mining.self.supplied.groundwater.withdrawals..fresh..in.Mgal.d",
                                                                         #"Mining.total.self.supplied.withdrawals..groundwater..in.Mgal.d",
                                                                         "Mining.total.self.supplied.withdrawals..in.Mgal.d", 
                                                                         #"Irrigation..Total.self.supplied.groundwater.withdrawals..fresh..in.Mgal.d",
                                                                         #"Irrigation..Total.self.supplied.surface.water.withdrawals..fresh..in.Mgal.d",
                                                                         "Irrigation..Total.total.self.supplied.withdrawals..fresh..in.Mgal.d"))

# change variable names
colnames(water_use_sanjoaquin_filtered) <- c("year", "Population", "Public supply", "Domestic", "Industrial", "Mining", "Irrigation")

# conversion Mgal/dto m3/d
water_use_sanjoaquin_filtered$`Public supply` <- as.numeric(water_use_sanjoaquin_filtered$`Public supply`)*3785.411784
water_use_sanjoaquin_filtered$Domestic <- as.numeric(water_use_sanjoaquin_filtered$Domestic)*3785.411784
water_use_sanjoaquin_filtered$Industrial <- as.numeric(water_use_sanjoaquin_filtered$Industrial)*3785.411784
water_use_sanjoaquin_filtered$Mining <- as.numeric(water_use_sanjoaquin_filtered$Mining)*3785.411784
water_use_sanjoaquin_filtered$Irrigation <- as.numeric(water_use_sanjoaquin_filtered$Irrigation)*3785.411784
water_use_sanjoaquin_filtered$Population <- as.numeric(water_use_sanjoaquin_filtered$Population) * 1000
water_use_sanjoaquin_filtered$year <- as.POSIXct(water_use_sanjoaquin_filtered$year, format = "%Y")

### Execution ###

# Interpolate linear function to yearly values
df <- data.frame(year = as.POSIXct(as.character(c(1986:1989, 1991:1994, 1996:1999, 2001:2004, 2006:2009, 2011:2014)), format = "%Y"), 
                                   Population = NA, `Public supply` = NA, Domestic = NA, Industrial = NA, Mining = NA, Irrigation = NA)
colnames(df) <- c("year", "Population", "Public supply", "Domestic", "Industrial", "Mining", "Irrigation")
df <- rbind(water_use_sanjoaquin_filtered, df)
df <- df %>% arrange(year)
WU_sanjoaquin <- data.frame(year = df$year)
for (i in 2:ncol(df)){
  print(i)
  interpolation <- na.approx(df[,i])
  print(interpolation)
  WU_sanjoaquin <- cbind(WU_sanjoaquin, interpolation)
}
colnames(WU_sanjoaquin) <- c("year", "Population", "Public supply", "Domestic", "Industrial", "Mining", "Irrigation")

### Plotting ###
ggplot() +
  geom_point(data = WU_sanjoaquin, aes(year, Domestic)) +
  labs(title = "Domestic water use in San Joaquin", subtitle = "Total domestic self supplied freshwater withdrawals", 
       x = "Year", y = "Water use (m3/d)") +
  theme_minimal()
ggplot() +
  geom_point(data = WU_sanjoaquin, aes(year, `Public supply`)) +
  labs(title = "Public supply water use in San Joaquin", subtitle = "Total public supply self supplied freshwater withdrawals", 
       x = "Year", y = "Water use (m3/d)") +
  theme_minimal()
ggplot() +
  geom_point(data = WU_sanjoaquin, aes(year, Industrial)) +
  labs(title = "Industrial water use in San Joaquin", subtitle = "Total Industrial self supplied freshwater withdrawals", 
       x = "Year", y = "Water use (m3/d)") +
  theme_minimal()
ggplot() +
  geom_point(data = WU_sanjoaquin, aes(year, Mining)) +
  labs(title = "Mining water use in San Joaquin", subtitle = "Total Mining self supplied freshwater withdrawals", 
       x = "Year", y = "Water use (m3/d)") +
  theme_minimal()
ggplot() +
  geom_point(data = WU_sanjoaquin, aes(year, Irrigation)) +
  labs(title = "Irrigation water use in San Joaquin", subtitle = "Total Irrigation self supplied freshwater withdrawals", 
       x = "Year", y = "Water use (m3/d)") +
  theme_minimal()
