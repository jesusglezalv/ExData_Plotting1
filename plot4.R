#load data.table library
#load data.table library
library("data.table")

# Read file
householdEPC <- data.table::fread(input = "../data/household_power_consumption.txt", na.strings="?")

# Convert values to numeric
householdEPC[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

#Convert to POSIXct to use week days
householdEPC[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Subset observations from 2007-02-01 to 2007-02-02
householdEPC <- householdEPC[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

# Plot 1
plot(householdEPC[, dateTime], householdEPC[, Global_active_power], type="l", xlab="", ylab="Global Active Power")

# Plot 2
plot(householdEPC[, dateTime],householdEPC[, Voltage], type="l", xlab="datetime", ylab="Voltage")

# Plot 3
plot(householdEPC[, dateTime], householdEPC[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(householdEPC[, dateTime], householdEPC[, Sub_metering_2], col="red")
lines(householdEPC[, dateTime], householdEPC[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1)
       , bty="n"
       , cex=.5) 

# Plot 4
plot(householdEPC[, dateTime], householdEPC[,Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()