power <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)
date_time <- paste(power$Time, power$Date)
date_time2 <- strptime(date_time, format = "%H:%M:%S %d/%m/%Y")
power <- cbind(date_time2, power)
power2 <- subset(power, date_time2 >= "2007-02-01" & date_time2 <= "2007-02-03")

png(filename = "plot2.png",  width = 480, height = 480)

with(power2, plot(date_time2, Global_active_power, type= "l", xlab = "", ylab = "Global Active Power (kilowatts)"))

dev.off()

#archive
time2 <- strptime(power$Time, format = "%H:%M:%S")
date2 <- as.Date(power$Date, format = "%d/%m/%Y")
power2 <- cbind(date2, time2, power)
power2 <- subset(power2, date2 >= "2007-02-01" & date2 <= "2007-02-02")
