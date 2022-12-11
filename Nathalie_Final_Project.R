# BE310 Fall 2022
# Final Project

# load required libraries
library(readr)
library(openxlsx)
library(tidyverse)
library(tibble)
library(tidyr)
library(dplyr)

# read in information directly from Excel file
# it is not tidy or clean, skip row 1
# headers are in row 2
df=read.xlsx("Access_and_Use_of_Telemedicine_During_Covid19_New.xlsx",
             "Sheet 1 - Access_and_Use_of_Tel",
             startRow = 2,
             rowNames = FALSE,
             colNames = TRUE)

# if you need to write out a CSV file to save your work
# you can use this command
#write.csv(df, "my_file_name.csv", row.names = FALSE)

# get a dataframe of unique Sample.Size values based
# on a list of key values
df_group <- df %>% 
  group_by(Round, Indicator, Group, Subgroup, Sample.Size) %>% 
  filter(!is.na(Sample.Size))
# remove all columns except the ones we need from above
# these are the columns to join on and the column of data to be added
df_group <- df_group[1:5]

# do a left join on the original dataframe and grouped one
# keeps all rows and columns, but adds a new Sample.Size column
# original has a suffix of "x" added
# the new one has a suffix "y" added to it, and is the last column
df_final <- left_join(df, df_group, 
                      by = c("Round", "Indicator", "Group", "Subgroup"))

# You are good to go from here
# I did the initial manipulation to make the rest easier (not trivial)
# IT MAY STILL NOT BE MADE TIDY (that is up to you)
# 1. I would get rid of any columns you do not need as the next step
#     Sample.Size.x for sure
# 2. Use the Sample.Size.y column for your calculations, along with the %
