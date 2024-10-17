# ---*** R10 CODES ***--- N°23

library(rvest)
library(tidyverse)
library(httr)
library(data.table)
library(xml2)
library(openxlsx)

obtener_datos_pagina <- function(url_pagina) {
  
  html_pagina <- GET(url_pagina)
  content_pagina <- content(html_pagina, "text")
  pagina <- read_html(content_pagina)
  
  fechas <- pagina %>%
    html_nodes("time") %>%
    html_text() %>%
    str_trim()
  
  titulos <- pagina %>%
    html_nodes("h4") %>%
    html_text() %>%
    str_trim()
  
  enlaces <- pagina %>%
    html_nodes("h4 a") %>%
    html_attr("href")
  
  etiquetas <- pagina %>%
    html_nodes("div.tags") %>%
    html_text() %>%
    str_replace_all(", ", ", ") %>% # agregar un espacio después de cada coma
    str_trim() %>%
    gsub("[[:space:]]{2,}", " ", .) # eliminar espacios consecutivos
  
  datos_pagina <- data.frame(fecha = fechas[1:12],
                             titulo = titulos[1:12],
                             enlace = enlaces[1:12],
                             etiquetas = etiquetas[1:12],
                             stringsAsFactors = FALSE)
  
  return(datos_pagina)
}

url_base <- "https://lyd.org/category/multimedia/podcast/page/"
num_paginas <- 11
datos_totales <- vector("list", num_paginas)

for (i in seq_len(num_paginas)) {
  
  url_pagina <- ifelse(i == 1, url_base, paste0(url_base, i, "/"))
  
  datos_pagina <- obtener_datos_pagina(url_pagina)
  
  datos_totales[[i]] <- datos_pagina
  
  cat("Página", i, "completada\n")
  
  Sys.sleep(1)
}

datos <- do.call(rbind, datos_totales)

write.xlsx(datos, "Lyd Podcast.xlsx", rowNames = FALSE)
