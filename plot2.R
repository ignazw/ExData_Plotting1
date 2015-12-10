##
## plot2.R
##
## read the data
## missing values are coded in the file as "?"
##
rawData <- read.csv("household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE, na.strings="?")
##
## select only 1/2/2007 and 2/2/2007 and remove original data file to free up memory
##
library(dplyr)
selectedData <- filter(rawData,rawData$Date=="1/2/2007"|rawData$Date=="2/2/2007")
rm(rawData)
##
## Add a timestamp column, which is a combination of date and time
##
timestamps <- strptime(paste(selectedData$Date,selectedData$Time,sep=" "),"%d/%m/%Y %H:%M:%S")
selectedData <- cbind(selectedData,timestamps)
##
## plot 2 is a simple line plot of the global active power data in kilowatts, against time. Time is labelled 
## on the X-axis as day of the week. (In Dutch: do=Thursday, vr=Friday, za=Saturday)
##
png(filename = "plot2.png")
with(selectedData,plot(timestamps,Global_active_power,
                       type="l",
                       col="black",
                       main="",
                       xlab="",
                       ylab="Global Active Power (kilowatts)")
)
## close the device
dev.off()
