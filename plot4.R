###Exporatory Data Exercise 1

#Set your own working directory
setwd("C:/Users/jkempke/Box Sync/Coursera/")

#This data has 2,075,259 rows and 9 columns. Assuming your computers stores each data as 8 bytes,
#Working with this data will require the following amount of memory (Gb)
((2075259 * 9 * 8)/(2^20))/(10^3)

#following commands will examine if you already have certain directories or files 
#and create them if they don't exit

if (!dir.exists("./ExData_Plotting1")){ 
    dir.create("./ExData_Plotting1")
}
#next command sets the working directory to one just created, 
#branching down from your working directory with the './' clause
setwd("./ExData_Plotting1")

if (!file.exists("./exdata_data_household_power_consumption.zip")){
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(url, method = "auto", destfile = "./exdata_data_household_power_consumption.zip")
}

#Unzip the file
if (!file.exists("./household_power_consumption.txt")){
    unzip("./exdata_data_household_power_consumption.zip")
}

#Read into R dataset
#The .txt file uses ";" as separator,
#includes a header,
#uses "?" and "NA" markers
#and I do not want character strings automatically put into factors
house_power <- read.table("./household_power_consumption.txt", sep = ";", header = T, na.strings = "?", stringsAsFactors = F)

#convert date and time into an actual date and time variables
#in the original data DAte is formatted dd/mm/yyyy and Time as hh:mm:ss
#use ?strptime to see how formats were set.
house_power$DateTime <- as.character(paste(house_power$Date, house_power$Time, sep = " "))
house_power$Date <- as.Date(house_power$Date, format = "%d/%m/%Y")
house_power$DateTime <- strptime(house_power$DateTime, format = "%d/%m/%Y %H:%M:%S")

house_power_subset <- house_power[(house_power$Date >= "2007-02-01" & house_power$Date <= "2007-02-02"),]

png(file = "plot4.png")
par(mfcol = c(2,2))
with(house_power_subset, {
    plot(DateTime, Global_active_power, type = 'l', xlab = "", ylab="Global Active Power (kilowatts)")
   plot(DateTime, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
        lines(DateTime, Sub_metering_1)
        lines(DateTime, Sub_metering_2, col = "red")
        lines(DateTime, Sub_metering_3, col = "blue")
    legend("topright", pch = "_", col = c("black","red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty = 'n')
    plot(DateTime, Voltage, type = "l")
    plot(DateTime, Global_reactive_power, type = "l")
})
dev.off()