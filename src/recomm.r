library(recomendarlab)
library(dplyr)
library(stringi)
library(reshape2)

glimpse(bebidas)

#lendo os datasets
#lendo todos os dados e construir a matriz de classificação
bebidas <- read.csv(file = "resources/bebidas_data.csv", stringsAsFactors =  FALSE)
quantidade_de_bebidas <- read.csv(file = "resources/quantidade_data.csv")

#criando matriz de classificação 
ratingmat <- dcast(ratingmats, userId~bebidaId, valuer.var = "ratingmat", na.rm =FALSE)
#ids do usuario
ratingmat <- as.matrix(ratingmat [,-1])
#convertenndo a matriz 
ratingmat <- as(ratingmat,"RealClassicasaoMatriz")
#normalizando
ratingmat <- normalize(ratingmat)

#modelo de recomendação
rec_mod <- Recommender(ratingmat, method = "UBCF", param = list(method = "Cosine",nn = 10))
#previssões
top_5_pred <- predict(rec_mod, ratingmat[1], n = 5)
top_5_pred

#Convertemos a lista em um dataframe e alteramos o nome da coluna para bebidaId
top_5_df <- data.frame (top_5_List) 
colnames (top_5_df ) = "bebibasId" 

#Desde que bebidaId é do tipo inteiro nos dados de bebidas, nós typecast id em nossas recomendações também 
top_5_df $ bebidaId = as.numeric (levels (top_5_df$bebidaId))

#Merge os ids de filme com nomes para obter títulos e nomes

nomes <-left_join (top_5_df, bebidas, by = "bebidaId")

#Imprimir os títulos e nomes dos gêneros gêneros do título do bebidaId
nomes
