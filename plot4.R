## Makes a combined plot of 4 plots over the days Feb 1 and Feb 2, 2007.
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
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Voltage <- as.numeric(data$Voltage)

## Start a png file
png(filename = "plot4.png", width = 480, height = 480, units = "px")

## make a 2x2 field of plots. Fill them by column.
par(mfcol=c(2,2))
## the first two plots are plot2 and plot3 we made previously

## plot top left:
plot.ts(data$Global_active_power,ylab="Global Active Power (kilowatts)",xlab="",xaxt="n")
axis(1, at=c(1,1440,2880), labels=c("Thu","Fri","Sat"))

## plot bottom left:
plot.ts(data$Sub_metering_1,col="black",ylim=c(0,40),xaxt="n",xlab="",ylab="Energy sub metering")
par(new=TRUE)
plot.ts(data$Sub_metering_2,col="red",ylim=c(0,40),xaxt="n",xlab="",ylab="")
par(new=TRUE)
plot.ts(data$Sub_metering_3,col="blue",ylim=c(0,40),xaxt="n",xlab="",ylab="")
axis(1, at=c(1,1440,2880), labels=c("Thu","Fri","Sat"))
legend("topright",col=c("black","red","blue"),lwd=1,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="n")

## plot top right
plot.ts(data$Voltage,ylab="Voltage", xlab="datetime",xaxt="n")
axis(1, at=c(1,1440,2880), labels=c("Thu","Fri","Sat"))

## plot bottom right
plot.ts(data$Global_reactive_power,ylab="Global_reactive_power", xlab="datetime",xaxt="n")
axis(1, at=c(1,1440,2880), labels=c("Thu","Fri","Sat"))

dev.off()