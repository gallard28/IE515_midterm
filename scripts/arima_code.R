# Title: ARIMA Code for IE515
# Author: Grant A. Allard
# Author's Email: grant@grantallard.com
# Date Created: 2021-09-17

# Purpose:
# The source code for ARIMA analysis. 

# ARIMA Code #### 
# ARIMA Code #### 
# Library
library(fpp2)
library(fpp3)
library(forecast)
library(zoo)
library(readxl)

# Read in Data
monthly_all <- readRDS("data/monthly_all.RDS")

data <- monthly_all
start <- c(2018,7)
frequency = 12

# Autoplot
t_data <- ts(data[,1], start =start, frequency=frequency)

#ggseasonplot
ggseasonplot(t_data)

d# Decompse 
crossdecomp <- decompose(t_data)

# Autoplot 
autoplot(crossdecomp)

# GGTS Display 
ggtsdisplay(t_data)


# Print ACF
acf(t_data)

# Print PACF
pacf(t_data)

# Forcast ARIMA #### 
forecastarima <- auto.arima(t_data)
summary(forecastarima)

# Autoplot First Differences using dcross
dcross <- diff(t_data)
autoplot(dcross)


ggseasonplot(dcross)
ggtsdisplay(dcross)

acf(dcross)
pacf(dcross)

# Forecast ARIMA #### 
farima <- forecast(forecastarima, h=frequency)
summary(farima)
autoplot(farima)



# Copyright (c) Grant Allard, 2021
