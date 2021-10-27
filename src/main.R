if(!require(lubridate)) install.packages("lubridate");require(lubridate)
if(!require(forecast)) install.packages("forecast");require(forecast)
if(!require(dygraphs)) install.packages("dygraphs");require(dygraphs)
if(!require(gdata)) install.packages("gdata");require(gdata)
if(!require(dplyr)) install.packages("dplyr");require(dplyr)

source(file = "src/HWdata.r")
source(file = "src/MMdata.r")

dfGrande <- read.csv(file = "resources/DataGrande.csv")
dados <- read.csv(file = "resources/data.csv")
colunas <- read.csv(file = "resources/data_column.csv")

