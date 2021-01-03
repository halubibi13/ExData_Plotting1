# Reading and preparing the data
library(data.table)
df <- fread(file = "~/exdata_data_household_power_consumption/household_power_consumption.txt", header = TRUE)
df2 <- df[which(df$Date == "1/2/2007"),]
df3 <- df[which(df$Date == "2/2/2007"),]
final_df <- rbind(df2, df3)

# convert Date column from chr to Date dtype
final_df$Date <- as.Date(final_df$Date, format = "%d/%m/%Y")

# convert Time column from chr to POSIXct dtype
newtime <- as.POSIXct(strptime(final_df$Time, format = "%H:%M:%S"))
final_df$Time <- newtime

# convert remaining columns to numeric dtype
new_cols <- lapply(final_df[,-c("Date", "Time")], FUN = as.numeric)
samp <- final_df[,1:2]
df_converted <- cbind.data.frame(samp,new_cols)
