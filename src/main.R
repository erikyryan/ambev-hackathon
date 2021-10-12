if(!require(lubridate)) install.packages("lubridate");require(lubridate)
install.packages("gdata");require(gdata)

dados <- read.csv(file = "resources/data.csv")
head(dados)
