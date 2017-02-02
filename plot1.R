# read in data file and extract only dates of interest

df <- read.table("household_power_consumption.txt", sep = ";", na.strings = "?",
                 header = TRUE)
df$Date2 <- as.Date(df$Date, format='%d/%m/%Y')
df_util <- subset(df, df$Date2 == "2007-02-01" | df$Date2 == "2007-02-02")
rm(df)

# generate histogram and save as png file

png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(df_util$Global_active_power, col="red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")
dev.off()