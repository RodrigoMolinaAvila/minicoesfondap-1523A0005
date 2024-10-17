# ---*** R10 CODES ***--- N°16

library(rvest)
library(tidyverse)
library(openxlsx)

extract_data <- function(url) {
  page <- read_html(url)
  
  links <- page %>% html_nodes("a.linkFull")
  enlaces <- links %>% html_attr("href")
  
  fecha_publicacion <- page %>% html_nodes("a.source") %>% html_text()
  autor <- page %>% html_nodes("span.color-secondary a") %>% html_text()
  titulo <- page %>% html_nodes("h2.fs-4") %>% html_text()
  
  df_info <- data.frame(Enlace = enlaces, `Fecha de publicación` = fecha_publicacion, Autor = autor, Título = titulo)
  
  return(df_info)
}

info_paginas <- list()

for (i in 1:5) {
  url_pagina <- paste0("https://fppchile.org/categoria/articulos/page/", i, "/")
  info_pagina <- tryCatch(
    extract_data(url_pagina),
    error = function(e) data.frame(Enlace = NA, `Fecha de publicación` = NA, Autor = NA, Título = NA)
  )
  info_paginas[[i]] <- info_pagina
  
  cat("Artículo", i, "procesado\n")
}

df_info <- bind_rows(info_paginas)

df_info <- df_info[!duplicated(df_info$Enlace), ]

write.xlsx(df_info, "FPP2 Artículos.xlsx", rowNames = FALSE)

cat("Extracción de Artículos FPP completada.\n")
