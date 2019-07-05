#Question 1
# When was datasharing repo created? 
library(httr)
library(jsonlite)

oauth_endpoints("github")

myapp <- oauth_app("github",
                   key = "daf3db7ab9344f27ddeb",
                   secret = "d4d4fc3181ff91476a6a09f9dfaea06d80d44927"
)

github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
json1 <- content(req)
gitDF = jsonlite::fromJSON(jsonlite::toJSON(json1))
gitDF[gitDF$full_name == "jtleek/datasharing", "created_at"] 

# Question 2
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileURL, destfile = "./data.csv", method = "curl")
acs <- read.csv("data.csv")
sqldf("select pwgtp1 from acs where AGEP < 50")
head(sqldf("select pwgtp1 from acs where AGEP < 50"))

#Question 3
head(unique(acs$AGEP)) == head(sqldf("select distinct AGEP from acs"))

#Question 4
con = url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode <- readLines(con)
close(con)
htmlCode

nchar(htmlCode[10])
nchar(htmlCode[20])
nchar(htmlCode[30])
nchar(htmlCode[100])

#Question 5
fileFor <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
download.file(fileFor, destfile = "./data.for", method = "curl")
data_for <- read.fwf("data.for",
                     skip=4,
                     widths=c(12, 7, 4, 9, 4, 9, 4, 9, 4))
