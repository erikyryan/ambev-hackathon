if(!require(lubridate)) install.packages("lubridate");require(lubridate)
if(!require(dygraphs)) install.packages("dygraphs");require(dygraphs)
if(!require(gdata)) install.packages("gdata");require(gdata)
if(!require(dplyr)) install.packages("dplyr");require(dplyr)
if(!require(htmlwidgets)) install.packages("htmlwidgets");require(htmlwidgets)
if(!require(webshot)) install.packages("webshot");require(webshot)


HWdata <- function(dfGrande) #passagem do dataframe
{
  df <- dfGrande 
  df <- df %>%    #Limpeza de dados
    mutate_all(~ifelse(. %in% c("N/A", "null",""), NA, .)) %>% 
    na.omit()
  df <- df[,c("Doc..Date","Order.qty")]
  df[,1] <- as.Date(df[,1])   #Formatação da data
  df <- aggregate(df$Order.qty, by=list(Category=df$Doc..Date), FUN=sum)
  df <- df[df$x >= 25,]
  df$Category <- ymd(date(df$Category))
  
  df$Category <- strptime(df$Category, "%Y-%m-%d" )
  df$Category <- as.POSIXct(df$Category)
  
  df$x <- as.numeric(df$x)
  df <- mutate(df, MonthYear = paste(year(Category),formatC(month(Category), width = 2, flag = "0")))

  df <- select(df,-Category,-MonthYear)
  
  dfTs <- ts(df,frequency = 12) #TS em séries de 1 mês
  
  #formação do gráfico
  hw <- HoltWinters(dfTs)
  hwPredict <- predict(hw,48)
  all <- cbind(dfTs, hwPredict)
  
  PlotHW <- dygraph(all, "Previsao de Demanda") %>%
    dySeries("dfTs", label = "Atual") %>%
    dySeries("hwPredict", label = "Previsão")
  
  saveWidget(PlotHW,"temp.html", selfcontained = FALSE)
  width<- 1080
  height <- 610
  webshot("temp.html", file = "plotHW.png",
          cliprect = c(10,30,width+50,height+50)
          ,vwidth = width, vheight = height )
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


