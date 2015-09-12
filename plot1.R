#first read in the data and check it
PowData <- read.table("household_power_consumption.txt",header=TRUE)
#head shows that the data isnt filtered out properly so need to put in sep
head(PowData)
#also told that missing values are saved as "?"
#nrows = 7 to test as its a large dataset
PowData <- read.table("household_power_consumption.txt",header=TRUE,sep = ";",na.strings="?",nrows = 7)
head(PowData) #looks ok can continue
PowData <- read.table("household_power_consumption.txt",header=TRUE,sep = ";",na.strings="?")

#now want to fix the dates 
#as.Date(dates, "%m/%d/%y")
PowData$Date <- as.Date(PowData$Date, format = "%d/%m/%Y") #CAREFUL HERE need the CAPITAL Y for years.. dunno why lower case y didnt work when subsetting the dates
#confirm its in "Date" format
class(PowData$Date)

#want feb 1-2 2007
#this subsets the data CANNOT just say date == x & date == y!!!! need to put a RANGE
PowData <- subset(PowData, (Date >= "2007-02-01" & Date <= "2007-02-02"))

#make the 1st chart :)
hist(PowData$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

#save as a png
dev.copy(png,file = "plot1.png",height = 480, width = 480)
dev.off() #remeber to do this after using the dev command!