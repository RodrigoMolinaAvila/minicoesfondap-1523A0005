# ---*** R10 CODES ***--- N°21

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
    html_nodes("p.date") %>%
    html_text() %>%
    str_trim()
  
  titulos <- pagina %>%
    html_nodes("h3") %>%
    html_text() %>%
    str_trim()
  
  enlaces <- pagina %>%
    html_nodes("p.file a") %>%
    html_attr("href") %>%
    str_trim()
  
  datos_pagina <- data.frame(fecha = fechas,
                             titulo = titulos,
                             enlace = enlaces,
                             stringsAsFactors = FALSE)
  
  return(datos_pagina)
}

url_base <- "https://lyd.org/category/encuestas/page/"
num_paginas <- 8

datos_totales <- vector("list", num_paginas)

for (i in seq_len(num_paginas)) {
  
  url_pagina <- ifelse(i == 1, url_base, paste0(url_base, i, "/"))
  
  datos_pagina <- obtener_datos_pagina(url_pagina)
  
  datos_totales[[i]] <- datos_pagina
  
  cat("Página", i, "completada\n")
  
  Sys.sleep(1)
}

datos <- do.call(rbind, datos_totales)

wb <- loadWorkbook("Base de Datos LyD.xlsx")

addWorksheet(wb, "Encuestas")
writeData(wb, "Encuestas", datos, rowNames = FALSE)

saveWorkbook(wb, "Encuestas LyD.xlsx", overwrite = TRUE)

