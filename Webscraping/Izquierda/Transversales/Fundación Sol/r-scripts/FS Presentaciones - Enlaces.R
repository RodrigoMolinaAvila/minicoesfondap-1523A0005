# ---*** R10 CODES ***--- N°55

library(rvest)
library(tidyverse)
library(openxlsx)

getEnlaces <- function(url) {
  webpage <- read_html(url)
  enlaces <- webpage %>%
    html_nodes("article.o_wblog_post a") %>%
    html_attr("href") %>%
    unique()
  
  enlaces <- paste0("https://fundacionsol.cl", enlaces)
  
  return(enlaces)
}

base_url <- "https://fundacionsol.cl/blog/presentaciones-4/page/"

num_paginas <- 15

df_total <- data.frame(Enlaces = character())

for (i in 1:num_paginas) {
  url <- paste0(base_url, i)
  enlaces_pagina <- getEnlaces(url)
  df_pagina <- data.frame(Enlaces = enlaces_pagina)
  df_total <- rbind(df_total, df_pagina)
}

write.xlsx(df_total, "FS Presentaciones - Enlaces.xlsx")

cat("listo :)")
