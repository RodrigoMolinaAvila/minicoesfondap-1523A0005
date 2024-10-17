# ---*** R10 CODES ***--- N°20

library(rvest)
library(tidyverse)
library(data.table)
library(openxlsx)

obtener_datos_pagina <- function(url_pagina) {
  
  html_pagina <- read_html(url_pagina)
  
  fechas <- html_pagina %>%
    html_nodes("time") %>%
    html_text() %>%
    str_trim()
  
  titulos <- html_pagina %>%
    html_nodes("h4") %>%
    html_text() %>%
    str_trim() 
  
  etiquetas <- html_pagina %>%
    html_nodes(".tags a") %>%
    html_text() %>%
    str_trim() %>%
    str_split(", ") %>%
    map(sort) %>%
    map_chr(paste, collapse = ", ")
  
  enlaces <- html_pagina %>%
    html_nodes("h4 a") %>%
    html_attr("href") 
  
  datos_pagina <- data.frame(fecha = fechas[1:12],
                             titulo = titulos[1:12],
                             etiquetas = etiquetas[1:12],
                             enlace = enlaces[1:12],
                             stringsAsFactors = FALSE)
  
  return(datos_pagina)
}

url_base <- "https://lyd.org/category/actualidad-constitucional/page/"
num_paginas <- 7
datos_totales <- vector("list", num_paginas)

for (i in seq_len(num_paginas)) {
  
  url_pagina <- paste0(url_base, i, "/")
  
  datos_pagina <- obtener_datos_pagina(url_pagina)
  
  datos_totales[[i]] <- datos_pagina
  
  cat("Página", i, "completada\n")
  
  Sys.sleep(1)
}

datos <- do.call(rbind, datos_totales)

wb <- loadWorkbook("Base de datos LyD.xlsx")

addWorksheet(wb, "Actualydad Constitucional")
writeData(wb, "Actualydad Constitucional", datos, rowNames = FALSE)

saveWorkbook(wb, "Actualydad Constitucional LyD.xlsx", overwrite = TRUE)
