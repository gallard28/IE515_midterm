# Title: Plot Weekly and Monthy Data
# Author: Grant A. Allard
# Author's Email: grant@grantallard.com
# Date Created: 2021-10-10

# Purpose:

# Set Up####
# Libraries
library(tidyverse)

# Data
monthly_all<-readRDS("data/monthly_all.RDS")

# Script ####
monthly_all %>% 
  ggplot(aes(x=Date, y=`Gross requirements`))+
  geom_line() +
  ggtitle("Monthly Data")

# Copyright (c) Grant Allard, 2021
