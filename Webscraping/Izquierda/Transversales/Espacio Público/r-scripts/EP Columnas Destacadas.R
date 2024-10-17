# ---*** R10 CODES ***--- N°46

library(rvest)
library(tidyverse)
library(openxlsx)

fechas <- c()
titulos <- c()
autores <- c()
enlaces <- c()

for (page in 1:51) {
  url <- paste0("https://espaciopublico.cl/categoria/prensa/ep-en-la-prensa/columna/page/", page, "/")
  
  webpage <- read_html(url)
  
  post_items <- html_nodes(webpage, ".post-item")
  
  for (item in post_items) {
    fecha <- html_text(html_node(item, ".post-date"))
    titulo <- html_text(html_node(item, ".posts-entry-title"))
    autor <- html_text(html_node(item, ".post-authors h5"))
    enlace <- html_attr(html_node(item, ".posts-entry-title a"), "href")
    
    fechas <- c(fechas, fecha)
    titulos <- c(titulos, titulo)
    autores <- c(autores, autor)
    enlaces <- c(enlaces, enlace)
    
    cat("Página:", page, "| Datos extraídos:", length(fechas), "\n")
  }
}

df <- data.frame(Fecha = fechas, Título = titulos, Autor = autores, Enlace = enlaces)

write.xlsx(df, file = "EP Columnas Destacadas.xlsx", rowNames = FALSE)

