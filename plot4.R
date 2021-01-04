# Reading and preparing the data
library(data.table)
df <- fread(file = "~/exdata_data_household_power_consumption/household_power_consumption.txt", header = TRUE)
df2 <- df[which(df$Date == "1/2/2007"),]
df3 <- df[which(df$Date == "2/2/2007"),]
temp_df <- rbind(df2, df3)

# concatenate Date and Time column
datetime <- paste(temp_df$Date, temp_df$Time, sep=" ")
samp <- cbind(datetime, temp_df[,-c('Date','Time')])
DateTime <- as.POSIXct(strptime(samp$datetime, format = "%d/%m/%Y %H:%M:%S"))
final_df <- cbind(DateTime, samp[,-1])

# convert remaining columns to numeric dtype
new_cols <- lapply(final_df[,-c("DateTime")], FUN = as.numeric)
samp2 <- final_df[,1]
df_converted <- cbind.data.frame(samp2,new_cols)

# plot
par(mfrow=c(2,2), mar=c(5,5,2,1)) # set parameters

with( df_converted, plot(DateTime, Global_active_power, type='l', ylab='Global Active Power', xlab='') )

with( df_converted, plot(DateTime, Voltage, type='l', ylab='Voltage', xlab='datetime') )

with( df_converted, plot(DateTime, Sub_metering_1, type='l', ylab='Energy sub metering', xlab='') )
with( df_converted, lines(DateTime, Sub_metering_2, type='l', col='red') )
with( df_converted, lines(DateTime, Sub_metering_3, type='l', col='blue') )
legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, cex=0.7)

with( df_converted, plot(DateTime, Global_reactive_power, type='l', ylab='Global_reactive_power', xlab='datetime') )

dev.copy(png, "plot4.png")
dev.off()