#Downloads and unzips the file (if required)
if(!file.exists("household_power_consumption.txt")) {
	URL1 <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
	dateDownloaded <- date()
	temp <- tempfile()
	download.file(URL1,temp, method = "auto")
	unzip(temp)
	unlink(temp)
}

#Reading in the txt file data (only relevant rows, as determined through manual review in Excel)
#TA indicated this is an appropriate way to read in the data on the discussion forum
#see here: https://class.coursera.org/exdata-034/forum/thread?thread_id=8#post-10
powerData <- read.table("household_power_consumption.txt", sep=";", skip=66637, nrows=2880)

#Naming the columns
givenNames <-read.table("household_power_consumption.txt", sep=";", nrows=1)
givenNamesVec <- as.matrix(givenNames)
names(powerData)<- givenNamesVec

#Creating a complete date and time variable, fullDate
powerData$fullDate = paste(powerData$Date, powerData$Time, sep=" ")
powerData$fullDate <- strptime(powerData$fullDate, "%d/%m/%Y %H:%M:%S")

#Manual review in Excel indicated there are no missing variables in the selected dataset; however I have converted them to NA for completeness
sub("?","NA",powerData)

#create graph in png
png(file="plot2.png", height = 480, width = 480)
plot(x=powerData$fullDate, y=powerData$Global_active_power, 
	xlab="", ylab="Global Active Power (kilowatts)",
	type ="l"
	)
dev.off()