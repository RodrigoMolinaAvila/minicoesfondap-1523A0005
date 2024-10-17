# ---*** R10 CODES ***--- N°58

library(rvest)
library(tidyverse)
library(openxlsx)

enlaces <- c("https://fundacionsol.cl/blog/seminarios-6/post/imaginando-alternativas-populares-en-contexto-de-crisis-6870",
             "https://fundacionsol.cl/blog/seminarios-6/post/el-trabajo-al-centro-de-la-nueva-constitucion-6805",
             "https://fundacionsol.cl/blog/seminarios-6/post/seminario-internacional-la-disputa-por-la-seguridad-social-en-el-mundo-ii-6765",
             "https://fundacionsol.cl/blog/seminarios-6/post/seminario-internacional-la-disputa-por-la-seguridad-social-en-el-mundo-6747",
             "https://fundacionsol.cl/blog/seminarios-6/post/seminario-internacional-la-lucha-por-la-seguridad-social-en-america-latina-y-el-caribe-6716",
             "https://fundacionsol.cl/blog/seminarios-6/post/seminario-internacional-derribando-mitos-sobre-los-sistemas-de-reparto-fondos-de-pensiones-para-la-seguridad-social-o-el-mercado-financiero-6505",
             "https://fundacionsol.cl/blog/seminarios-6/post/seminario-costas-lapavitsas-los-tiempos-de-la-mercantilizacion-6504",
             "https://fundacionsol.cl/blog/seminarios-6/post/conferencia-silvia-federici-alternativas-populares-las-luchas-sociales-del-siglo-xxi-6503",
             "https://fundacionsol.cl/blog/seminarios-6/post/taller-internacional-construyendo-alternativas-populares-6502",
             "https://fundacionsol.cl/blog/seminarios-6/post/jornada-por-los-derechos-colectivos-de-los-trabajadores-6501",
             "https://fundacionsol.cl/blog/seminarios-6/post/seminario-internacional-capitalismo-estado-y-derechos-sociales-hoy-6500"
)

datos_totales <- data.frame()

for (i in 1:length(enlaces)) {
  url <- enlaces[i]
  
  mensaje_progreso <- paste("Extrayendo datos del enlace", i, "de", length(enlaces))
  print(mensaje_progreso)
  
  tryCatch({
    pagina <- read_html(url)
    
    titulo <- pagina %>% html_node("meta[property='og:title']") %>% html_attr("content")
    fecha_publicacion <- pagina %>% html_node("meta[property='article:published_time']") %>% html_attr("content")
    medio_comunicacion <- pagina %>% html_node("meta[property='og:description']") %>% html_attr("content")
    autor <- pagina %>% html_node("#o_wblog_post_content > div.o_wblog_post_content_field.o_wblog_read_text > p:nth-child(2)") %>% html_text()
    etiquetas <- pagina %>% html_nodes("meta[property^='article:tag']") %>% html_attr("content") %>% paste(collapse = ", ")
    
    datos_enlace <- data.frame(URL = url,
                               Título = titulo,
                               `Fecha de publicación` = fecha_publicacion,
                               `Medio de comunicación` = medio_comunicacion,
                               Autor = autor,
                               Etiquetas = etiquetas)
    
    datos_totales <- rbind(datos_totales, datos_enlace)
  }, error = function(e) {
    mensaje_error <- paste("Error en el enlace", i, ":", conditionMessage(e))
    print(mensaje_error)
  })
}

nombre_archivo <- "FS Seminarios.xlsx"
write.xlsx(datos_totales, file = nombre_archivo, row.names = FALSE)

mensaje_final <- paste("Listo :) y se ha guardado en el archivo", nombre_archivo)
print(mensaje_final)
