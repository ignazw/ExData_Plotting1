##
## plot3.R
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
## plot 3 is a line plot of each sub metering versus time
##
png(filename = "plot3.png")
with(selectedData,{
     plot(timestamps,Sub_metering_1,
                       type="l",
                       col="black",
                       main="",
                       xlab="",
                       ylab="Energy sub metering")
      lines(timestamps,Sub_metering_2,
        col="red",
        main="",
        xlab="",
        ylab="Energy sub metering")
      lines(timestamps,Sub_metering_3,
            col="blue",
            main="",
            xlab="",
            ylab="Energy sub metering")
})
## add the legend
legend("topright", 
       cex = 1, 
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       horiz=FALSE, 
       lty=c(1,1), 
       lwd=c(2,2), 
       col=c("black","red","blue")) 
## close the device
dev.off()
