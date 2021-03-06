#before starting R, need to create the empty locations.csv file
install.packages(c(daymetr,foreign))
library(daymetr)
library(foreign)


ivec=seq(32.479,32.731,by=.01)
ivec
jvec=(seq(-114.4611,-114.6847,by=-.01))
jvec

data.frame_csv=cbind(rep("DAYMET", 598),rep(ivec,length(jvec)),rep(jvec,length(ivec)))
write.csv(data.frame_csv, file = "locations.csv")

batch.download.daymet("locations.csv",start_yr=1980,end_yr=2015)
temp = list.files(pattern="*.csv")
myfiles = lapply(temp, read.csv,skip=7)
weatherfile=myfiles[[1]]
for(k in 2:length(temp)){rbind(weatherfile,myfiles[[k]])}

attach(weatherfile) #This makes coding in R less cumbersome, by not having to reference data set every time you use a variable
avTemp = (tmax..deg.c.+273.15 + tmin..deg.c.+273.15)/2

ln(saturation vapor pressure/6.11) = (2.453*(10^6)/461)*((1/273) - (1/avTemp))
satvaporpressure=exp(((2.453*(10^6)/461)*((1/273) - (1/avTemp))))*6.11
RelHumid=vp..Pa./satvaporpressure
    
write.csv(weatherfile, file = "weather.csv")