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
with( df_converted, plot(DateTime, Global_active_power, type='l', ylab='Global Active Power (kilowatts)', xlab='') )