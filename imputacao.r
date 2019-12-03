if(file.exists("dataset_tratada")){
  cat("Erro - Arquivo dataset_tratada não encontrado")
}else{
  ctb <- read.csv2("data/dataset_tratada.csv", sep=",", dec = ".")
  library(mice, warn.conflicts = FALSE)
  
  tempData <- mice(ctb,m=5,maxit=50,meth='cart',seed=500)
  
  data_impute <- complete(tempData)
  
  write.csv(data_impute, "data/dataset_imputed.csv", row.names = FALSE)
  
}