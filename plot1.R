# Set Working directory to location of household_power_consumption.txt

library(data.table)

# read data for 1st and 2nd of Feb 2007
dt_data <- fread("household_power_consumption.txt", header = FALSE, sep = ";",
            na.strings = "?", colClasses=c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), skip=66637, nrows = 2880)

# read header names only
dt_header <- fread("household_power_consumption.txt", header = TRUE, sep = ";", nrows = 0)

# label the columns of data set
setnames(dt_data, old = colnames(dt_data), new = colnames(dt_header))

rm(dt_header)

# export plot to a png file with 480x480 dimensions (pixels)
image_width = 480
image_height = 480

png("plot1.png", width = image_width, height = image_height)

# plot the histogram for Global Active Power
hist(dt_data$Global_active_power, main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)", col = "red")

dev.off()