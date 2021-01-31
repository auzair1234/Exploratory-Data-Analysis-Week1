library(dplyr)
# Read the data
df <- read.table("household_power_consumption.txt",
                 sep = ";",
                 col.names = c("Date", "Time", 'Global_active_power', 'Global_reactive_power', 'Voltage', 'Global_Intensity', 'Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
                 fill = FALSE,
                 strip.white = TRUE)
# Convert the Date and TIME into date and time class
df<- df %>%
  mutate(Time = strptime(Time, format = "%H:%M:%S")) # Converted Time into Time class

df <- df %>%
  mutate(Date = as.Date(Date, format = "%d/%m/%Y")) # Converted Date into date class

df <- df %>%
  mutate(Global_active_power = as.numeric(Global_active_power))

str(hpcDF)
# Extracting the data we need 
hpcDF<- subset(df, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
hpcDF[1:1440,"Time"] <- format(hpcDF[1:1440,"Time"],"2007-02-01 %H:%M:%S")
hpcDF[1441:2880,"Time"] <- format(hpcDF[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

# PLOT 4
par(mfrow = c(2, 2)) # Setting the number of graphs 
with(hpcDF, plot(Time, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")) # plot 1
with(hpcDF, plot(Time, Voltage, type = "l", ylab = "Voltage", xlab = "datetime")) # plot 2 
with(hpcDF, plot(Time, Sub_metering_1, type = "l", ylab = "Energy sub metering", col = "black"), lty = 1) # plot 3
lines(hpcDF$Time, hpcDF$Sub_metering_2, col = "red", lty = 2)
lines(hpcDF$Time, hpcDF$Sub_metering_3, col = "blue", lty = 3)
with(hpcDF, plot(Time, Global_reactive_power, type = "l", xlab = "datetime"))