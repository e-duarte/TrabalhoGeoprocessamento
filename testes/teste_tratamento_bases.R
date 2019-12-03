ctb48 <- read.csv2("data/ctb0048-observacao.csv", sep = ",", dec = ".", na.strings = "-", comment.char = "#")

library("mice")

missing_obj <- mice(ctb48, meth="polyreg")
complete_data <- complete(missing_obj)

model <- lm(cbind(coord_x, coord_y) ~ relevo_elevacao +
              taxon_sibcs_2006 + relevo_local + relevo_declividade + relevo_posicao,
            data=complete_data)

summary(model)
coef(model)
