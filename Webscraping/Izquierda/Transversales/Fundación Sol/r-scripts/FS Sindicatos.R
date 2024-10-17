# ---*** R10 CODES ***--- N°60

library(rvest)
library(tidyverse)
library(openxlsx)

enlaces <- c("https://fundacionsol.cl/blog/sindicatos-12/post/sindicatos-de-planta-se-fusionan-y-forman-una-de-las-mayores-organizaciones-de-trabajadores-del-transporte-publico-y-del-pais-7373",
             "https://fundacionsol.cl/blog/sindicatos-12/post/el-desafio-sindical-de-la-negociacion-colectiva-por-rama-7363",
             "https://fundacionsol.cl/blog/sindicatos-12/post/fortalecimiento-sindical-2022-7360",
             "https://fundacionsol.cl/blog/sindicatos-12/post/derechos-laborales-colectivos-fueron-tratados-en-conmemoracion-del-dia-del-trabajo-en-facso-7327",
             "https://fundacionsol.cl/blog/sindicatos-12/post/exitoso-encuentro-sindical-profundiza-en-negociacion-sectorial-7328",
             "https://fundacionsol.cl/blog/sindicatos-12/post/falabella-multimillonarias-utilidades-a-costa-de-despidos-masivos-e-imposicion-de-contratos-multifuncionales-7359",
             "https://fundacionsol.cl/blog/sindicatos-12/post/organizaciones-sindicales-reafirman-compromiso-de-trabajo-para-evitar-nuevos-retrocesos-7319",
             "https://fundacionsol.cl/blog/sindicatos-12/post/rechazo-a-la-flexibilidad-inedita-del-proyecto-de-ley-40-horas-7317",
             "https://fundacionsol.cl/blog/sindicatos-12/post/fortalecimiento-sindical-2021-6914",
             "https://fundacionsol.cl/blog/sindicatos-12/post/primer-censo-portuario-6883",
             "https://fundacionsol.cl/blog/sindicatos-12/post/sindicato-weplay-chile-en-huelga-7086",
             "https://fundacionsol.cl/blog/sindicatos-12/post/comunicado-del-sindicato-de-trabajadores-y-trabajadoras-de-ucsc-7085",
             "https://fundacionsol.cl/blog/sindicatos-12/post/sindicatos-mina-y-planta-de-minera-florida-continuan-huelga-6815",
             "https://fundacionsol.cl/blog/sindicatos-12/post/11-dias-de-huelga-sindicatos-mina-y-planta-minera-florida-6814",
             "https://fundacionsol.cl/blog/sindicatos-12/post/financiamiento-de-las-universidades-del-estado-en-chile-6812",
             "https://fundacionsol.cl/blog/sindicatos-12/post/comunicado-publico-sintrasub-sename-6795",
             "https://fundacionsol.cl/blog/sindicatos-12/post/comunicado-publico-tercera-semana-de-huelga-sindicato-isapre-nueva-masvida-6790",
             "https://fundacionsol.cl/blog/sindicatos-12/post/comunicado-publico-huelga-sindicato-nacional-isapre-nueva-mas-vida-6779",
             "https://fundacionsol.cl/blog/sindicatos-12/post/despido-masivo-declaracion-publica-sindicatos-unidos-bupa-chile-6984",
             "https://fundacionsol.cl/blog/sindicatos-12/post/consulta-minera-covid-19-6768",
             "https://fundacionsol.cl/blog/sindicatos-12/post/pensiones-en-el-sector-minero-6752",
             "https://fundacionsol.cl/blog/sindicatos-12/post/declaracion-publica-sindicato-de-trabajadores-n1-de-chilquinta-energia-s-a-6985",
             "https://fundacionsol.cl/blog/sindicatos-12/post/transnacional-de-ti-con-millonarias-utilidades-en-pandemia-rehusa-negociar-6986",
             "https://fundacionsol.cl/blog/sindicatos-12/post/prodemu-encuesta-nacional-condiciones-de-trabajo-hogar-y-salud-durante-la-pademia-del-covid-19-6746",
             "https://fundacionsol.cl/blog/sindicatos-12/post/fortaleciendo-la-institucionalidad-para-el-acceso-a-la-justicia-6745",
             "https://fundacionsol.cl/blog/sindicatos-12/post/siguen-los-despidos-ahora-es-el-turno-de-luniben-6987",
             "https://fundacionsol.cl/blog/sindicatos-12/post/comunicado-huelga-sindicado-n1-udec-6990",
             "https://fundacionsol.cl/blog/sindicatos-12/post/despidos-en-fundacion-prodemu-6996",
             "https://fundacionsol.cl/blog/sindicatos-12/post/apoya-al-sindicato-komatsu-7019",
             "https://fundacionsol.cl/blog/sindicatos-12/post/comunicado-sindicato-empresa-luniben-topfrio-4011"
             
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

nombre_archivo <- "FS Sindicatos.xlsx"
write.xlsx(datos_totales, file = nombre_archivo, row.names = FALSE)

mensaje_final <- paste("Listo :) y se ha guardado en el archivo", nombre_archivo)
print(mensaje_final)
