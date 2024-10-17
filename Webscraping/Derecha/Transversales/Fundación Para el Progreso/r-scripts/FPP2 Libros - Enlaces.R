# ---*** R10 CODES ***--- N°12

library(rvest)
library(tidyverse)
library(openxlsx)

extract_data <- function(url) {
  webpage <- read_html(url)
  
  enlaces <- webpage %>%
    html_nodes("div.imagen a") %>%
    html_attr("href")
  
  autores <- webpage %>%
    html_nodes("span.fw-bold") %>%
    html_text()
  
  return(data.frame(Enlace = enlaces, Autor = autores))
}

base_url <- "https://fppchile.org/tipo_publicacion/libros/page/"

max_pages <- 2

datos_totales <- list()

for (page in 1:max_pages) {
  url <- paste0(base_url, page, "/")
  datos_pagina <- extract_data(url)
  datos_totales[[page]] <- datos_pagina
}

datos_totales <- do.call(rbind, datos_totales)

write.xlsx(datos_totales, "FPP Libros - Enlaces.xlsx", rowNames = FALSE)

