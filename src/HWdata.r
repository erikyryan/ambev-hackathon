if(!require(lubridate)) install.packages("lubridate");require(lubridate)
if(!require(dygraphs)) install.packages("dygraphs");require(dygraphs)
if(!require(dplyr)) install.packages("dplyr");require(dplyr)
if(!require(htmlwidgets)) install.packages("htmlwidgets");require(htmlwidgets)

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
  hwPredict <- predict(hw, n.ahead = 36, prediction.interval = TRUE)
  all <- cbind(dfTs, hwPredict)
  
  PlotHW <- dygraph(all, "Previsao de Demanda") %>%
    dySeries("dfTs", label = "Atual") %>%
    dySeries(c("hwPredict.fit", "hwPredict.upr", "hwPredict.lwr"), label = "Previs")
  
  saveWidget(PlotHW,"temp.html", selfcontained = FALSE)


  return(PlotHW) 
}


