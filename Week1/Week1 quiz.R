## Question 1
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileURL, destfile = "./data.csv", method = "curl" )
datedownloaded <- date()

data <- read.csv("data.csv")
head(data)
str(data)

library(tidyverse)
nrow(select(data, VAL) %>% filter(VAL == "24"))

## Question2

#HAS NO CODE TO DO 

## Question 3
file2URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(file2URL, destfile = "./data2.xlsx", method = "curl" )

#readxl package part of tidyverse
dat <- read_excel("data2.xlsx", range = "G18:O23", col_names = TRUE)
sum(dat$Zip*dat$Ext,na.rm=T)

## Question 4
fileURL3 <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
XML_dat <- xmlTreeParse(fileURL3,useInternal = TRUE)
rootNode <- xmlRoot(XML_dat)
xmlName(rootNode)
names(rootNode)

Zip <- xpathSApply(rootNode, "//zipcode",xmlValue)
table(Zip)

## Question 5
file4URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(file4URL, destfile = "./data3.csv", method = "curl")
DT <- fread("data3.csv")
DT <- data.table(DT)

system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(DT[,mean(pwgtp15),by=SEX])
system.time(rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]) #Yields error??
system.time(mean(DT$pwgtp15,by=DT$SEX))
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)) #Yields error?

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile="./dmicrodata3.csv", method="curl")
DT <- fread("microdata3.csv")
file.info("./microdata3.csv")
system.time(DT[,mean(pwgtp15),by=SEX])
system.time(mean(DT[DT$SEX==1,]$pwgtp15))+system.time(mean(DT[DT$SEX==2,]$pwgtp15))
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(mean(DT$pwgtp15,by=DT$SEX))
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(rowMeans(DT)[DT$SEX==1])+system.time(rowMeans(DT)[DT$SEX==2])


#Quiz answers:
#1      53
#2      Tidy data has one variable per column.
#3      36534720
##4      127
#5      ??  