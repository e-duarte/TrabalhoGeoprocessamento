library(mice, warn.conflicts = FALSE)

if(!file.exists("data/dataset_tratada.csv")){
  cat("Erro - Arquivo dataset_tratada não encontrado")
}else{
  dataset <- read.csv2("data/dataset_tratada.csv", sep=",", dec = ".")
  
  tempData <- mice(dataset, method = "cart",m=5,maxit=50,seed=500)
  
  data_impute <- complete(tempData)
  
  write.csv(data_impute, "data/dataset_imputed.csv", row.names = FALSE)
  
}