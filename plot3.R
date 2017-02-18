#
# plot3.R
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

# Setup plot region and add the data
plot(plot.data$DateTime.lt, plot.data$Sub_metering_1, type = "n", xlab = "", ylab = "Energy Sub Metering")
points(plot.data$DateTime.lt, plot.data$Sub_metering_1, type = "l", col = "black")
points(plot.data$DateTime.lt, plot.data$Sub_metering_2, type = "l", col = "red")
points(plot.data$DateTime.lt, plot.data$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col=c("black","red","blue"), 
       adj = c(0, 0.6), cex = 1, x.intersp = 0.5, xjust = 1)
        # Need adj to ensure minimisation of ws

# Export to png
dev.copy(png, file = "plot3.png") # output to file
dev.off() # close file
