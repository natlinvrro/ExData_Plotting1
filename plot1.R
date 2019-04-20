#---------------------------------------------------#
#                                                   #
#             Exploratory Data Analysis             #
#            Week 1 - Program Assignment            #
#                 Plot 1 - Histogram                #
#                                                   #
#---------------------------------------------------#


###---Initialization---###

#1. Reading the Dataset
data <- read.table("./household_power_consumption.txt", sep=";", header=TRUE)

#2. Filtering out the needed data
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
filtered<-(subset(data, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02")))


###---Plotting a histogram with 'Global_active_power' Data---###

#3. Initiating the device
png(file="plot1.png")

#4. Setting 'Global_active_power' to a numeric data type
filtered$Global_active_power <- as.numeric(as.character(filtered$Global_active_power))

#5. Calling the hist() function
hist(filtered$Global_active_power, col="red", main="Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency")

#6. Closing the device
dev.off()