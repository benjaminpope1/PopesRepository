#before starting R, need to create the empty locations.csv file
install.packages(daymet)
library(chron)
library(RColorBrewer)
library(lattice)
library(ncdf)
library(daymetr)

download.daymet.tiles(lat1=32.731,lon1=-114.6847,lat2=32.479,lon2=-114.4611,start_yr=1980,end_yr=1980,param="ALL")

data.frame_csv=cbind(rep("DAYMET", 598),rep(ivec,length(jvec)),rep(jvec,length(ivec)))
write.csv(data.frame_csv, file = "locations.csv")

ivec=seq(32.479,32.731,by=.01)
ivec
jvec=(seq(-114.4611,-114.6847,by=-.01))
jvec

batch.download.daymet("C:/Users/Benjamin/Documents/foo.csv",start_yr=1980,end_yr=2015)
temp = list.files(pattern="*.csv")
myfiles = lapply(temp, read.csv,skip=7)
weatherfile=myfiles[[1]]
for(k in 2:length(temp)){rbind(weatherfile,myfiles[[k]])}

ln(saturation vapor pressure/6.11) = (2.453*(10^6)/461)*((1/273) - (1/avTemp))
satvaporpressure=exp(((2.453*(10^6)/461)*((1/273) - (1/avTemp))))*6.11
RelHumid=vp..Pa./satvaporpressure
    
write.csv(weatherfile, file = "weather.csv")