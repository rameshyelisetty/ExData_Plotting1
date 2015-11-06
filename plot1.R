# Initial Code, with library("sqldf"), and use read.csv.sql; but, this function doesnt seem to work with na.strings = "?"
# so... explore later
# get back to simple read.csv, 6GB RAM must be has enough memory to handle the records

# DATA PREPERATION

# Load data from file, create initial dataset - dataSet0
powerDataFile <- "household_power_consumption.txt"
dataSet0 <- read.csv(powerDataFile,sep=";",header=T, na.strings="?")

# Filter the data set to the given date criteria - 1/2/2007 and 2/2/2007
dataSet1 <- dataSet0[dataSet0$Date == '2/2/2007' | dataSet0$Date == '1/2/2007',]

# get rid of the initial dataset
rm(dataSet0)

# Convert date and time formats
dataSet1 <- transform(dataSet1, Date = as.Date(Date,"%d/%m/%Y"), Time = format(strptime(Time, format="%H:%M:%S"),format="%H:%M:%S"))

# DATA-FRAME READY

# PROCESS

# plot1 - Histogram
hist(dataSet1$Global_active_power,
col="red",
ylim=c(0,1200),
xlab="Global Active Power(killowatts)",
main="Global Active Power")

# OUTPUT TO DEVICE
dev.copy(png, file="plot1.png") ## Copy to png device/file

# CLEANUP, ...no TRACE

dev.off() ## Close the device
rm(dataSet1) ## Close dataset