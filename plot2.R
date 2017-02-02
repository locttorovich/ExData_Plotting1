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

png(filename = "plot2.png", width = 480, height = 480, units = "px")
plot(df_util$DateTime, df_util$Global_active_power, type = "l", 
     ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()
