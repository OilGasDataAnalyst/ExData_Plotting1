#first read in the data and check it
#also told that missing values are saved as "?"
PowData <- read.table("household_power_consumption.txt",header=TRUE,sep = ";",na.strings="?")

#now want to fix the dates 
#as.Date(dates, "%m/%d/%y")
PowData$Date <- as.Date(PowData$Date, format = "%d/%m/%Y") #CAREFUL HERE need the CAPITAL Y for years.. dunno why lower case y didnt work when subsetting the dates
#confirm its in "Date" format
class(PowData$Date)

#want feb 1-2 2007
#this subsets the data CANNOT just say date == x & date == y!!!! need to put a RANGE
PowData <- subset(PowData, (Date >= "2007-02-01" & Date <= "2007-02-02"))

#need to get the date & time together to get the days on the X-axis
dateandtime <- paste(PowData$Date, PowData$Time) #merge the two together
dateandtime <- as.POSIXct(dateandtime) #converts them to the POSIXct time format...

#make the 1st chart :)
plot(dateandtime,PowData$Sub_metering_1,type = "l", col = "black", ylab = "Energy sub metering",xlab = "") #start w/ black line
lines(dateandtime,PowData$Sub_metering_2,col='Red') #red line
lines(dateandtime,PowData$Sub_metering_3,col='Blue') #blue line
#add in the legend
legend("topright", col = c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lwd = 1)

#save as a png
dev.copy(png,file = "plot3.png",height = 480, width = 480)
dev.off() #remeber to do this after using the dev command!