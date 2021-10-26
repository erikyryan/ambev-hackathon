if(!require(recommenderlab)) install.packages("recommenderlab");require(recommenderlab)
if(!require(reshape2)) install.packages("reshape2");require(reshape2)
if(!require(data.table)) install.packages("data.table");require(data.table)
if(!require(ggplot2)) install.packages("ggplot2");require(ggplot2)

bebidas_data <- read.csv(file = "resources/bebidas_data.csv", stringsAsFactors = FALSE)
quantidade_de_bebidas <- read.csv(file = "resources/quantidade_data.csv")


str(bebidas_data)
str(quantidade_de_bebidas)

data.table(bebidas_data)
data.table(quantidade_de_bebidas)

bebidas_tipos <- as.data.frame(bebidas_data$bebida, stringsAsFactors = FALSE)
bebidas_tipos2 <- tstrsplit(bebidas_tipos[,1],"[|]", type.convert = TRUE)

colnames(bebidas_tipos2) <- c(1:5000)

categorias_bebidas <- c("cachaça","cerveja","vinhos","refrigerantes","sucos")

categorias_matl <- matrix(0,10,5) # o 10 representa a quantidade de linhas e o 5 as categorias das bebidas acima(categorias_bebidas)
categorias_matl[1,] <- categorias_bebidas
colnames(categorias_matl) <- categorias_bebidas

for(index in 1:nrow(bebidas_tipos2)){
  for(col in 1:ncol(bebidas_tipos2)){
    bebidas_col = which(categorias_matl[1,] == bebidas_tipos2[])
    categorias_matl[index+1,bebidas_col] <- 1
  }
}

categorias_matl2 <- as.data.frame(categorias_matl[-1,], stringsAsFactors = FALSE)

for( col in 1:ncol(categorias_matl2)){
  categorias_matl2[,col] <- as.integer(categorias_matl2[,col])
}

str(categorias_matl2)



#head(bebidas_tipos)
#criando uma matriz de busca para buscar baseando na quantidad
buscar_bebida  <- cbind(bebidas_data[,1:2],categorias_matl2[])
head(buscar_bebida)


#sparse matrix para recomendação
#quantidade_matrix <- dcast(quantidade_de_bebidas, )
