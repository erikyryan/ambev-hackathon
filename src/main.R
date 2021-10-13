if(!require(lubridate)) install.packages("lubridate");require(lubridate)
if(!require(forecast)) install.packages("forecast");require(forecast)
if(!require(dygraphs)) install.packages("dygraphs");require(dygraphs)
if(!require(gdata)) install.packages("gdata");require(gdata)


source("HWdata.r")
source("MMdata.r")

dados <- read.csv(file = "resources/data.csv")
dados <- subset(dados, select= -c(Longitude,Latitude))

colunas <- read.csv(file = "resources/data_column.csv")

for(i in 1:length(dados[,2])){
  dados_data <- as.Date(dados[i,2]) #TODO: dados_data deve ser uma nova list, contendo os elementos de "dias", convertidos para o tipo Date 
}


HWdata(dados)
typeof(dados[1,2])