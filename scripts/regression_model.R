# Title: Midterm Script - Regression Model
# Author: Grant A. Allard
# Author's Email: grant@grantallard.com
# Date Created: 2021-10-10

# Purpose:

# Set Up####
# Libraries
library(stats)
library(stargazer)

# Data
weekly <- readRDS("data/weekly.RDS")
monthly <- readRDS("data/monthly.RDS")

# Script ####
# Create df without Periodiciety 
weekly_df <- weekly %>% 
  select(-Periodicity)

# Plot weekly df
plot(weekly_df)

new_date_values<-seq(1,19,1)
weekly_df$Date<-new_date_values


# linear model for weekly_df
weekly_lm <- lm(data=weekly_df, `Gross requirements` ~ Date)

# Look at summary 
summary(weekly_lm)
stargazer(weekly_lm, type="html", out="outputs/central/regression_table_central.html")


# Add Line 
abline(weekly_lm, col=2, lwd=5)

# Create weekly values out for the next six months
weekly_forecast_values <- seq(monthly$Date[1], monthly$Date[length(monthly$Date)], by="weeks")

# Base predicted valuesw
weekly_forecast <- predict(weekly_lm, data.frame(Date=weekly_forecast_values))

weekly_forecast <-cbind.data.frame(weekly_forecast_values, weekly_forecast)

weekly_forecast <- weekly_forecast %>% 
  rename(Date=1, `Gross requirements`=2)

weekly_df_forecast <- bind_rows(weekly_df, weekly_forecast)

plot(weekly_df_forecast)
abline(weekly_lm, col="red", lwd=2)


# Monthly Data
# Create df without Periodiciety 
monthly_df <- monthly_all

monthly_df<- monthly_df %>% 
  select(2, 1)

# Plot weekly df
plot(monthly_df)


# linear model for weekly_df
monthly_lm <- lm(data=monthly_df, `Gross requirements` ~ Date)

# Look at summary 
summary(monthly_lm)
stargazer(monthly_lm, type="html", out="outputs/vancouver/regression_table_vancouver.html")

# Add Line 
abline(monthly_lm, col=2, lwd=5)

# Create weekly values out for the next six months
weekly_forecast_values <- seq(monthly$Date[1], monthly$Date[length(monthly$Date)], by="weeks")

# Base predicted valuesw
weekly_forecast <- predict(weekly_lm, data.frame(Date=weekly_forecast_values))

weekly_forecast <-cbind.data.frame(weekly_forecast_values, weekly_forecast)

weekly_forecast <- weekly_forecast %>% 
  rename(Date=1, `Gross requirements`=2)

weekly_df_forecast <- bind_rows(weekly_df, weekly_forecast)

plot(weekly_df_forecast)
abline(weekly_lm, col="red", lwd=2)
# Copyright (c) Grant Allard, 2021
