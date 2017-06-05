#load and process data
power <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)
date_time <- paste(power$Time, power$Date)
date_time2 <- strptime(date_time, format = "%H:%M:%S %d/%m/%Y")
power <- cbind(date_time2, power)
power2 <- subset(power, date_time2 >= "2007-02-01" & date_time2 <= "2007-02-03")

png(filename = "plot1.png",  width = 480, height = 480)

#chart data
hist(as.numeric(power2$Global_active_power), breaks = 12, col = "red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power")


dev.off()