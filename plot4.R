##
## plot4.R
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
## Plot 4 includes four plots layed out in two rows and two columns
##    1: line plot of global active power versus time
##    2: line plot of voltage versus time
##    3: line plot of energy sub metering versus time
##    4: line plot of global reactive power versus time
##
## define the device and give it the appropriate name
png(filename = "plot4.png")
## define the layout of the plots to be two rows and two columns
par(mfrow = c(2, 2))
## create the plots
with(selectedData,{
## first plot
        plot(timestamps,Global_active_power,
                type="l",
                col="black",
                main="",
                xlab="",
                ylab="Global Active Power")
## second plot
          plot(timestamps,Voltage,
                type="l",
                col="black",
                main="",
                xlab="datetime",
                ylab="Voltage")
## third plot
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
         legend("topright", 
               cex = 1, 
               c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
               horiz=FALSE, 
               lty=c(1,1), 
               lwd=c(2,2), 
               col=c("black","red","blue")) 
## fourth plot
        plot(timestamps,Global_reactive_power,
               type="l",
               col="black",
               main="",
               xlab="datetime",
               ylab="Global Reactive Power")
})
## close the device
dev.off()
