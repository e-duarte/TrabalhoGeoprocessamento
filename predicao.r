#todos <- read.csv2("data/dados_completos.csv", sep=",", dec = ".")
#londrina <- read.csv2("data/dados_completos_londrina.csv", sep=",", dec = ".")
#model <- lm(cbind(coord_x, coord_y) ~ . , data=todos)
#summary(model)

# modelo para dados de todos os municípios
#todos_modelx <- lm(coord_x ~ relevo_elevacao + relevo_local +
#                     relevo_declividade + relevo_posicao +  taxon, data=todos) 
#todos_modely <- lm(coord_y ~ relevo_elevacao + relevo_local +
#                     relevo_declividade + relevo_posicao +  taxon, data=todos)
#
# modelo para dados de londrina
#londrina_modelx <- lm(coord_x ~  relevo_elevacao + relevo_local +
#                        relevo_declividade + relevo_posicao +  taxon, data=londrina)
#londrina_modely <- lm(coord_y ~ relevo_elevacao + relevo_local +
#                        relevo_declividade + relevo_posicao +  taxon, data=londrina)

#summary(todos_modelx)
#summary(todos_modely)

#summary(londrina_modelx)
#summary(londrina_modely)



####################################### Verificação de Ajuste #####################################
# ajuste do modelo todos_modelx e todos_modely
#step(todos_modelx, direction = "both", scale=8192)
#step(todos_modely, direction = "both", scale=10530)
#shapiro.test(todos_modelx$residuals)
#shapiro.test(todos_modely$residuals)

#par(mfrow = c(2,4))
#plot(todos_modelx, which=c(1:4), pch=20)
#plot(todos_modely, which=c(1:4), pch=20)

# ajuste do modelo londrina_modelx e londrina_modely
#step(londrina_modelx, direction = "both", scale=7987)
#step(londrina_modelx, direction = "both", scale=7987)
#shapiro.test(londrina_modelx$residuals)
#shapiro.test(londrina_modely$residuals)

#par(mfrow = c(2,4))
#plot(londrina_modelx, which=c(1:4), pch=20)
#plot(londrina_modely, which=c(1:4), pch=20)

####################################### FUNÇÕES #########################################################################
EM = function(pred, obs, n){
  diferenca = 0
  for(i in 1:n){
    diferenca = pred[i] - obs[i]
  }
  
  return (diferenca/n)
}

########################################### CONSTRUÇÃO E VALIDAÇÃO ######################################################
install.packages("caret")
install.packages("hydroGOF")
library(hydroGOF)
library(caret)

# controlador LOOCV
control <- trainControl(method="LOOCV",
                        verboseIter=TRUE)

# Todas as bases(incluindo a base de Londrina)
todos_x <- train(coord_x ~ 
                 relevo_elevacao+relevo_local+relevo_declividade+relevo_posicao+taxon,
               data=todos, trControl=control, method="lm")

todos_y <- train(coord_y ~ 
                 relevo_elevacao+relevo_local+relevo_declividade+relevo_posicao+taxon,
               data=todos, trControl=control, method="lm")

todos_x$results
todos_y$results

todos_pred_x = todos_x$pred$pred
todos_obs_x = todos_x$pred$obs

todos_pred_y = todos_y$pred$pred
todos_obs_y = todos_y$pred$obs

# Base de Londrina
londrina_x <- train(coord_x ~ 
                   relevo_elevacao+relevo_local+relevo_declividade+relevo_posicao+taxon,
                 data=londrina, trControl=control, method="lm")

londrina_y <- train(coord_y ~ 
                   relevo_elevacao+relevo_local+relevo_declividade+relevo_posicao+taxon,
                 data=londrina, trControl=control, method="lm")

londrina_x$results
londrina_y$results

londrina_pred_x = londrina_x$pred$pred
londrina_obs_x = londrina_x$pred$obs

londrina_pred_y = londrina_y$pred$pred
londrina_obs_y = londrina_y$pred$obs

# Cálculo para erro médio
print("Erro médio para o modelo geral X e Y:")
EM(todos_pred_x, todos_obs_x, length(todos_obs_x))
EM(todos_pred_y, todos_obs_y, length(todos_obs_y))

print("Erro médio para o modelo de Londrina X e Y:")
EM(londrina_pred_x, londrina_obs_x, length(londrina_obs_x))
EM(londrina_pred_y, londrina_obs_y, length(londrina_obs_y))

# Cáclulo para NSE
print("NSE para o modelo geral X e Y:")
NSE(todos_pred_x, todos_obs_x)
NSE(todos_pred_y, todos_obs_y)

print("NSE para o modelo geral X e Y:")
NSE(londrina_pred_x, londrina_obs_x)
NSE(londrina_pred_y, londrina_obs_y)