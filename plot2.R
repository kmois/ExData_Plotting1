## Create time series graph of Global Active Power over the days Feb 1 and Feb 2, 2007.
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
data$Global_active_power <- as.numeric(data$Global_active_power)

## Create plot in png file
png(filename = "plot2.png", width = 480, height = 480, units = "px")

plot.ts(data$Global_active_power,ylab="Global Active Power (kilowatts)",xlab="",xaxt="n")
axis(1, at=c(1,1440,2880), labels=c("Thu","Fri","Sat"))

dev.off()
