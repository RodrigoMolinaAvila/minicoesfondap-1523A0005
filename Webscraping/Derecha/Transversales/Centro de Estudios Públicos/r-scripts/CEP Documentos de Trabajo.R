# ---*** R10 CODES ***--- N°2

library(rvest)
library(openxlsx)
library(tidyverse)

enlaces <- c("https://www.cepchile.cl/investigacion/actualizacion-de-las-areas-protegidas-de-chile-analisis-de/",
             "https://www.cepchile.cl/investigacion/propuestas-para-una-ley-general-de-donaciones/"
             
)

resultados <- list()

for (i in 1:length(enlaces)) {
  url <- enlaces[i]
  page <- read_html(url)
  
  titulo <- page %>%
    html_node(".banner-title") %>%
    html_text()
  
  fecha_publicacion <- page %>%
    html_node(".banner-date") %>%
    html_text()
  
  autores <- page %>%
    html_node(".lyrics p") %>%
    html_text()
  
  etiquetas <- page %>%
    html_nodes(".display-badges .badge") %>%
    html_text() %>%
    paste(collapse = ", ")
  
  edicion <- page %>%
    html_node(".number-single") %>%
    html_text()
  
  resultados[[i]] <- data.frame(Título = titulo,
                                `Fecha de publicación` = fecha_publicacion,
                                Autor = autores,
                                Etiquetas = etiquetas,
                                Edición = edicion,
                                URL = url)
  
  cat("Documento de Trabajo", i, "Procesado\n")
}

datos_completos <- do.call(rbind, resultados)

print(datos_completos)

write.xlsx(datos_completos, "CEP Documentos de Trabajo.xlsx")
