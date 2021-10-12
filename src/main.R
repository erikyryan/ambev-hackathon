if(!require(gdata)) 
install.packages("gdata");require(gdata)

dados <- read.csv(file = "resources/data.csv")
head(dados)