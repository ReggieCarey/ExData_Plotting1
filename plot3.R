#############################################################################
# Student Name : Reginald Carey
# Course : Coursera - Data Science Specialization : Exploratory Data Analysis
# School : Johns Hopkins University
# Date : March 5, 2015
# Assignment : Course Project #1
# File : plot3.R
#############################################################################

# we use lubridate

library(lubridate)

# Load The Data from the website - if not already Loaded

if (!file.exists("exdata-data-household_power_consumption.zip")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "exdata-data-household_power_consumption.zip", method = "curl")
}

# Unwrap the data

if (!file.exists("household_power_consumption.txt")) {
  unzip(zipfile = "exdata-data-household_power_consumption.zip")
}

# load the data into memory
if (!exists("loaded")) {
  d <- read.table(file = "household_power_consumption.txt",
                  stringsAsFactors = FALSE,
                  colClasses = c("character",
                                 "character",
                                 "numeric",
                                 "numeric",
                                 "numeric",
                                 "numeric",
                                 "numeric",
                                 "numeric",
                                 "numeric"),
                  sep=";",
                  header = TRUE,
                  na.strings = "?",
                  nrows = 2075259)

  # subset the data to the rows Feb 1 & 2 of 2007
  d <- subset(d, dmy(Date) == ymd("2007/02/01") | dmy(Date) == ymd("2007/02/02"))
  loaded <- TRUE
}

# Create the plot and store it in a file
png("plot3.png", width = 480, height = 480)
plot(dmy(d$Date)+hms(d$Time), d$Sub_metering_1, type="n", xlab="",ylab="Energy sub metering")
lines(dmy(d$Date)+hms(d$Time), d$Sub_metering_1, type="l", col="black")
lines(dmy(d$Date)+hms(d$Time), d$Sub_metering_2, type="l", col="red")
lines(dmy(d$Date)+hms(d$Time), d$Sub_metering_3, type="l", col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1)
dev.off()
