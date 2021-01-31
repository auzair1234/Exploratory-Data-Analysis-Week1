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

# PLOT 1
hist(hpcDF$Global_active_power, col = 'red', xlab = "Global Active Power (kilowatts)", main = "Global Active Power")