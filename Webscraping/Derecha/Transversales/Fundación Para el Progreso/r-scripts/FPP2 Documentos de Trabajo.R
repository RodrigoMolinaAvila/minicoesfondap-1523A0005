# ---*** R10 CODES ***--- N°14

library(rvest)
library(tidyverse)
library(openxlsx)

enlaces <- c(
  "https://fppchile.org/publicacion/que-regimen-politico-necesita-chile/",
  "https://fppchile.org/publicacion/capitales-corrosivos-el-caso-chileno/",
  "https://fppchile.org/publicacion/inversiones-desde-paises-no-democraticos-en-chile-algunos-datos/",
  "https://fppchile.org/publicacion/valores-y-cultura-politica-chilena-en-el-ano-2020/",
  "https://fppchile.org/publicacion/valores-y-cultura-politica-chilena-en-el-ano-2021/"
)

datos_libros <- data.frame(Fecha_Publicacion = character(),
                           Titulo = character(),
                           Autor = character(),
                           URL = character(),
                           stringsAsFactors = FALSE)

for (i in 1:length(enlaces)) {
  page <- read_html(enlaces[i])
  
  fecha_publicacion <- page %>% html_node("span.py-2.text-capitalize") %>% html_text()
  
  titulo <- page %>% html_node("h1.py-3") %>% html_text()
  
  autor <- page %>% html_node("small.d-block.mt-5") %>% html_text()
  
  libro_actual <- data.frame(Fecha_Publicacion = fecha_publicacion,
                             Titulo = titulo,
                             Autor = autor,
                             URL = enlaces[i],
                             stringsAsFactors = FALSE)
  
  datos_libros <- rbind(datos_libros, libro_actual)
  
  cat("Documento", i, "procesado\n")
}

write.xlsx(datos_libros, file = "FPP2 Documentos de Trabajo.xlsx", rowNames = FALSE)

print("Documentos de Trabajo FPP procesado")
