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

x <- range(dataSet1$Time1)
y <- range(c(dataSet1$Sub_metering_1,dataSet1$Sub_metering_2,dataSet1$Sub_metering_3))

# DATA-FRAME READY

# PROCESS

# plot3 - Line

# Setup the plot
with(dataSet1,
        {
plot(x, y,
     type = "n",
     xlab="Date-Time",
     ylab="Global Active Power (in killowatts)",
     main="Global Active Power",
     ylim=c(0,40));

lines(Time1, Sub_metering_1, 
     type = "l");
lines(Time1, Sub_metering_2, 
     type = "l",
     col="red");
lines(Time1, Sub_metering_3, 
     type = "l",
     col="blue");

legend("topright", 
       legend=c("Sub_metering1", "Sub_metering2", "Sub_metering3"),
       col = c(1,2,"blue"),
       lty = "solid")
}
)

# OUTPUT TO DEVICE
dev.copy(png, file="plot3.png") ## Copy to png device/file

# CLEANUP, ...no TRACE

dev.off() ## Close the device
rm(dataSet1) ## Close dataset