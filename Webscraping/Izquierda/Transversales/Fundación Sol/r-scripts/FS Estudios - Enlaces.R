# ---*** R10 CODES ***--- N°51

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

base_url <- "https://fundacionsol.cl/blog/estudios-2/page/"

num_paginas <- 13

df_total <- data.frame(Enlaces = character())

for (i in 1:num_paginas) {
  url <- paste0(base_url, i)
  enlaces_pagina <- getEnlaces(url)
  df_pagina <- data.frame(Enlaces = enlaces_pagina)
  df_total <- rbind(df_total, df_pagina)
}

write.xlsx(df_total, "FS Estudios - Enlaces.xlsx")

cat("listo :)")
