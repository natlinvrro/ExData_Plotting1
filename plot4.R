#---------------------------------------------------#
#                                                   #
#             Exploratory Data Analysis             #
#            Week 1 - Program Assignment            #
#                Plot 4 - Subplotting               #
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

###---Subplotting the Graphs---###

#5. Initiating the device
png(file="plot4.png")

#6. Plotting the data
#6.1. Setting up the global parameters
par(mfcol=c(2,2), mar = c(4,4,2,1), oma = c(1,1,2,0))

#6.2. Plotting 'Global_active_power'
with(filtered, plot(Global_active_power~datetime, type="l", xlab = "", 
                    ylab = "Global Active Power"))

#6.3. Plotting 'Sub_metering_x'; creating a legend
with(filtered, { plot(Sub_metering_1~datetime, type="l", ylab="Energy sub metering", xlab="")
    lines(Sub_metering_2~datetime, type="l", col="red")
    lines(Sub_metering_3~datetime, type="l", col="blue")
    legend("topright", lty=1, col=c("black", "red", "blue"), bty="n", adj=0.1,
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))})

#6.4. Plotting 'Voltage'
with(filtered, plot(Voltage~datetime, type="l", xlab = "datetime", 
                    ylab = "Voltage"))

#6.5. Plotting 'Global_reactive_power'
with(filtered, plot(Global_reactive_power~datetime, type="l", xlab = "datetime"))

##7. Closing the device
dev.off()
