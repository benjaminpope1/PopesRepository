library(foreign)
climatedata=read.csv("C:/Users/Ben/Downloads/11015_09-18-2016.csv")
names(climatedata) #Gives us the variables that are in our dataset
attach(climatedata) #This makes coding in R less cumbersome, by not having to reference data set every time you use a variable
avTemp = (tmax..deg.c.+273.15 + tmin..deg.c.+273.15)/2


ln(saturation vapor pressure/6.11) = (2.453*(10^6)/461)*((1/273) - (1/avTemp))
satvaporpressure=exp(((2.453*(10^6)/461)*((1/273) - (1/avTemp))))*6.11
RelHumid=vp..Pa./satvaporpressure

#Since relation between Celsius and Kelvin is linear, for correlations between variables, will use temperature in Celsius

Tmax=tmax..deg.c.
Tmin=tmin..deg.c.
Precip=prcp..mm.day.

par(mfrow=c(1,1))
plot(yday,Tmin,main="Min temp over time")

plot(yday,Tmax,main="Max temp over time")
min(yday[Tmax>=37.7]) #Earliest 100-degree day
max(yday[Tmax>=37.7]) #Latest 100-degree day

TempDiff=Tmax-Tmin
plot(yday,TempDiff,main="Temp swing over time")

plot(yday,RelHumid,main="Humidity over time")

plot(yday,Precip,main="Precipitation over time")

yday[RelHumid==max(RelHumid)]
yday[RelHumid==min(RelHumid)]
max(RelHumid)
min(RelHumid)

length(Precip[Precip!=0])
yday[Precip==max(Precip)]
max(Precip)

cor(Tmax,Tmin)
cor(Tmin,TempDiff)
cor(Tmin,RelHumid)
cor(Tmin,Precip)

cor(Tmax,TempDiff)
cor(Tmax,RelHumid)
cor(Tmax,Precip)

cor(TempDiff,RelHumid)
cor(TempDiff,Precip)

cor(RelHumid,Precip)

yday2=yday^2
quadmodelmin=lm(Tmin~yday+yday2)

quadmodelmax=lm(Tmax~yday+yday2)

quarticmodelhumidity=lm(RelHumid~yday+I(yday^2)+I(yday^3)+I(yday^4))
quarticmodeltempdiff=lm(TempDiff~yday+I(yday^2)+I(yday^3)+I(yday^4))

