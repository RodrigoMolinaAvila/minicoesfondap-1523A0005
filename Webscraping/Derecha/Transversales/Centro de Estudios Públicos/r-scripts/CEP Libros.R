# ---*** R10 CODES ***--- N°4

library(rvest)
library(openxlsx)
library(tidyverse)

enlaces <- c("https://www.cepchile.cl/investigacion/disparidad-bajo-la-lupa-radiografia-de-las-brechas-de-genero-en-chile/",
             "https://www.cepchile.cl/investigacion/100-anos-de-nicanor-parra/",
             "https://www.cepchile.cl/investigacion/kant-y-la-conciencia-moral/",
             "https://www.cepchile.cl/investigacion/poder-en-el-sistema/",
             "https://www.cepchile.cl/investigacion/mapudungun-el-habla-mapuche-nueva-edicion-revisada/",
             "https://www.cepchile.cl/investigacion/diez-miradas-sobre-el-sistema-de-gobierno/",
             "https://www.cepchile.cl/investigacion/para-leer-la-divina-comedia/",
             "https://www.cepchile.cl/investigacion/reedicion-aspectos-economicos-de-la-constitucion-alternativas-y-propuestas-para-chile/",
             "https://www.cepchile.cl/investigacion/la-democracia-en-chile-trayectoria-de-sisifo/",
             "https://www.cepchile.cl/investigacion/aspectos-economicos-de-la-constitucion-alternativas-y-propuestas-para-chile-2/",
             "https://www.cepchile.cl/investigacion/propuestas-para-una-reforma-integral-del-fondo-nacional-de-salud/",
             "https://www.cepchile.cl/investigacion/reedicion-inmigracion-en-chile-una-mirada-multidimensional/",
             "https://www.cepchile.cl/investigacion/chile-constitucional/",
             "https://www.cepchile.cl/investigacion/mas-alla-de-santiago-descentralizacion-fiscal-en-chile/",
             "https://www.cepchile.cl/investigacion/andres-bello-libertad-imperio-estilo/",
             "https://www.cepchile.cl/investigacion/encantamientos-en-prosa-conversando-con-peter-sloterdijk/",
             "https://www.cepchile.cl/investigacion/inmigracion-en-chile-una-mirada-multidimensional/",
             "https://www.cepchile.cl/investigacion/informes-grupo-de-trabajo-para-la-modernizacion-del-estado/",
             "https://www.cepchile.cl/investigacion/modernizacion-sus-otras-caras/",
             "https://www.cepchile.cl/investigacion/selected-papers-on-greek-thought/",
             "https://www.cepchile.cl/investigacion/un-estado-para-la-ciudadania-estudios-para-su-modernizacion/",
             "https://www.cepchile.cl/investigacion/energias-renovables-en-chile-hacia-una-insercion-eficiente-en-la-matriz-electrica/",
             "https://www.cepchile.cl/investigacion/un-estado-para-la-ciudadania-informe-de-la-comision-de-modernizacion-del-estado/",
             "https://www.cepchile.cl/investigacion/el-pueblo-mapuche-en-el-siglo-xxi-propuestas-para-un-nuevo-entendimiento-entre-culturas-en-chile/",
             "https://www.cepchile.cl/investigacion/propuesta-de-modernizacion-y-fortalecimiento-de-los-prestadores-estatales-de-servicios-de-salud/",
             "https://www.cepchile.cl/investigacion/malestar-en-chile-informe-encuesta-cep-2016/",
             "https://www.cepchile.cl/investigacion/la-fragil-universidad-seguido-de-derechos-sociales-deliberacion-publica-y-universidad/",
             "https://www.cepchile.cl/investigacion/igualitarismo-una-discusion-necesaria/",
             "https://www.cepchile.cl/investigacion/geografia-de-pajaros-chile-central/",
             "https://www.cepchile.cl/investigacion/dialogos-constitucionales-la-academia-y-la-cuestion-constitucional-en-chile/",
             "https://www.cepchile.cl/investigacion/propuestas-constitucionales-la-academia-y-el-cambio-constitucional-en-chile/",
             "https://www.cepchile.cl/investigacion/growth-opportunities-for-chile/",
             "https://www.cepchile.cl/investigacion/los-mil-dias-de-allende-portadas-y-recortes-de-prensa-fotografias-y-caricaturas/",
             "https://www.cepchile.cl/investigacion/la-revolucion-inconclusa-la-izquierda-chilena-y-el-gobierno-de-la-unidad-popular/",
             "https://www.cepchile.cl/investigacion/vidas-revolucionarias/",
             "https://www.cepchile.cl/investigacion/tributacion-para-el-desarrollo-estudios-para-la-reforma-del-sistema-chileno/",
             "https://www.cepchile.cl/investigacion/democracia-con-partidos-informe-para-la-reforma-de-los-partidos-politicos-en-chile/"
             
)

resultados <- list()

for (i in 1:length(enlaces)) {
  url <- enlaces[i]
  page <- read_html(url)
  
  titulo <- page %>%
    html_node(".banner-title") %>%
    html_text()
  
  fecha_publicacion <- page %>%
    html_node(".banner-date") %>%
    html_text()
  
  autores <- page %>%
    html_node(".lyrics p") %>%
    html_text()
  
  etiquetas <- page %>%
    html_nodes(".display-badges .badge") %>%
    html_text() %>%
    paste(collapse = ", ")
  
  edicion <- page %>%
    html_node(".number-single") %>%
    html_text()
  
  resultados[[i]] <- data.frame(Título = titulo,
                                `Fecha de publicación` = fecha_publicacion,
                                Autor = autores,
                                Etiquetas = etiquetas,
                                Edición = edicion,
                                URL = url)
  
  cat("Libro", i, "Procesado\n")
}

datos_completos <- do.call(rbind, resultados)

print(datos_completos)

write.xlsx(datos_completos, "CEP Libros.xlsx")
