if(!require(gdata)) 
  install.packages("gdata");require(gdata)

if(!require(lubridate))
  install.packages("lubridate");require(lubridate)

data <- read.csv(file = "resources/data.csv")
data <- subset(data, select= -c(Longitude,Latitude))

data1 <- read.csv(file = "resources/data_column.csv")

date <- data[,2]
