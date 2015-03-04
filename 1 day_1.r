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

# print time series
head(solar.xts)
head(time(solar.xts))

# plot time series
plot(solar.xts,ylab="avg")


# 5. ARIMA forecasting
################################################################################

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
