if(!require(lubridate)) install.packages("lubridate");require(lubridate)

source("HWdata.r")
source("MMdata.r")

dados <- read.csv(file = "resources/data.csv")
teste <- read.csv(file = "resources/data_column.csv")

HWdata(dados)

