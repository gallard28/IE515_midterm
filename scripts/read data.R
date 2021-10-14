# Title: Read Data 
# Author: Grant A. Allard
# Author's Email: grant@grantallard.com
# Date Created: 2021-10-10

# Purpose:

# Set Up####
# Libraries
library(tidyverse)
library(readxl)

# Data
# Change sheet for the sheet you want to run....Montreal, Vancouver, or Central. 
midterm_raw<-read_excel("data/Midterm_Data.xlsx", sheet="Montreal")

# Script ####
weekly <- midterm_raw %>% 
  filter(Periodicity=="Weekly")

saveRDS(weekly, file="data/weekly.RDS")

monthly <- midterm_raw %>% 
  filter(Periodicity=="Monthly")

saveRDS(monthly, file="data/monthly.RDS")

# Copyright (c) Grant Allard, 2021
