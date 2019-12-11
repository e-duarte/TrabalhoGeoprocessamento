imput <- read.csv2("data/dataset_imputed.csv", sep=",", dec = ".")
#model <- lm(cbind(coord_x, coord_y) ~ . , data=imput)

modelx <- lm(coord_x ~ . , data=imput) 
modely <- lm(coord_y ~ . , data=imput)

summary(modelx)
summary(modely)




####################################### Verificação de Ajuste #####################################
#summary(modelx)

#step(model, direction = "both", scale=7987)
#summary(adj)

#shapiro.test(modelx$residuals)
#par(mfrow = c(2,4))
#plot(modelx, which=c(1:4), pch=20)
