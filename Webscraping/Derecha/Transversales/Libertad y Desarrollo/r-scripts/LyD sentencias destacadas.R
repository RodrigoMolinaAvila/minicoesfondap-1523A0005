# ---*** R10 CODES ***--- N°27

library(rvest) 
library(dplyr)
library(readr)

url_p1 <- "https://lyd.org/sentencias-destacadas/"

título <- read_html(url_p1) %>% 
  html_elements("h4") %>% 
  html_text(trim = TRUE)

título2 <- título[1:235]

url <- read_html(url_p1) %>% 
  html_elements("h4 a") %>% 
  html_attr("href")

url2 <- url[1:235]

autor <- read_html(url_p1) %>% 
  html_elements("h5") %>% 
  html_text(trim = TRUE)

pagina <- read_html(url_p1)
nodos_anios2 <- html_nodes(pagina, "span.year")
anios <- html_text(nodos_anios2)
  
tabla <- tibble(autor = autor, título = título2, url = url2, año = anios)


write.xlsx(tabla, "Sentencias Destacadas LyD.xlsx", rowNames = FALSE)






