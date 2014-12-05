## Create time series graph of Sub_metering 1-2-3 over the days Feb 1 and Feb 2, 2007.
## Assumes data.table package has been installed and file to be read is already in working directory.

# Read in data. Takes about 10 seconds with my connection.
library(data.table)
file_datatable <- fread("household_power_consumption.txt")

## convert our file to a dataframe for easier manipulation
file_df <- as.data.frame.matrix(file_datatable) 

## subset the days we are interested in
day1 <- file_df[file_df$Date=="1/2/2007",]
day2 <- file_df[file_df$Date=="2/2/2007",]
data=rbind(day1,day2)

## make sure data is numeric
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

## Create plot in png file
png(filename = "plot3.png", width = 480, height = 480, units = "px")

plot.ts(data$Sub_metering_1,col="black",ylim=c(0,40),xaxt="n",xlab="",ylab="Energy sub metering")
par(new=TRUE)
plot.ts(data$Sub_metering_2,col="red",ylim=c(0,40),xaxt="n",xlab="",ylab="")
par(new=TRUE)
plot.ts(data$Sub_metering_3,col="blue",ylim=c(0,40),xaxt="n",xlab="",ylab="")
axis(1, at=c(1,1440,2880), labels=c("Thu","Fri","Sat"))
legend("topright",col=c("black","red","blue"),lwd=1,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.off()