if(!require(dygraphs)) install.packages("dygraphs");require(dygraphs)
if(!require(forecast)) install.packages("forecast");require(forecast)


HWdata <- function(df) #passagem do dataframe
  {
    #tratmento dos dados
    df <- dados
    df <- df[,c('Doc..Date','Material','Ship.to.nu')]
    
    x <-  df
    # simple exponential smoothing (SES)S
    
    x.ses <- ses(x, h = 12, level = c(95)) #95 é o nivel de confiaça
    x.ses  # exibe o forecast por holt 1 parametro
    summary(x.ses)  # fornece o relatorio da estimacao
    
    plot(x.ses, col = 1, main = "l", #grafico 
         sub = "modelo SES")
  
}
