
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


#PLOT 2
# use xaxt="n" to not plot the x axis text
plot(selectedData$Time, selectedData$Global_active_power, ylab="Global Active Power (kilowatts)", 
     xlab="", type="l")


# Save the plot as png
dev.set(3)
dev.copy(png, file="plot2.png")
dev.off() # close the current graphic device