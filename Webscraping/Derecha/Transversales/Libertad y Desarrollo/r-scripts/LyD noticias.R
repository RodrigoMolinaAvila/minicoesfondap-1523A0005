# ---*** R10 CODES ***--- N°22

library(rvest)
library(stringr)
library(dplyr)
library(readr)
library(tidyverse)
library(httr)
library(data.table)
library(xml2)
library(openxlsx)

fechas <- c()
titulos <- c()
etiquetas <- c()
enlaces <- c()

for (i in 1:352) {
  
  url <- paste0("https://lyd.org/noticias/page/", i, "/")
  
  webpage <- read_html(url)
  
  fechas_pagina <- webpage %>% html_nodes(".boxes--box__content time") %>% html_text()
  fechas_pagina <- str_trim(fechas_pagina)  # Eliminar espacios en blanco innecesarios
  
  titulos_pagina <- webpage %>% html_nodes("h4 a") %>% html_text()
  
  enlaces_pagina <- webpage %>% html_nodes("h4 a") %>% html_attr("href")
  
  etiquetas_pagina <- webpage %>% html_nodes(".tags") %>% html_text()
  etiquetas_pagina <- str_trim(etiquetas_pagina)  # Eliminar espacios en blanco innecesarios
  
  indices_validos <- grep("Recibe nuestros estudios semanales y newsletters en tu mail", titulos_pagina, invert = TRUE)
  fechas_pagina <- fechas_pagina[indices_validos]
  titulos_pagina <- titulos_pagina[indices_validos]
  enlaces_pagina <- enlaces_pagina[indices_validos]
  etiquetas_pagina <- etiquetas_pagina[indices_validos]
  
  fechas <- c(fechas, fechas_pagina)
  titulos <- c(titulos, titulos_pagina)
  enlaces <- c(enlaces, enlaces_pagina)
  etiquetas <- c(etiquetas, etiquetas_pagina)
  
  Sys.sleep(1)
}

cat("Se han recopilado", length(fechas), "noticias.\n")

tabla <- tibble(fechas = fechas, titulos = titulos, enlaces = enlaces, etiquetas = etiquetas)

write.x

wb <- loadWorkbook("Noticias LyD.xlsx")

addWorksheet(wb, "Noticias")
writeData(wb, "Noticias", tabla, rowNames = FALSE)

saveWorkbook(wb, "Base de datos LyD.xlsx", overwrite = TRUE)

write.xlsx(tabla, file = "noticias.xlsx", rowNames = FALSE, encoding = "UTF-8")