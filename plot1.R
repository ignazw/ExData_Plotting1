##
## plot1.R
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
## plot 1 is a distribution of global active power data, which we shown as a histogram, with the colour red
## size of the plot should be 480x480 pixels, which is the default.
##
png(filename = "plot1.png")
with(selectedData,hist(Global_active_power,
                       col="red",
                       main="Global Active Power",
                       xlab="Global Active Power (kilowatts)")
    )
## close the device
dev.off()
