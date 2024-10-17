# ---*** R10 CODES ***--- N°40

library(rvest)
library(tidyverse)
library(openxlsx)

base_url <- "https://chile21.cl/categoria/noticias/page/"

lista_enlaces <- list()

for (i in 1:25) {
  url <- paste0(base_url, i, "/")
  
  page <- read_html(url)
  
  enlaces <- page %>%
    html_nodes("a.wd-post-link") %>%
    html_attr("href")
  
  lista_enlaces[[i]] <- enlaces
  
  cat("Web scraping de la página", i, "completado.\n")
}

enlaces_totales <- unlist(lista_enlaces)

datos <- data.frame(Enlaces = enlaces_totales)

cat("Realizando web scraping...\n")

wb <- createWorkbook()

addWorksheet(wb, "Datos")
writeData(wb, "Datos", datos)

saveWorkbook(wb, "C21 Enlaces.xlsx", overwrite = TRUE)

cat("Web scraping finalizado. El archivo datos.xlsx se ha guardado exitosamente.\n")
