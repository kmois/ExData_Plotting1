## Create histogram of Global Active Power over the days Feb 1 and Feb 2, 2007.
## Assumes data.table package has been installed and file to be read is already in working directory.

# Read in data
library(data.table)
file_datatable <- fread("household_power_consumption.txt")

## convert our file to a dataframe for easier manipulation
file_df <- as.data.frame.matrix(file_datatable) 

## subset the days we are interested in
day1 <- file_df[file_df$Date=="1/2/2007",]
day2 <- file_df[file_df$Date=="2/2/2007",]
data=rbind(day1,day2)

## create historam in png file
data$Global_active_power <- as.numeric(data$Global_active_power)

png(filename = "plot1.png", width = 480, height = 480, units = "px")

hist(data$Global_active_power, col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")

dev.off()
