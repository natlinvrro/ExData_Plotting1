#---------------------------------------------------#
#                                                   #
#             Exploratory Data Analysis             #
#            Week 1 - Program Assignment            #
#          Plot 3 - Line Graph (w/ Legends)         #
#                                                   #
#---------------------------------------------------#


###---Initialization---###

library(dplyr)

#1. Reading the Dataset
data <- read.table("./household_power_consumption.txt", sep=";", header=TRUE,na.strings = "?", 
                   colClasses = c('character','character','numeric','numeric','numeric'
                                  ,'numeric','numeric','numeric','numeric'))

#2. Filtering the needed and complete data
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
filtered<-(subset(data, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02")))
filtered<-filtered[complete.cases(filtered),]

#3. Combining the Date and Time Columns
dateandTime <- paste(filtered$Date, filtered$Time)

#4. Creating a new 'datetime' column' & rearranging the dataframe
filtered <- mutate(filtered, datetime=as.POSIXct(dateandTime))
filtered[ ,c(length(filtered),which((names(
    filtered)!="Date" & names(filtered)!="Time" & names(filtered)!="datetime")))]


###---Plotting a line graph with 'Sub_metering_x' and 'dateTime' Data---###

#5. Initiating the device
png(file="plot3.png")

#6. Calling out plot() and lines() via the with() function; creating a legend
par(mfrow=c(1,1))
with(filtered, { plot(Sub_metering_1~datetime, type="l", ylab="Energy sub metering", xlab="")
     lines(Sub_metering_2~datetime, type="l", col="red")
     lines(Sub_metering_3~datetime, type="l", col="blue")
     legend("topright", lty=1, col=c("black", "red", "blue"), 
            legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))})

#7. Closing the device
dev.off()
