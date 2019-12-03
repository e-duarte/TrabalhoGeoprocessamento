install.packages("mice") #pacote que contem função para imputação de dados


ob <- read.csv2("data/observacao.csv", sep=",", dec = ".")

library(mice, warn.conflicts = FALSE) #carrega a lib mice
#md.pattern(ob)

tempData <- mice(ob,m=5,maxit=50,meth='pmm',seed=500) # função para imputação de dados

summary(tempData)


#ob[1,5] <- NA
#tempData$imp$relevo_elevacao
imputeData <- complete(tempData,3) #extração da nova tabela com dados imputados]

################## MODELOS #########################
model_x <- lm(formula= coord_x ~ relevo_elevacao +
              taxon_sibcs_2006 + relevo_local + relevo_declividade + relevo_posicao,
            data=imputeData)

model_y <- lm(formula= coord_y ~ relevo_elevacao +
              taxon_sibcs_2006 + relevo_local + relevo_declividade + relevo_posicao,
            data=imputeData)

model <- lm(cbind(coord_x, coord_y) ~ relevo_elevacao +
              taxon_sibcs_2006 + relevo_local + relevo_declividade + relevo_posicao,
            data=imputeData)

################## TESTES ##########################
instance <- data.frame(
  relevo_elevacao = 300,
  taxon_sibcs_2006 = "Latossolo Vermelho Distrófico típico, textura média, A moderado",
  relevo_local = "plano",
  relevo_declividade = 4,
  relevo_posicao = "Terço superior"
)

predict(model_x, newdata = instance)
predict(model_y, newdata = instance)
predict(model, newdata = instance)
summary(model)