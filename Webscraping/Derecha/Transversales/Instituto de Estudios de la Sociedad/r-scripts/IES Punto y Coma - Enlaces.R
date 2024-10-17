# ---*** R10 CODES ***--- N°17

library(rvest)
library(tidyverse)
library(openxlsx)

extract_links <- function(url) {
  webpage <- read_html(url)
  
  enlaces <- webpage %>%
    html_nodes("h2.title a") %>%
    html_attr("href")
  
  return(enlaces)
}

base_url <- "https://www.ieschile.cl/category/punto-y-coma/"
num_pages <- 6  # Número total de páginas a iterar

all_enlaces <- c()  # Variable para almacenar todos los enlaces

for (page in 1:num_pages) {
  url <- paste0(base_url, "page/", page, "/")
  enlaces <- extract_links(url)
  all_enlaces <- c(all_enlaces, enlaces)
  
  num_enlaces <- length(enlaces)
  mensaje_progreso <- paste("Página", page, "- Se encontraron", num_enlaces, "enlaces.")
  print(mensaje_progreso)
}

data <- data.frame(Enlace = all_enlaces)
write.xlsx(data, "IES Punto y Coma - Enlaces.xlsx", rowNames = FALSE)
