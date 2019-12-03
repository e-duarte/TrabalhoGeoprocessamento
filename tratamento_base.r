install.packages('googlesheets')
install.packages("dplyr")

library(googlesheets)
library(magrittr)
library(dplyr)

belavista <- 
  googlesheets::gs_key('1LMa_n5E2xGnZqKFuhf_8hAG83sdoNm30PgeTVfs25FM') %>%
  googlesheets::gs_read(ws = 'observacao', na = '-', comment ="#metadado>")

cambe <- 
  googlesheets::gs_key('1HlFLNRDzRqD42lJ1GF3Pv00xHBMJ2w9Yj4Z2U1OR5_Q') %>%
  googlesheets::gs_read(ws = 'observacao', na = '-', comment ="#metadado>")

londrina <- 
  googlesheets::gs_key('1lSxtGUxa6Rqr4wQZYhp8pYg-KDe3soMft8Ki6KX1XxA') %>%
  googlesheets::gs_read(ws = 'observacao', na = '-', comment ="#metadado>")

obs <- rbind(belavista, cambe, londrina) %>%
  dplyr::mutate(taxon = stringr::word(taxon_sibcs_2006, sep=',')) %>%
  dplyr::select(-observacao_id, -observacao_data, -coord_sistema, -coord_precisao,
                -coord_fonte, -pais_id, -estado_id, -municipio_id, -amostra_tipo,
                -amostra_quanti, -amostra_area, -taxon_sibcs_2006)

if(!dir.exists("data")){
  dir.create("data")
}
write.csv(obs, "data/dataset_tratada.csv", row.names = FALSE)
