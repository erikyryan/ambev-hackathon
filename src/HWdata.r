if(!require(lubridate)) install.packages("lubridate");require(lubridate)
if(!require(dygraphs)) install.packages("dygraphs");require(dygraphs)
if(!require(gdata)) install.packages("gdata");require(gdata)
if(!require(dplyr)) install.packages("dplyr");require(dplyr)


HWdata <- function(dfGrande) #passagem do dataframe
{
  df <- dfGrande
  df <- df %>%    #Limpeza de dados
    mutate_all(~ifelse(. %in% c("N/A", "null",""), NA, .)) %>% 
    na.omit()
  df <- df[,c("Doc..Date","Order.qty")]
  df[,1] <- as.Date(df[,1])   #Formatação da data
  df <- aggregate(df$Order.qty, by=list(Category=df$Doc..Date), FUN=sum)
  df$Category <- as.Date(df$Category)
  
  CicloTemporal <- as.integer(count(df)) #contagem da amostra temporal

  if(CicloTemporal >= 365)#anual
  {
    frequenciaTS = 1
  }
  else if(CicloTemporal >= 91)#trimestral
  {
    frequenciaTS = 4
  }
  else if(CicloTemporal >= 30)#mensal
  {
    frequenciaTS = 12
  }
  else  #menor que 1 mes é usado 1 semana
  {    
    frequenciaTS = 52
  }    
    
  
  #formação do gráfico
  hw <- HoltWinters(dfTs)
  p <- predict(hw, n.ahead = 36, prediction.interval = TRUE)
  all <- cbind(ldeaths, p)
  
  PlotHW <- dygraph(all, "Deaths from Lung Disease (UK)") %>%
    dySeries("ldeaths", label = "Actual") %>%
    dySeries(c("p.lwr", "p.fit", "p.upr"), label = "Predicted")
    
  #tratmento dos dados
  # df <- dfGrande
  # df <- df[,c('Doc..Date','Material','Order.qty','Ship.to.nu','Brand','Subrand','Segment.LE')]
  # df <- df %>% mutate_all(~ifelse(. %in% c("N/A", "null",""), NA, .)) %>% #remoção dos valores vazios
  #   na.omit()
  # df[,1] <- as.Date(df[,1]) #Formatação da data
      
  # #Frequencia dos clientes
  # dfFrequencia <- as.data.frame(table(df$Ship.to.nu))
  # dfFrequencia <- dfFrequencia[dfFrequencia$Freq >= 8,] #remocao das amostras menores que 7
  # dfFrequencia <- dfFrequencia %>% #ordena Frequencia do maior para o menor. 
  #   arrange(desc(Freq))
  # #criação do dataframe final
  # for (cliente in count(dfFrequencia)){
  #       dfAuxiliar <- df[df$Ship.to.nu == dfFrequencia$Var1[cliente],]}
  return(PlotHW) 
}

