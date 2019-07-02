fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileURL, destfile = "./data.csv", method = "curl" )
datedownloaded <- date()

data <- read.csv("data.csv")
head(data)
str(data)

library(tidyverse)
nrow(select(data, VAL) %>% filter(VAL == "24"))
