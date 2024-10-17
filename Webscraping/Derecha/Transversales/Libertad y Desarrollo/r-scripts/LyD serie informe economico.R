# ---*** R10 CODES ***--- N°28

library(rvest)
library(tidyverse)
library(stringr)
library(httr)
library(data.table)
library(xml2)
library(openxlsx)

url_base <- "https://lyd.org/category/estudios/estudios-lyd/serie-informe-economico/page/"

obtener_datos_pagina <- function(url_pagina) {
  
  html_pagina <- GET(url_pagina)
  content_pagina <- content(html_pagina, "text")
  pagina <- read_html(content_pagina)
  
  fechas <- pagina %>%
    html_nodes("div.boxes--box__content time") %>%
    html_text()
  
  titulos <- pagina %>%
    html_nodes("div.boxes--box__content h4 a") %>%
    html_text()
  
  etiquetas <- pagina %>%
    html_nodes("div.boxes--box__content div.tags") %>%
    html_text() %>%
    str_split(", ") %>%
    map_chr(1)
  
  enlaces <- pagina %>%
    html_nodes("div.boxes--box__content h4 a") %>%
    html_attr("href")
  
  filtro_enlaces <- str_detect(enlaces, ".pdf$")
  filtro_titulos <- !str_detect(titulos, "Recibe nuestros estudios semanales")
  filtro_titulos <- !str_detect(titulos, ">")
  
  fechas <- fechas[filtro_enlaces & filtro_titulos]
  titulos <- titulos[filtro_enlaces & filtro_titulos]
  etiquetas <- etiquetas[filtro_enlaces & filtro_titulos]
  enlaces <- enlaces[filtro_enlaces & filtro_titulos]
  
  datos_pagina <- data.frame(fecha = fechas,
                             titulo = titulos,
                             etiquetas = etiquetas,
                             enlace = enlaces,
                             stringsAsFactors = FALSE)
  
  return(datos_pagina)
}

num_paginas <- 14

datos_totales <- vector("list", num_paginas)

for (i in seq_len(num_paginas)) {
  
  url_pagina <- paste0(url_base, i, "/")
  
  datos_pagina <- obtener_datos_pagina(url_pagina)
  
  datos_totales[[i]] <- datos_pagina
  
  cat("Página", i, "completada\n")
  
  # esperar un segundo para evitar sobrecargar el sitio
  Sys.sleep(1)
}

# unir los datos de todas las páginas en un único data frame
datos_totales <- do.call(rbind, datos_totales)

datos_totales$etiquetas <- gsub("\\s+", " ", datos_totales$etiquetas)

write.xlsx(datos_totales, file = "Serie Informe Económico LyD.xlsx", rowNames = FALSE, encoding = "UTF-8")
