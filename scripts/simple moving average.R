# Title: Moving Average
# Author: Grant A. Allard
# Author's Email: grant@grantallard.com
# Date Created: 2021-10-10

# Purpose:

# Set Up####
# Libraries
library(tidyverse)
library(forecast)
library(lubridate)
library(TTR)

# Data
weekly <- readRDS("data/weekly.RDS")
monthly <- readRDS("data/monthly.RDS")


# Script ####
# 2 Week Moving Average 
SMA(weekly$`Gross requirements`, n=2)

# 4 Week Moving Average 
four_week_ma <- SMA(weekly$`Gross requirements`, n=4)

# Convert weekly data to monthly ####
weekly$Month <- month(weekly$Date)
weekly$Year <- year(weekly$Date)
weekly$Month_Year <- as.Date(paste0(weekly$Month,"-",weekly$Year))

weekly_to_monthly_dates<- weekly %>% 
  group_by(Month_Year) %>% 
  summarize(`Gross requirements`=sum(`Gross requirements`)) %>% 
  arrange(Month_Year) 

# Add Dates
weekly_to_monthly_dates[1,"Date"]<-as.Date("2018-10-02 UTC")
weekly_to_monthly_dates[2,"Date"]<-as.Date("2018-11-06 UTC")

weekly_to_monthly_dates[3,"Date"]<-as.Date("2018-07-24 UTC")

weekly_to_monthly_dates[4,"Date"]<-as.Date("2018-08-07 UTC")

weekly_to_monthly_dates[5,"Date"]<-as.Date("2018-09-04 UTC")

# Add to Monthly 
weekly_to_monthly_dates$Month_Year<-NULL

weekly_to_monthly_dates <- weekly_to_monthly_dates %>% 
  arrange(Date)

add<-monthly %>% 
  select(-Periodicity)

monthly_all<- bind_rows(weekly_to_monthly_dates, add)

saveRDS(monthly_all, file="data/monthly_all.RDS")


mean(SMA(monthly_all$`Gross requirements`, n=2),na.rm=TRUE)

mean(SMA(monthly_all$`Gross requirements`, n=3), na.rm=TRUE)

mean(SMA(monthly_all$`Gross requirements`, n=4),na.rm=TRUE)

# Create Dataframe 
sma_2_month <-tibble(SMA(monthly_all$`Gross requirements`, n=2))
sma_3_month <-tibble(SMA(monthly_all$`Gross requirements`, n=3))
sma_4_month <-tibble(SMA(monthly_all$`Gross requirements`, n=4))

sma_2_month$Date <- monthly_all$Date
sma_3_month$Date <- monthly_all$Date
sma_4_month$Date <- monthly_all$Date

sma_df <- left_join(sma_2_month, sma_3_month, by="Date")
sma_df <- left_join(sma_df, sma_4_month, by="Date")
sma_df <- sma_df %>% 
  select(Date, 1, 3, 4)
sma_df %>% 
  write_csv("outputs/central/sma_df_central.csv")


monthly_all$Date <- as.Date(monthly_all$Date)

monthly_all %>% 
  write_csv("outputs/central/monthly_all_central.csv")

# Copyright (c) Grant Allard, 2021
