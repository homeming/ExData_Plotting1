#
# plot2.R
#

# Assuming you have loaded in the household_power_consumption.txt file into the current working directory

# Obtain the data
power = read.table("household_power_consumption.txt",header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE)
#str(power) # investigate the results

# Obtain values of interest and filter
one.feb <- strptime("1/2/2007", "%d/%m/%Y")
two.feb <- strptime("2/2/2007", "%d/%m/%Y")

power$DateTime = power$Date # copy this over for later where the string will have time added to it
power$Date = strptime(power$Date, format = "%d/%m/%Y", tz="")   # transform to Date
plot.data <- power[(power$Date == one.feb | power$Date == two.feb), ]
#nrow(plot.data)

# Concatenate Date and Time to come up with one string
plot.data$DateTime = paste(plot.data$DateTime, plot.data$Time, sep = " ")
plot.data$DateTime.lt = strptime(plot.data$DateTime, format = "%d/%m/%Y %T", tz="")
#str(plot.data)

# Plot results and output to png
plot(plot.data$DateTime.lt, plot.data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot2.png") # output to file
dev.off() # close file
