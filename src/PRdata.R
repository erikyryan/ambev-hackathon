if(!require(lubridate)) install.packages("lubridate");require(lubridate)
if(!require(dygraphs)) install.packages("dygraphs");require(dygraphs)
if(!require(arules)) install.packages("arules");require(arules)
if(!require(gdata)) install.packages("gdata");require(gdata)
if(!require(dplyr)) install.packages("dplyr");require(dplyr)


function(dataframe,IdCliente)
{
  dataframe <- dfGrande <- read.csv(file = "resources/DataGrande.csv")
  dataframe <- dataframe[,c('Doc..Date','Ship.to.nu','Subrand','Segment.LE')]
  dataframe <- dataframe %>% mutate_all(~ifelse(. %in% c("N/A", "null",""), NA, .)) %>% #remoção dos valores vazios
     na.omit()
  dataframe[,1] <- as.Date(dataframe[,1]) #Formatação da data
  
  dataframe$Subrand <- paste(dataframe$Subrand,dataframe$Segment.LE)
  dataframe <- select(dataframe,-Segment.LE)
  
  dataframe <- subset(dataframe,dataframe$Ship.to.nu == IdCliente)
  
  DatesUnique <- unique(dataframe$Doc..Date)
  
  dfConsumo <- data.frame(Dias = character())
  
  
  for (i in 1:length(unique(dataframe$Doc..Date))){
    dfaux <- subset(dataframe,dataframe$Doc..Date == DatesUnique[i])  
    
    dfaux <- dfaux[!duplicated(dfaux$Subrand),]#remove colunas com bebidas repetidas
      dfaux$Subrand <-gsub(" ", "", dfaux$Subrand,ignore.case = TRUE)
    dfConsumo[i,] <-  paste(dfaux$Subrand,collapse = " ")
  }
  
  
  df <- transactions(dfConsumo,
                          sep = "--",
                          format = "basket",)
  
  
     #Frequencia dos clientes
  # dfFrequencia <- as.data.frame(table(df$Subrand))
  # dfFrequencia <- dfFrequencia[dfFrequencia$Freq >= 8,] #remocao das amostras menores que 7
  # dfFrequencia <- dfFrequencia %>% #ordena Frequencia do maior para o menor.
  #   arrange(desc(Freq))
  # dfTranspose <-as.data.frame(t(dfFrequencia))
  # 
  # regras <- apriori(
  #   dfTranspose,
  #   parameter = list(support = 0.2,
  #                    confidence = 0.50,
  #                    mimlen = 2,
  #                    maxlen = 2) #
  # )
  
   
  for (cliente in count(dfFrequencia)){
      dfAuxiliar <- df[df$Ship.to.nu == dfFrequencia$Var1[cliente],]
  }
  
  return()
}