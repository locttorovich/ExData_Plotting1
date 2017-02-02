# read in data file and extract only dates of interest

df <- read.table("household_power_consumption.txt", sep = ";", na.strings = "?",
                 header = TRUE)
df$Date2 <- as.Date(df$Date, format='%d/%m/%Y')
df_util <- subset(df, df$Date2 == "2007-02-01" | df$Date2 == "2007-02-02")
rm(df)

#create DateTime column

df_util$DateTime = paste(df_util$Date, df_util$Time)
df_util$DateTime = as.POSIXlt(df_util$DateTime,format="%d/%m/%Y %H:%M:%S")

# generate graph and save as png file

png(filename = "plot4.png", width = 480, height = 480, units = "px")

par(mfrow=c(2,2))

plot(df_util$DateTime, df_util$Global_active_power, type = "l", 
     ylab = "Global Active Power (kilowatts)", xlab = "")

plot(df_util$DateTime, df_util$Voltage, type = "l", 
     ylab = "Voltage", xlab = "datetime")

plot(df_util$DateTime, df_util$Sub_metering_1, type = "n", xlab = "", 
     ylab = "Energy sub metering")
lines(df_util$DateTime, df_util$Sub_metering_1)
lines(df_util$DateTime, df_util$Sub_metering_2, col = "red")
lines(df_util$DateTime, df_util$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = c(1,1,1), bty="n")

plot(df_util$DateTime, df_util$Global_reactive_power, type = "l", 
    ylab = "Global_reactive_power (kilowatts)", xlab = "datetime")

dev.off()