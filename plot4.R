power <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)
date_time <- paste(power$Time, power$Date)
date_time2 <- strptime(date_time, format = "%H:%M:%S %d/%m/%Y")
power <- cbind(date_time2, power)
power2 <- subset(power, date_time2 >= "2007-02-01" & date_time2 <= "2007-02-03")

png(filename = "plot4.png",  width = 480, height = 480)

four.par <- par(mfrow=c(2, 2))

    #topleft
    with(power2, plot(date_time2, Global_active_power, type= "l", xlab = "DateTime", ylab = "Global Active Power (kilowatts)"))
    
    #topright
    with(power2, plot(date_time2, Voltage, type= "l", xlab = "DateTime", ylab = "Global Active Power (kilowatts)"))
    
    
    #bottom left
    with(power2, plot(date_time2, Sub_metering_1, col="black", type= "l", xlab = "DateTime", ylab = "Energy Sub Metering"))
    with(power2, lines(date_time2, Sub_metering_2, col="orange"))
    with(power2, lines(date_time2, Sub_metering_3, col="blue"))
    with(power2, legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), col = c("black", "orange", "blue")))
    
    #bottom right
    with(power2, plot(date_time2, Global_reactive_power, type= "l", xlab = "DateTime", ylab = "Global Active Power (kilowatts)"))

#close par and png link
par(four.par)
dev.off()