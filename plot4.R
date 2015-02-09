# Set Working directory to location of household_power_consumption.txt

# Requires installation of :
# "data.table" package to manipulate table data more
# efficiently in memory
# version 1.9.4 was used to test this script
#

if (!"data.table" %in% installed.packages()) install.packages(data.table)

library(data.table)

# read data for 1st and 2nd of Feb 2007

# Convert the dates needed for subsetting into R Date/Time class
dates_to_read <- difftime(as.POSIXct("2007-02-03"), as.POSIXct("2007-02-01"), units = "mins")
rows_to_read <- as.numeric(dates_to_read)

# Read the data for 1st and 2nd of Feb 2007 
dt_data <- fread(input = "household_power_consumption.txt", sep = ";", 
                 skip = "1/2/2007", nrows = rows_to_read, na.strings = c("?", ""))

# read header names only
dt_header <- fread("household_power_consumption.txt", header = TRUE, sep = ";", nrows = 0)

# label the columns of data set
setnames(dt_data, old = colnames(dt_data), new = colnames(dt_header))

rm(dt_header)

# store the x axis range to be used in charts
event_time <- strptime(paste(dt_data$Date, dt_data$Time), 
                             format = "%d/%m/%Y %H:%M:%S")

# export plot to a png file with 480x480 dimensions (pixels)
image_width = 480
image_height = 480

png("plot4.png", width = image_width, height = image_height, bg = "transparent")

# setup canvas as 2 x 2 graph area
par(mfrow = c(2, 2))

################################################################################
#        Global Active Power
################################################################################ 
plot(x = event_time, y = dt_data$Global_active_power, type = "s", xlab = "", 
     ylab="Global Active Power")
################################################################################
#       Voltage
################################################################################
plot(x = event_time, y = dt_data$Voltage, type = "s", xlab = "datetime", 
     ylab="Voltage")
################################################################################
#       Energy sub metering
################################################################################
plot(x = event_time, y = dt_data$Sub_metering_1
     , type = "s", xlab = "", 
     ylab="Energy sub metering", col = "black"
     )

lines(x = event_time, y = dt_data$Sub_metering_2
     , type = "s", xlab = "", 
     ylab="Energy sub metering", col = "red"
)

lines(x = event_time, y = dt_data$Sub_metering_3
      , type = "s", xlab = "", 
      ylab="Energy sub metering", col = "blue"
)

# add legends to graph
legend("topright",
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = 1,
       bty = "n" # remove legend box border
       )
################################################################################
#       Global Reactive Power
################################################################################ 
plot(x = event_time, y = dt_data$Global_reactive_power, type = "s", xlab = "datetime", 
     ylab="Global_reactive_power") 
################################################################################
dev.off()