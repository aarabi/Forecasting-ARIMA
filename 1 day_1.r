require(fpp)
require(xts)
require(graphics)
setwd("R:/projects/1 day thing")


solar.df <- read.csv('AntiguaSolar.csv',header=TRUE,stringsAsFactors=FALSE)
names(solar.df) <- c('time', 'avg','sd','max','min')
solar.df$avg <- solar.df$avg
time.vec <- strptime(solar.df$time, '%m/%d/%Y %H:%M', tz='GMT')
solar.xts <- xts(solar.df$avg, order.by=time.vec)






hours.endpoints <- endpoints(solar.xts, on='hours')
solar.hourly.xts <- period.apply(solar.xts, INDEX=hours.endpoints, FUN=sum)
solar.hourly <- ts(solar.hourly.xts, frequency=24)
# 5. ARIMA forecasting
################################################################################
b<- data.frame(matrix(24, ncol = 5))
n<-10
# taking a window of data (first 10 days with 24 hours each)
solar.daily1 <- window(solar.hourly,  start=c(1, 1),  end=c(n,24))
for(i in 1:n)
{
  # doing the arima function & forecasting
  sarima.fit <- Arima(solar.daily1, order=c(1,1,0), seasonal=c(1,1,0))
  sarima.fcst <- forecast(sarima.fit, h=24)
  
  
  d<-as.data.frame(sarima.fcst)
  names(b) <- names(d) 
  solar.daily2
  b<-rbind(b,d)
  
  # binding the forecasted value to the old window, thus expanding the window
  solar.daily1<-c(solar.daily1,d[,1])
  
} 

mae <- function(error)
{
  mean(abs(error))
}


#finding error
b = b[-1,]
predicted <- b[,1]
actual <- window(solar.hourly, start=c(n+1,1), end=c(n+n,24))

# Calculate error

error <- (actual - predicted)
for(i in 1:length(error))
{
  if(actual[i]!=0)
  {
    error[i]<-error[i]/actual[i]
  }
  else
  {
    error[i]<-error[i]/100
  }
}

mae(error)

plot(window(solar.hourly, start=c(1,1), end=c(n+n,24)), col='red')
lines(rownames(b), b[,1], type="l")


