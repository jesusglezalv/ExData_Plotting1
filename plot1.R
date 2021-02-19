#load data.table library
library("data.table")

# Read file
householdEPC <- data.table::fread(input = "../data/household_power_consumption.txt", na.strings="?")

# Convert values to numeric
householdEPC[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Parse date
householdEPC[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# Subset observations from 2007-02-01 to 2007-02-02
householdEPC <- householdEPC[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

#Open de graphic device of type PNG
png("plot1.png", width=480, height=480)

## Plot 1
hist(householdEPC[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

# Close the device to save the file
dev.off()
