todos <- read.csv2("data/dados_completos.csv", sep=",", dec = ".")
londrina <- read.csv2("data/dados_completos_londrina.csv", sep=",", dec = ".")
#model <- lm(cbind(coord_x, coord_y) ~ . , data=imput)

# modelo para dados de todos os municípios
todos_modelx <- lm(coord_x ~ . , data=todos) 
todos_modely <- lm(coord_y ~ . , data=todos)

# modelo para dados de londrina
londrina_modelx <- lm(coord_x ~ . , data=londrina) 
londrina_modely <- lm(coord_y ~ . , data=londrina)

summary(todos_modelx)
summary(todos_modely)

summary(londrina_modelx)
summary(londrina_modely)



####################################### Verificação de Ajuste #####################################
#summary(modelx)

#step(model, direction = "both", scale=7987)
#summary(adj)

#shapiro.test(modelx$residuals)
#par(mfrow = c(2,4))
#plot(modelx, which=c(1:4), pch=20)
