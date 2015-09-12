#first read in the data and check it
PowData <- read.table("household_power_consumption.txt",header=TRUE,sep = ";",na.strings="?")
head(PowData)
#now want to fix the dates 
#as.Date(dates, "%m/%d/%y")
PowData$Date <- as.Date(PowData$Date, format = "%d/%m/%Y") #CAREFUL HERE need the CAPITAL Y for years.. dunno why lower case y didnt work when subsetting the dates
#confirm its in "Date" format
class(PowData$Date)

#want feb 1-2 2007
#this subsets the data CANNOT just say date == x & date == y!!!! need to put a RANGE
PowData <- subset(PowData, (Date >= "2007-02-01" & Date <= "2007-02-02"))

#need to get the date & time together to get the days on the X-axis
datetime <- paste(PowData$Date, PowData$Time) #merge the two together
datetime <- as.POSIXct(datetime) #converts them to the POSIXct time format...

#set the plot zone for 2x2
par(mfrow = c(2,2))
plot(datetime,PowData$Global_active_power, type = "l",ylab = "Global Active Power", xlab = "")
plot(datetime,PowData$Voltage, type = "l",ylab = "Voltage")
plot(datetime,PowData$Sub_metering_1,type = "l", col = "black", ylab = "Energy sub metering",xlab = "")
lines(datetime,PowData$Sub_metering_2,col='Red')
lines(datetime,PowData$Sub_metering_3,col='Blue')
legend("topright",col = c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lwd = 1)
plot(datetime,PowData$Global_reactive_power, type = "l", ylab = "Global_reactive_power")

#save as a png
dev.copy(png,file = "plot4.png",height = 480, width = 480)
dev.off() #remeber to do this after using the dev command!