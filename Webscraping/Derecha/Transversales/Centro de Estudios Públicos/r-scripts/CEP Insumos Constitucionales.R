# ---*** R10 CODES ***--- N°3

library(rvest)
library(openxlsx)
library(tidyverse)

enlaces <- c("https://www.cepchile.cl/investigacion/insumos-constitucionales-un-aporte-a-la-discusion-constitucional-de-chile-2020-2021/",
             "https://www.cepchile.cl/investigacion/sistema-electoral-en-chile-una-discusion-necesaria/",
             "https://www.cepchile.cl/investigacion/desarrollo-productivo-recursos-naturales-y-medio-ambiente-en-la-nueva-constitucion/",
             "https://www.cepchile.cl/investigacion/tribunales-y-la-nueva-constitucion/",
             "https://www.cepchile.cl/investigacion/organos-autonomos-en-la-constitucion-como-regularlos/",
             "https://www.cepchile.cl/investigacion/parlamentarismo-o-semi-presidencialismo-opciones-al-regimen-presidencial-chileno/",
             "https://www.cepchile.cl/investigacion/debe-decir-algo-la-constitucion-sobre-la-modernizacion-del-estado/",
             "https://www.cepchile.cl/investigacion/descentralizacion-que-se-esta-haciendo-y-que-se-podria-hacer-en-un-proceso-constituyente/",
             "https://www.cepchile.cl/investigacion/iniciativa-exclusiva-economica-y-responsabilidad-fiscal/",
             "https://www.cepchile.cl/investigacion/el-semi-presidencialismo-frances-por-dentro-observaciones-de-un-testigo-2/"
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
  
  cat("Insumo Constitucional", i, "Procesado\n")
}

datos_completos <- do.call(rbind, resultados)

print(datos_completos)

write.xlsx(datos_completos, "CEP Insumos Constitucionales.xlsx")
