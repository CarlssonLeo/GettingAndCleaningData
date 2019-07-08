library(tidyverse)
if(!file.exists("./data")){dir.create("./data")}

# Question 1 --------------------------------------------------------------
urlq1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(urlq1, "./data/q1.csv", method = "curl")
q1 <- read_csv("./data/q1.csv")
strsplit(names(q1), "wgtp")[123]

# Question 2  -------------------------------------------------------------
urlq2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(urlq2, "./data/q2.csv")
q2 <- read_csv("./data/q2.csv", skip = 4, n_max = 215)
q2 <- select(q2,
               "CountryCode"=X1,
               "gdpRank"= X2,
               "Long.Name" = X4,
               "GdpMillion" = X5)


mean(as.numeric(gsub(",","",q2$GdpMillion)), na.rm = TRUE)

# Question 3 --------------------------------------------------------------
q3 <- read_csv("./data/q2.csv", skip = 4, n_max = 215)
q3 <- select(q3,
             "CountryCode"=X1,
             "gdpRank"= X2,
             "countryNames" = X4,
             "GdpMillion" = X5)
grep("^United",q3$countryNames)
grep("*United",q3$countryNames)
grep("United$",q3$countryNames)

# Question 4 --------------------------------------------------------------
q4url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(q4url, "./data/Stats_Country.csv", method = "curl")
q4_1 <- read_csv("./data/q2.csv", skip = 4, n_max = 215)
q4_1 <- select(q4_1,
             "CountryCode"=X1,
             "gdpRank"= X2,
             "countryNames" = X4,
             "GdpMillion" = X5)
q4_2 <- read_csv("./data/Stats_Country.csv")

q4 <- merge(q4_1, q4_2, all = TRUE, by = "CountryCode")
length(grep("end: June", q4$`Special Notes`))

filter(q4, grepl("end: June")) %>% nrow

# Question 5 --------------------------------------------------------------
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
year(sampleTimes)
sample <- grepl(2012,year(sampleTimes))
only2012 <- sampleTimes[sample]

mondays <- grepl("Mon", wday(only2012, label = TRUE))
onlyMondays <- only2012[mondays]
length(onlyMondays)
