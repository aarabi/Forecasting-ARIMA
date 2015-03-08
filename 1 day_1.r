require(fpp)
require(xts)
require(graphics)
setwd("R:/projects/1 day thing")
################################################################################
################################################################################
# 1, TIME SERIES IN R
################################################################################

################################################################################
# READ DATA AND CREATE TIME SERIES OBJECT

# read data
solar.df <- read.csv('AntiguaSolar.csv',header=TRUE,stringsAsFactors=FALSE)
# rename columns
names(solar.df) <- c('time', 'avg','sd','max','min')

# convert kWh into MWh
solar.df$avg <- solar.df$avg

# print head and tail of data frame
head(solar.df)
tail(solar.df)

# convert timestamp to date-time object
time.vec <- strptime(solar.df$time, '%m/%d/%Y %H:%M', tz='GMT')

# convert data to a time series using xts
solar.xts <- xts(solar.df$avg, order.by=time.vec)

# plot time series
plot(solar.xts,ylab="avg")


# 5. ARIMA forecasting
################################################################################
temp<- data.frame(matrix(0, ncol = 2))
solar.daily.xts <- apply.daily(solar.xts, sum)
solar.daily.xts<-solar.daily.xts[1:365,]
solar.daily <- ts(solar.daily.xts, frequency=7)
curr<-1
for(i in 1:5)
{
 
  solar.daily2 <- window(solar.daily,  start=c(i, 1),  end=c(i+4,7))
  sarima.fit <- Arima(solar.daily2, order=c(2,1,0), seasonal=c(1,1,0))
  
  sarima.fcst <- forecast(sarima.fit, h=7)
  plot(sarima.fcst)
  d= as.data.frame(sarima.fcst)
  d=d[,1]
  d=t(d)
  temp[curr:curr+6,1]<-d$Point
  temp[curr:curr+6,2]<-d$Forecast
  curr<-curr+7
  lines(window(solar.daily, start=c(i+5,1), end=c(i+5,7)), col='red')
}

################################################################################
# A.

solar.daily.xts <- apply.daily(solar.xts, sum)

solar.daily.xts[2] <- as.numeric(solar.daily.xts[2])
# ACF could be sinusoidal
# significant spike at lag 1 in PAC
# let's try non-seasonal ARIMA(0,0,1)
arima.fit <- Arima(solar.daily.xts, order=c(0,0,0))
accuracy(arima.fit)
acf(residuals(arima.fit))
pacf(residuals(arima.fit))

arima.fit <- Arima(solar.daily.xts, order=c(0,1,0))
accuracy(arima.fit)
acf(residuals(arima.fit))
pacf(residuals(arima.fit))

arima.fit <- Arima(solar.daily.xts, order=c(2,2,1))
accuracy(arima.fit)
acf(residuals(arima.fit))
pacf(residuals(arima.fit))

plot(forecast(arima.fit, h=536))


# plot ACF of residuals
tsdisplay(residuals(arima.fit))
# seasonality not captured (expected, as we are using non-seasonal arima)

# automatic selection of ARIMA model
arima.auto.fit <- auto.arima(solar.xts, seasonal=FALSE,stepwise=FALSE, approximation=FALSE)
# plot ACF of residuals
tsdisplay(residuals(arima.auto.fit))
# again, seasonality not captured

# which one is best?
arima.fit
arima.auto.fit
