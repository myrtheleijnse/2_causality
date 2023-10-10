########## Merge GW and water use data San Joaquin ##########
# Author: Myrthe Leijnse

### Libraries ###
library(dplyr)

### Directory ###
setwd("E:/2_causality/Data")

### Functions ###

### Reading Data ###
source("C:/Users/5738091/Documents/2022_PhD/NatGeo_programming/2_causality/scripts/Investigation_phase/GW_SanJoaquin.R")
source("C:/Users/5738091/Documents/2022_PhD/NatGeo_programming/2_causality/scripts/Investigation_phase/Wateruse_SanJoaquin.R")

### Execution ###

# Summarize GWE per year
gw_381376N1212740W <- gw_381376N1212740W %>% mutate(year = as.integer(format(msmt_date, "%Y")))
gwe <- gw_381376N1212740W %>% group_by(year) %>% summarize(gwe = mean(gwe))
# Linear interpolation of data gaps
# gwe_2016 <- 1.2557*2016-2529.6
# gwe_2017 <- 1.2557*2017-2529.6
# df <- data.frame(c(2016, 2017), c(gwe_2016, gwe_2017))
# colnames(df) <- (c("year", "gwe"))
# gwe <- rbind(gwe, df)
# Subset 1985-2015
gwe <- gwe[gwe$year >= 1985 & gwe$year <= 2015, ]

# Merge timeseries water use and ground water elevation, remove year
data_domestic <- cbind(gwe, WU_sanjoaquin$Domestic)
data_domestic <- data_domestic %>% select(-year)

data_public_supply <- cbind(gwe, WU_sanjoaquin$`Public supply`)
data_public_supply <- data_public_supply %>% select(-year)

data_industrial <- cbind(gwe, WU_sanjoaquin$Industrial)
data_industrial <- data_industrial %>% select(-year)

data_mining <- cbind(gwe, WU_sanjoaquin$Mining)
data_mining <- data_mining %>% select(-year)

data_irrigation <- cbind(gwe, WU_sanjoaquin$Irrigation)
data_irrigation <- data_irrigation %>% select(-year)

### Writing ###
write.csv(data_domestic, file = 'Input_PCMCI/GWE_DomesticWaterUse_SanJoaquin_1985_2015_interpolated.csv', row.names = F)
write.csv(data_public_supply, file = 'Input_PCMCI/GWE_PublicSupplyWaterUse_SanJoaquin_1985_2015_interpolated.csv', row.names = F)
write.csv(data_industrial, file = 'Input_PCMCI/GWE_IndustrialWaterUse_SanJoaquin_1985_2015_interpolated.csv', row.names = F)
write.csv(data_mining, file = 'Input_PCMCI/GWE_MiningWaterUse_SanJoaquin_1985_2015_interpolated.csv', row.names = F)
write.csv(data_irrigation, file = 'Input_PCMCI/GWE_IrrigationWaterUse_SanJoaquin_1985_2015_interpolated.csv', row.names = F)

### Plotting ###