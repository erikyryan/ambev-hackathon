if(!require(recommenderlab)) install.packages("recommenderlab");require(recommenderlab)
if(!require(reshape2)) install.packages("reshape2");require(reshape2)
if(!require(data.table)) install.packages("data.table");require(data.table)
if(!require(ggplot2)) install.packages("ggplot2");require(ggplot2)

bebidas_data <- read.csv(file = "resources/data.csv", stringsAsFactors = FALSE)
quantidade_de_bebidas <- read.csv(file = "resources/data.csv")


str(bebidas_data)
str(quantidade_de_bebidas)

data.table(bebidas_data)
data.table(quantidade_de_bebidas)

sumary(bebidas_data)
sumary(quantidade_de_bebidas)


bebidas_tipos <- as.data.frame(bebidas_data$bebida, stringsAsFactors = FALSE)
bebidas_tipos2 <- tstrsplit(bebidas_tipos[,1],"[|]", type.convert = TRUE)

colnames(bebidas_tipos2) <- c(1:5000)

categorias_bebidas <- c("vinho,cerveja,Cachaça,Energético,Gin")

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

quantidade_matrix <- dcast(quantidade_de_bebidas,Ship.to.nu-Material, valuer.var = "rating", na.rm=FALSE) #matriz basica
quantidade_matrix <- as.matrix(quantidade_matrix[,-1]) # não precisa do ID do cliente

quantidade_matrix

#modelo de recomedação 
modelo_de_recomendacao <- recommenResgistry$get_entries(dataType = "VerdadeiraMatrix")
names=(modelo_de_recomendacao)

lapply(modelo_de_recomendacao, "[[","descrição")

#filtro geral
modelo_de_recomendacao$IBCF_VerdadeiraMatrix$parameters


#checando a similariedade
similar_mat <- similarity(quantidade_matrix[1:4, ],method = "cosline",which= "users")
as.matrix(similar_mat)

image(as.matrix(similar_mat), main = "Bebidas similares")

#parei no minuto 43:23


