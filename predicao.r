imput <- read.csv2("data/dataset_imputed.csv", sep=",", dec = ".")

model <- lm(cbind(coord_x, coord_y) ~ . , data=imput)
summary(model)