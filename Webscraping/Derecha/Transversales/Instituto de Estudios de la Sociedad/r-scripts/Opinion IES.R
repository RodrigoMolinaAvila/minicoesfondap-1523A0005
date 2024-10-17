# ---*** R10 CODES ***--- N°19

library(rvest)
library(tidyverse)
library(openxlsx)

datos <- list()

for (i in 1:239) {

  cat(paste0("Extrayendo datos de la página ", i, "...\n"))  
  
  # Extracción de los datos de la página actual
  url <- paste0("https://www.ieschile.cl/category/opinion/page/", i, "/")
  pagina <- read_html(url)
  
  fecha <- pagina %>%
    html_nodes("div.regularcontent p:first-child") %>%
    html_text()
  
  titulo <- pagina %>%
    html_nodes("h2.title a") %>%
    html_text()
  
  enlace <- pagina %>%
    html_nodes("h2.title a") %>%
    html_attr("href")
  
  autor <- pagina %>%
    html_nodes("span[itemprop=author] a") %>%
    html_text()
  
  datos[[i]] <- data.frame(fecha = fecha, titulo = titulo, enlace = enlace, autor = autor)
}

datos <- do.call(rbind, datos)

write.xlsx(datos, "Base de datos IES.xlsx", sheetName = "Opinión", encoding = "UTF-8")
