#---------------------------------------------------#
#                                                   #
#             Exploratory Data Analysis             #
#            Week 1 - Program Assignment            #
#                Plot 2 - Line Graph                #
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

###---Plotting a line graph with 'Global_active_power' and 'datetime' Data---###

#5. Initiating the device
png(file="plot2.png")

#6. Calling out the plot() via the with() function
par(mfrow=c(1,1))
with(filtered, plot(Global_active_power~datetime, type="l", xlab = "", 
                    ylab = "Global Active Power (kilowatts)"))

#7. Closing the device
dev.off()
