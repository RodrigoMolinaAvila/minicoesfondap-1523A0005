# ---*** R10 CODES ***--- N°9

library(rvest)
library(tidyverse)
library(openxlsx)

extract_links <- function(url) {
  page <- read_html(url)
  links <- page %>% html_nodes("a.linkFull")
  enlaces <- links %>% html_attr("href")
  return(enlaces)
}

todos_enlaces <- character()

for (i in 1:110) {
  url_pagina <- paste0("https://fppchile.org/categoria/blog-opiniones/page/", i, "/")
  enlaces_pagina <- extract_links(url_pagina)
  todos_enlaces <- c(todos_enlaces, enlaces_pagina)
  
  cat("Enlace Opinión", i, "procesada\n")
}

df_enlaces <- data.frame(Enlace = todos_enlaces)

write.xlsx(df_enlaces, "FPP Opinión - Enlaces.xlsx", rowNames = FALSE)

cat("Extracción de enlaces completada.' generado.\n")
