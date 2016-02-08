# DATA PREPERATION

# Load data from file, create initial dataset - dataSet0
powerDataFile <- "household_power_consumption.txt"
dataSet0 <- read.csv(powerDataFile,sep=";",header=T, na.strings="?")

# Filter the data set to the given date criteria - 1/2/2007 and 2/2/2007
# dataSet1 <- dataSet0[dataSet0$Date == '2/2/2007' | dataSet0$Date == '1/2/2007',]
dataSet1 <- subset(dataSet0, Date == '2/2/2007' | Date == '1/2/2007')

# get rid of the initial dataset
rm(dataSet0)

# Convert date and time formats
# dataSet1 <- transform(dataSet1, Date = as.Date(Date,"%d/%m/%Y"), Time = strptime(Time, format="%H:%M:%S"))
Time1 <- paste(dataSet1$Date, dataSet1$Time, sep=" ", Collapse = NULL)
Time1<- as.POSIXlt(Time1,format="%d/%m/%Y %H:%M:%S")
dataSet1 <- cbind(dataSet1, Time1)

# DATA-FRAME READY

# PROCESS

# plot2 - Line

# Setup the plot
with(dataSet1, 
     {
plot(Time1, Global_active_power,
     type = "n",
     xlab="Date-Time",
     ylab="Global Active Power (in killowatts)",
     main="Global Active Power");

lines(Time1, Global_active_power, 
     type = "l")
}
)

# OUTPUT TO DEVICE
dev.copy(png, file="plot2.png") ## Copy to png device/file

# CLEANUP, ...no TRACE

dev.off() ## Close the device
rm(dataSet1) ## Close dataset