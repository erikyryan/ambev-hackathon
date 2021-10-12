rmvOutliers <- function(dataframe)#ainda precisa ser implementado
{
  Q <- quantile(dataframe$coluna, probs=c(.25, .75), na.rm = FALSE)
  iqr <- IQR(dataframe$coluna)
  sup <-  Q[2]+1.5*iqr   
  inf<- Q[1]-1.5*iqr 
  novoDataframe <- subset(dataframe, dataframe$coluna > (Q[1] - 1.5*iqr) & dataframe$coluna < (Q[2]+1.5*iqr))
  return(novoDataframe)
} 

MMdata <- function(df) 
{
  #tratmento dos dados
  df <- dados
  df <- df[,c('Doc..Date','Material','Ship.to.nu')]
  
  dfFrequencia <- as.data.frame(table(df$Ship.to.nu))#Frequencia dos clientes
  dfFrequencia <- dfFrequencia[dfFrequencia$Freq >= 5,] #remocao das amostras menores que quatro
  
  #runmean

}return(novodf)