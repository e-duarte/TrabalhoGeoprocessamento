library(mice, warn.conflicts = FALSE)

if(!file.exists("data/dataset_tratada.csv")){
  cat("Erro - Arquivo dataset_tratada não encontrado")
}else{
  dataset <- read.csv2("data/dataset_tratada.csv", sep=",", dec = ".")
  dataset_londrina <- read.csv2("data/datasetLondrina_tratada.csv", sep=",", dec = ".")
  
  tempData <- mice(dataset, method = "cart",m=5,maxit=50,seed=500)
  tempData_londrina <- mice(dataset_londrina, method = "cart",m=5,maxit=50,seed=500)
  
  dados_completos <- complete(tempData)
  dados_completos_londrina <- complete(tempData_londrina)
  
  write.csv(dados_completos, "data/dados_completos.csv", row.names = FALSE)
  write.csv(dados_completos_londrina, "data/dados_completos_londrina.csv", row.names = FALSE)
  
}