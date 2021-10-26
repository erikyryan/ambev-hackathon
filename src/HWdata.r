rmvOutliers <- function(dataframe)#ainda precisa ser implementado
{
  Q <- quantile(dataframe$coluna, probs=c(.25, .75), na.rm = FALSE)
  iqr <- IQR(dataframe$coluna)
  sup <-  Q[2]+1.5*iqr   
  inf<- Q[1]-1.5*iqr 
  novoDataframe <- subset(dataframe, dataframe$coluna > (Q[1] - 1.5*iqr) & dataframe$coluna < (Q[2]+1.5*iqr))
  return(novoDataframe)
} 

HWdata <- function(dfGrande) #passagem do dataframe
{
  #tratmento dos dados
  df <- dfGrande
  df <- df[,c('Doc..Date','Material','Order.qty','Ship.to.nu','Brand','Subrand','Segment.LE')]
  df <- df %>% mutate_all(~ifelse(. %in% c("N/A", "null",""), NA, .)) %>% #remoção dos valores vazios
    na.omit()
  df[,1] <- as.Date(df[,1]) #Formatação da data
      
  #Frequencia dos clientes
  dfFrequencia <- as.data.frame(table(df$Ship.to.nu))
  dfFrequencia <- dfFrequencia[dfFrequencia$Freq >= 8,] #remocao das amostras menores que 7
  dfFrequencia <- dfFrequencia %>% #ordena Frequencia do maior para o menor. 
    arrange(desc(Freq))
  
  #criação do dataframe final
  
  novodataframe <- data.frame(IdCliente = integer(),
                                )
     
  for (cliente in count(dfFrequencia)){
        dfAuxiliar <- df[df$Ship.to.nu == dfFrequencia$Var1[cliente],]
        
        
        
        
        
  }
    
  return(novodataframe) 
}


