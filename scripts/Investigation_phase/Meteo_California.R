########## meteo forcing ##########
# Author: Myrthe Leijnse

### Libraries ###
library(sf)
library(raster)
library(ncdf4)
library(ggplot2)

### Directory ###
setwd("E:/2_causality/Data")

### Functions ###

### Reading Data ###
# read california shapefile
ff <- list.files("Shapefiles/", pattern="\\.shp$", full.names=T)
shp_list <- lapply(ff, shapefile)
hotspots <- c( "California")
names(shp_list) = hotspots

ncinput <- "W5E5/pr_W5E5_1979-2019_yearly_California.nc"
prec_array <- ncvar_get(nc_open(ncinput), "pr") # store the data in a 3-dimensional array
ncinput <- "W5E5/refPotEvap_W5E5_1979-2019_yearly_California.nc"
evap_arrray <- ncvar_get(nc_open(ncinput), "PM_FAO_56")
ncinput <- "W5E5/tas_W5E5_1979-2019_yearly_California.nc"
temp_array <- ncvar_get(nc_open(ncinput), "tas")
plot(brick(ncinput),40)

### Execution ###
lat = 38.1376
lon = -121.2740

lon_diff = lon - lon
x = which.min(abs(lon_diff))
lat_diff = lat - lat
y = which.min(abs(lat_diff))
prec_series = prec_array[x,y,]
evap_series = evap_arrray[x,y,]*1000
temp_series = temp_array[x,y,]-273.15

df <- data.frame(Year= seq(from=1979, to=2019, by=1), Precipitation=prec_series, 
                 refEvapotranspiration = evap_series, Temperature = temp_series)

### Plotting ###
ggplot(data=df) +
  geom_line(aes(x=Year, y=Precipitation, col = "Precipitation"), col = "steelblue", lwd = 2) + 
  geom_line(aes(x=Year, y=refEvapotranspiration, col = "Reference evapotranspiration"), col = "green", lwd = 2) +
  ggtitle("Yearly summed precipitation and evaporation (mm)") + 
  theme_bw()

ggplot(df)+
  geom_line(aes(x=Year, y=Temperature), col = "orange", lwd = 2) +
  ggtitle("Yearly average temperature (degrees C)") +
  theme_bw()

### Adding GWE and WU data ###
df <- df[df$Year >= 1985 & df$Year <= 2015, ]
df <- cbind(df, gwe, WU_sanjoaquin)
df <- subset(df, select = -c(year))
df <- subset(df, select = -c(year))

### Writing ###
write.csv(df, file = 'Input_PCMCI/meteo_GWE_WaterUse_SanJoaquin_1985_2015.csv', row.names = F)