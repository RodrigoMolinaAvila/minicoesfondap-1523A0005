# ---*** R10 CODES ***--- N°35

library(rvest)
library(dplyr)
library(purrr)

extraer_datos <- function(url) {
    html <- read_html(url)
  
    Titulo <- html %>% 
    html_elements("h3.titulo-libro") %>% 
    html_text(trim = TRUE)
  
  Anio <- html %>% 
    html_elements("h3.itemlibro.anho") %>% 
    html_text(trim = TRUE)
  
  Autor <- html %>% 
    html_elements("h3.itemlibro.autor") %>% 
    html_text(trim = TRUE)
  
    df <- tibble(Autor = Autor, Titulo = Titulo, Anio = Anio)
  
   return(df)
}

urls <- c(
  "https://lyd.org/categoria-producto/union-editorial/",
  "https://lyd.org/categoria-producto/union-editorial/page/2/",
  "https://lyd.org/categoria-producto/union-editorial/page/3/",
  "https://lyd.org/categoria-producto/union-editorial/page/4/",
  "https://lyd.org/categoria-producto/union-editorial/page/5/",
  "https://lyd.org/categoria-producto/union-editorial/page/6/",
  "https://lyd.org/categoria-producto/union-editorial/page/7/",
  "https://lyd.org/categoria-producto/union-editorial/page/8/",
  "https://lyd.org/categoria-producto/union-editorial/page/9/",
  "https://lyd.org/categoria-producto/union-editorial/page/10/",
  "https://lyd.org/categoria-producto/union-editorial/page/11/",
  "https://lyd.org/categoria-producto/union-editorial/page/12/",
  "https://lyd.org/categoria-producto/union-editorial/page/13/",
  "https://lyd.org/categoria-producto/union-editorial/page/14/",
  "https://lyd.org/categoria-producto/union-editorial/page/15/",
  "https://lyd.org/categoria-producto/union-editorial/page/16/",
  "https://lyd.org/categoria-producto/union-editorial/page/17/",
  "https://lyd.org/categoria-producto/union-editorial/page/18/",
  "https://lyd.org/categoria-producto/union-editorial/page/19/",
  "https://lyd.org/categoria-producto/union-editorial/page/20/",
  "https://lyd.org/categoria-producto/union-editorial/page/21/"
)

datos <- map(urls, extraer_datos)

datos_totales <- bind_rows(datos)

print(datos_totales)

tabla <- tibble(datos_totales)

write.xlsx(datos_totales, file = "Union editorial LyD.xlsx", rowNames = FALSE, encoding = "UTF-8")

