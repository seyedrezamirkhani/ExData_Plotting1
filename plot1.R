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

# export plot to a png file with 480x480 dimensions (pixels)
image_width = 480
image_height = 480

png("plot1.png", width = image_width, height = image_height, bg = "transparent")

# plot the histogram for Global Active Power
hist(dt_data$Global_active_power, main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)", col = "red")

dev.off()