# Reading and preparing the data
library(data.table)
df <- fread(file = "~/exdata_data_household_power_consumption/household_power_consumption.txt", header = TRUE)
df2 <- df[which(df$Date == "1/2/2007"),]
df3 <- df[which(df$Date == "2/2/2007"),]
final_df <- rbind(df2, df3)
