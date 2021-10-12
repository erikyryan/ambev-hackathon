if(!require(lubridate)) install.packages("lubridate");require(lubridate)
if(!require(gdata)) install.packages("gdata");require(gdata)

source("HWdata.r")
source("MMdata.r")

dados <- read.csv(file = "resources/data.csv")
dados <- subset(data, select= -c(Longitude,Latitude))

colunas <- read.csv(file = "resources/data_column.csv")

HWdata(dados)
