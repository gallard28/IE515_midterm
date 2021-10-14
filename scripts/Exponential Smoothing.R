# Title: Exponential Smoothing
# Author: Grant A. Allard
# Author's Email: grant@grantallard.com
# Date Created: 2021-10-10

# Purpose:

# Set Up####
# Libraries
library(tidyverse)
library(forecast)
library(stats)

# Data
weekly<- readRDS("data/weekly.RDS")
monthly <- readRDS("data/monthly.RDS")
monthly_all <- readRDS("data/monthly_all.RDS")


# Script ####

monthly_all_ts <- monthly_all %>% 
  select(`Gross requirements`)

monthly_all_ts <- ts(monthly_all_ts, frequency = 12, start=c(2018,7))

plot.ts(monthly_all_ts)

requirements_forecasts <- HoltWinters(monthly_all_ts, beta=FALSE, gamma=FALSE)
requirements_forecasts

plot(requirements_forecasts)

requirements_forecasts2 <- HoltWinters(monthly_all_ts)

plot(requirements_forecasts2)

forecast_requirements_forecasts2 <- forecast(requirements_forecasts2, n.ahead=24, prediction.interval = FALSE, level=0.95 )

plot(forecast_requirements_forecasts2)


forecast_requirements_forecasts2$fitted

# Copyright (c) Grant Allard, 2021
