if(!require(htmlwidgets)) install.packages("htmlwidgets");require(htmlwidgets)
if(!require(tidyverse)) install.packages("tidyverse");require(tidyverse)
if(!require(lubridate)) install.packages("lubridate");require(lubridate)
if(!require(arulesViz)) install.packages("arulesViz");require(arulesViz)
if(!require(dygraphs)) install.packages("dygraphs");require(dygraphs)
if(!require(arules)) install.packages("arules");require(arules)
if(!require(dplyr)) install.packages("dplyr");require(dplyr)

PRdata <- function(dfGrande,IdCliente)
{
  dataframe <- dfGrande 
  dataframe <- dataframe[,c('Doc..Date','Ship.to.nu','Subrand','Segment.LE')]
  dataframe <- dataframe %>% mutate_all(~ifelse(. %in% c("N/A", "null",""), NA, .)) %>% #remoção dos valores vazios
    na.omit()
  dataframe[,1] <- as.Date(dataframe[,1]) #Formatação da data
  
  dataframe$Subrand <- paste(dataframe$Subrand,dataframe$Segment.LE)
  dataframe <- select(dataframe,-Segment.LE)
  
  dataframe <- subset(dataframe,dataframe$Ship.to.nu == IdCliente)
  
  DatesUnique <- unique(dataframe$Doc..Date)
  
  dfConsumo <- data.frame(Consumo = character())
  
  
  for (i in 1:length(unique(dataframe$Doc..Date))){
    dfaux <- subset(dataframe,dataframe$Doc..Date == DatesUnique[i])  
    
    dfaux <- dfaux[!duplicated(dfaux$Subrand),]#remove colunas com bebidas repetidas
    dfaux$Subrand <-gsub(" ", "", dfaux$Subrand,ignore.case = TRUE)
    dfConsumo[i,] <-  paste(dfaux$Subrand,collapse = " ")#
  }
  
  numeros = length(unique(dataframe$Subrand))
  dfConsumo <- as.data.frame(dfConsumo <- str_split_fixed(dfConsumo$Consumo," ",numeros))
  dfConsumo[dfConsumo ==""] <- NA
  
  #criação do objeto transacional
  mutate(dfConsumo, Id = 1:n()) %>% 
    pivot_longer(cols = contains("V"),names_to = "values",values_to = "product") %>% 
    filter(complete.cases(product)) %>% 
    mutate(product = factor(product)) %>% 
    group_by(Id) %>% 
    summarize(whatever = list(product)) -> df
  
  names(df$whatever) <- df$Id
  
  mydf <- as(df$whatever,"transactions")
  
  regras <- apriori(
    mydf,
    parameter = list(support = 0.01,
                     confidence = 0.01,
                     maxlen = 100)
  )
  
  plotFinal <- plot(regras,method = "graph",engine = "htmlwidget")
  return(plotFinal)
}