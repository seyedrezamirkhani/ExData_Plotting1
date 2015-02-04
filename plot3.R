# Set Working directory to location of household_power_consumption.txt

# Requires installation of :
# "data.table" package to manipulate table data more
# efficiently in memory
# version 1.9.4 was used to test this script
#

if (!"data.table" %in% installed.packages()) install.packages(data.table)

library(data.table)

# read data for 1st and 2nd of Feb 2007
dt_data <- fread("household_power_consumption.txt", header = FALSE, sep = ";",
                 na.strings = "?", colClasses=c("character", "character", "numeric",
                                                "numeric", "numeric", "numeric", 
                                                "numeric", "numeric", "numeric"),
                 skip=66637, nrows = 2880)

# read header names only
dt_header <- fread("household_power_consumption.txt", header = TRUE, sep = ";", nrows = 0)

# label the columns of data set
setnames(dt_data, old = colnames(dt_data), new = colnames(dt_header))

rm(dt_header)

# store the x axis range to be used in chart
event_time <- strptime(paste(dt_data$Date, dt_data$Time), 
                       format = "%d/%m/%Y %H:%M:%S")

# export plot to a png file with 480x480 dimensions (pixels)
image_width = 480
image_height = 480

png("plot3.png", width = image_width, height = image_height, bg = "transparent")

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
       lty = 1
)

dev.off()