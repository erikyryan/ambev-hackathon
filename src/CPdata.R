function(dataframe)
{
   df <- dataframe
   df <- df[,c('Doc..Date','Material','Order.qty','Ship.to.nu','Brand','Subrand','Segment.LE')]
   df <- df %>% mutate_all(~ifelse(. %in% c("N/A", "null",""), NA, .)) %>% #remoção dos valores vazios
     na.omit()
   df[,1] <- as.Date(df[,1]) #Formatação da data

   #Frequencia dos clientes
   dfFrequencia <- as.data.frame(table(df$Ship.to.nu))
   dfFrequencia <- dfFrequencia[dfFrequencia$Freq >= 8,] #remocao das amostras menores que 7
   dfFrequencia <- dfFrequencia %>% #ordena Frequencia do maior para o menor.
     arrange(desc(Freq))
   
   for (cliente in count(dfFrequencia)){
         dfAuxiliar <- df[df$Ship.to.nu == dfFrequencia$Var1[cliente],]}
  
  return()
}