#
# plot1.R
#

# Assuming you have loaded in the household_power_consumption.txt file into the current working directory

# Obtain the data
power = read.table("household_power_consumption.txt",header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE)
#str(power) # investigate the results

# Obtain values of interest and filter
one.feb <- strptime("1/2/2007", "%d/%m/%Y")
two.feb <- strptime("2/2/2007", "%d/%m/%Y")

power$Date = strptime(power$Date, format = "%d/%m/%Y", tz="")   # transform to Date
hist.data <- power[(power$Date == one.feb | power$Date == two.feb), ]
#nrow(hist.data)

# Plot graph and output to png
hist(hist.data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot1.png") # output to file
dev.off() # close file
