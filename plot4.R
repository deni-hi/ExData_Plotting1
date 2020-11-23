
# Download the file and read it into a table
setwd("~/cursos/coursera/data_science/exploratory_data_analysis/week1")
fileUrl<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("data")){
    dir.create("data")
}

download.file(fileUrl, "./data/household_power_consumption.zip")
unzip("./data/household_power_consumption.zip", exdir = "./data")

allData<-read.table("./data/household_power_consumption.txt", sep=";", header=TRUE)
str(allData)

# Only use values from 1/2-2/2/2007
library("dplyr")
selectedData<-filter(allData, allData$Date=="1/2/2007"|allData$Date=="2/2/2007" )
str(selectedData)

# Coerce the values into the types needed (numeric, date, etc)
selectedData$Global_active_power<-as.numeric(selectedData$Global_active_power)
selectedData$Sub_metering_1<-as.numeric(selectedData$Sub_metering_1)
selectedData$Sub_metering_2<-as.numeric(selectedData$Sub_metering_2)
selectedData$Sub_metering_3<-as.numeric(selectedData$Sub_metering_3)
selectedData$Global_reactive_power<-as.numeric(selectedData$Global_reactive_power)
selectedData$Voltage<-as.numeric(selectedData$Voltage)
datePlusTime<-paste(selectedData$Date, selectedData$Time)
str(datePlusTime)
selectedData$Date<-as.Date(selectedData$Date, "%d/%m/%Y")
selectedData$Time<-strptime(datePlusTime, format="%d/%m/%Y %H:%M:%S")


#PLOT 4
par(mfcol=c(2,2), mar=c(4,4,2,1))
plot(selectedData$Time, selectedData$Global_active_power, ylab="Global Active Power (kilowatts)", 
     xlab="", type="l")


plot(selectedData$Time, selectedData$Sub_metering_1, ylab="Energy sub metering", 
     xlab="", type="n")
points(selectedData$Time, selectedData$Sub_metering_2, col="red", type="l")
points(selectedData$Time, selectedData$Sub_metering_3, col="blue", type="l")
points(selectedData$Time, selectedData$Sub_metering_1, type="l")
legend("topright", lty=c(1,1,1), lwd="2", col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty="n") # bty to not draw the legend box


plot(selectedData$Time, selectedData$Voltage, type="l", xlab="datetime", ylab="Voltage")

plot(selectedData$Time, selectedData$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

# Save the plot as png
dev.set(3)
dev.copy(png, file="plot4.png")
dev.off() # close the current graphic device