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
# ajuste do modelo todos_modelx e todos_modely
step(todos_modelx, direction = "both", scale=8192)
step(todos_modely, direction = "both", scale=10530)
shapiro.test(todos_modelx$residuals)
shapiro.test(todos_modely$residuals)

par(mfrow = c(2,4))
plot(todos_modelx, which=c(1:4), pch=20)
plot(todos_modely, which=c(1:4), pch=20)

# ajuste do modelo londrina_modelx e londrina_modely
step(londrina_modelx, direction = "both", scale=7987)
step(londrina_modelx, direction = "both", scale=7987)
shapiro.test(londrina_modelx$residuals)
shapiro.test(londrina_modely$residuals)

par(mfrow = c(2,4))
plot(londrina_modelx, which=c(1:4), pch=20)
plot(londrina_modely, which=c(1:4), pch=20)