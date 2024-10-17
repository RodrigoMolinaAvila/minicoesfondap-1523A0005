# ---*** R10 CODES ***--- N°38

library(rvest)
library(tidyverse)
library(openxlsx)

base_url <- "https://chile21.cl/analisis-electoral/page/"
total_pages <- 41

links_list <- list()

for (page_num in 1:total_pages) {
  url <- paste0(base_url, page_num, "/")
  page <- read_html(url)
  
  links <- page %>%
    html_nodes("h3.wd-entities-title a") %>%
    html_attr("href")
  
  links_list[[page_num]] <- links
}

all_links <- unlist(links_list)

output_file <- "C21 Análisis Electoral - Enlaces.xlsx"
wb <- createWorkbook()
addWorksheet(wb, "Enlaces")

writeData(wb, sheet = 1, x = data.frame(Enlaces = all_links))

saveWorkbook(wb, output_file, overwrite = TRUE)

cat("Web scraping completado. Los enlaces se han guardado en", output_file)
