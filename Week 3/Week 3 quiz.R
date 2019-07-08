if(!file.exists("./data")){dir.create("./data")}
library(tidyverse)

# Question 1
#download and load df
urlq1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(urlq1, "./data/q1.csv", method = "curl")
q1 <- read.csv("./data/q1")

#Create logical vector

agricultureLogical <- q1$ACR == 3 & q1$AGS == 6
which(agricultureLogical)

# Question 2
urlq2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(urlq2, "./data/q1.jpeg", method = "curl")
q2 <- readJPEG("./data/q1.jpeg", native=TRUE)
quantile(q2, probs = 0.30)
quantile(q2, probs = 0.80)

# Question 3
urlq3_1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
urlq3_2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(urlq3_1, "./data/q3_1.csv", method = "curl")
download.file(urlq3_2, "./data/q3_2.csv", method = "curl")

#Read and tidy data
q3_1 <- read.csv("./data/q3_1.csv",skip = 4, nrows = 215)
q3_1 <- select(q3_1,
               "CountryCode"=X,
               "gdpRank"= X.1,
               "Long.Name" = X.3,
               "GdpMillion" = X.4)

q3_2 <- read.csv("./data/q3_2.csv")

#Match on CountryCode
q3_merge <- merge(q3_1, q3_2, all = TRUE, by = "CountryCode")

# Arrange
q3Arrange <- arrange(q3_merge, desc(gdpRank))
sum(!is.na(unique(q3Arrange$gdpRank)))

q3Arrange[13,2]

# Question 4
q3mean <- q3Arrange %>% filter(Income.Group == 'High income: OECD')
mean(q3mean$gdpRank, na.rm = TRUE)

q3mean <- q3Arrange %>% filter(Income.Group == 'High income: nonOECD')
mean(q3mean$gdpRank, na.rm = TRUE)

# Question 5
q3mean$quantile <- cut(q3mean$gdpRank ,breaks = quantile(q3mean$gdpRank, probs = seq(0, 1, 0.2), na.rm = TRUE))
#then what? Happened to get it right by accident, LEARN this
group_by(q3mean, quantile)
summarise(q3mean, Income.Group = sum(Income.Group))

q3mean %>% gather(key, value, -owner) %>% count(owner, key, value) %>% spread(value, n, fill = 0)