# ---*** R10 CODES ***--- N°61

library(rvest)
library(tidyverse)
library(openxlsx)

scrape_url <- function(url) {
  webpage <- read_html(url)
  
  titulo <- webpage %>%
    html_nodes("title") %>%
    html_text() %>%
    gsub(" - NodoXXI", "", .)
  
  autores <- webpage %>%
    html_nodes('meta[name="author"]') %>%
    html_attr("content") %>%
    strsplit(", ") %>%
    unlist()
  
  fecha_publicacion <- webpage %>%
    html_nodes(".et_pb_text_inner") %>%
    html_text() %>%
    str_extract("\\d+ [a-z]+ \\d{4}") %>%
    str_squish()
  
  data.frame(
    URL = url,
    Titulo = titulo,
    Autores = paste(autores, collapse = ", "),
    Fecha_Publicacion = fecha_publicacion
  )
}

enlaces <- c("https://www.nodoxxi.cl/estudios/2023/entrevista-a-felipe-ruiz-nuevas-formas-de-trabajo-las-nuevas-tecnologias-y-los-desafios-de-la-juventud-sindicalista-en-la-region/",
             "https://www.nodoxxi.cl/noticias/2023/analisis-feministas-del-anteproyecto-constitucional-2023/",
             "https://www.nodoxxi.cl/noticias/2022/dimensiones-cualitativas-en-el-proceso-electoral-reciente-elementos-para-la-interpretacion/",
             "https://www.nodoxxi.cl/noticias/2022/miradas-sobre-la-politica-del-gobierno-hacia-el-wallmapu/",
             "https://www.nodoxxi.cl/investigacion/2021/el-ano-de-la-lucha-por-la-vida/",
             "https://www.nodoxxi.cl/cuadernos-de-coyuntura/2020/rodrigo-mundaca/",
             "https://www.nodoxxi.cl/cuadernos-de-coyuntura/2020/catalina-perez-la-disputa-por-la-hegemonia-requiere-de-un-esfuerzo-que-supera-con-creces-el-ambito-de-lo-institucional/",
             "https://www.nodoxxi.cl/cuadernos-de-coyuntura/cc-23/2020/chalecos-amarillos-en-francia-potencias-y-limites-del-descontento/",
             "https://www.nodoxxi.cl/cuadernos-de-coyuntura/cc-23/2020/migracion-en-chile-notas-para-pensar-el-fenomeno-desde-la-izquierda/",
             "https://www.nodoxxi.cl/cuadernos-de-coyuntura/cc-23/2020/la-politica-militar-de-la-transicion-y-los-nuevos-desafios-de-la-defensa-nacional/",
             "https://www.nodoxxi.cl/cuadernos-de-coyuntura/2020/huelga-feminista-como-movimiento-estructurante-de-transformacion/",
             "https://www.nodoxxi.cl/cuadernos-de-coyuntura/2020/pugnas-empresariales-crecimiento-y-desafios-gubernamentales/",
             "https://www.nodoxxi.cl/cuadernos-de-coyuntura/2020/entrevista-con-cinzia-arruzza/",
             "https://www.nodoxxi.cl/cuadernos-de-coyuntura/2020/un-chile-que-cruje/",
             "https://www.nodoxxi.cl/cuadernos-de-coyuntura/2020/trastornar-la-democracia/",
             "https://www.nodoxxi.cl/noticias/2019/agenda-corta-de-fin-a-los-abusos-por-estudiar-y-condonacion-total-de-la-deuda/",
             "https://www.nodoxxi.cl/cuadernos-de-coyuntura/cc-21/2019/oposicion-para-que-2/",
             "https://www.nodoxxi.cl/cuadernos-de-coyuntura/cc-21/2019/el-movimiento-de-trabajadores-y-trabajadoras-en-chile-diagnostico-situacion-y-perspectivas-2/",
             "https://www.nodoxxi.cl/otros/2018/claudia-mix-si-el-fa-no-asume-que-existe-para-transformar-la-politica-y-el-modelo-estamos-mas-cerca-de-convertirnos-en-una-mala-copia-de-la-concertacion/",
             "https://www.nodoxxi.cl/otros/2018/juan-ignacio-latorre-no-hemos-sido-capaces-de-construir-un-partido-del-desorden/",
             "https://www.nodoxxi.cl/otros/2018/carlos-montes-creo-que-el-desafio-de-comprender-y-acercarse-a-la-sociedad-esta-siendo-un-desafio-para-todos-los-actores-de-la-politica-nacional/",
             "https://www.nodoxxi.cl/otros/2018/daniel-jadue-en-el-gobierno-de-bachelet-se-inicia-un-punto-de-inflexion-la-transicion-institucional-a-la-democracia/",
             "https://www.nodoxxi.cl/otros/2018/diamela-eltit-en-la-transicion-nunca-deje-de-mirar-lo-que-tenia-que-mirar/",
             "https://www.nodoxxi.cl/otros/2018/liberalismo-y-neoliberalismo-el-partido-liberal-en-el-frente-amplio/",
             "https://www.nodoxxi.cl/otros/2018/la-cultura-en-la-transicion-la-eficiente-construccion-de-una-nueva-logica/",
             "https://www.nodoxxi.cl/otros/2018/desarrollo-economico-y-desigualdad-durante-la-transicion-a-la-democracia-en-chile-1990-2009/",
             "https://www.nodoxxi.cl/otros/2018/balances-de-la-transicion/",
             "https://www.nodoxxi.cl/otros/2018/balance-politico-de-la-transicion/",
             "https://www.nodoxxi.cl/otros/2018/68-un-modelo-para-armar/",
             "https://www.nodoxxi.cl/otros/2018/oposicion-para-que/",
             "https://www.nodoxxi.cl/cuadernos-de-coyuntura/cuadernos-de-coyuntura-archivo/2018/el-movimiento-de-trabajadores-y-trabajadoras-en-chile-diagnostico-situacion-y-perspectivas/",
             "https://www.nodoxxi.cl/cuadernos-de-coyuntura/cuadernos-de-coyuntura-archivo/2018/prevalencias-transicionales-desafios-ante-la-actual-cuestion-constitucional/",
             "https://www.nodoxxi.cl/cuadernos-de-coyuntura/cuadernos-de-coyuntura-archivo/2018/lula-y-el-pt-el-desafio-de-ser-gobierno-con-protagonismo-popular/",
             "https://www.nodoxxi.cl/cuadernos-de-coyuntura/cc-22/2018/las-deudas-de-la-transicion-y-el-largo-camino-en-derechos-humanos/",
             "https://www.nodoxxi.cl/cuadernos-de-coyuntura/cuadernos-de-coyuntura-archivo/2018/veronica-gago-el-movimiento-feminista-muestra-que-se-puede-ser-muy-masivo-y-muy-radical-a-la-vez/",
             "https://www.nodoxxi.cl/cuadernos-de-coyuntura/cuadernos-de-coyuntura-archivo/2018/el-feminismo-como-posibilidad-de-ampliacion-democratica/",
             "https://www.nodoxxi.cl/cuadernos-de-coyuntura/cuadernos-de-coyuntura-archivo/2018/el-desborde-feminista/",
             "https://www.nodoxxi.cl/cuadernos-de-coyuntura/cuadernos-de-coyuntura-archivo/2018/las-luchas-de-ayer-y-hoy-la-centralidad-politica-de-los-derechos-sociales/",
             "https://www.nodoxxi.cl/cuadernos-de-coyuntura/cuadernos-de-coyuntura-archivo/2018/la-izquierda-y-el-balance-del-gobierno-de-bachelet-contra-el-mito/",
             "https://www.nodoxxi.cl/cuadernos-de-coyuntura/cuadernos-de-coyuntura-archivo/2018/fin-de-la-hegemonia-progresista-y-giro-represivo-en-america-latina/",
             "https://www.nodoxxi.cl/cuadernos-de-coyuntura/cuadernos-de-coyuntura-archivo/2018/radicalizacion-del-consenso-neoliberal-en-chile-2006-2017/",
             "https://www.nodoxxi.cl/cuadernos-de-coyuntura/cuadernos-de-coyuntura-archivo/2018/hacia-la-utopia-del-mercado-gratuito/",
             "https://www.nodoxxi.cl/noticias/2018/del-aval-del-estado-al-estado-acreedor-claves-para-el-analisis-del-nuevo-sistema-de-financiamiento-solidario%e2%80%8b/",
             "https://www.nodoxxi.cl/cuadernos-de-coyuntura/cuadernos-de-coyuntura-archivo/2018/suscribete-a-la-revista-cuadernos-de-coyuntura/",
             "https://www.nodoxxi.cl/cuadernos-de-coyuntura/cuadernos-de-coyuntura-archivo/2018/editorial-20-la-emergencia-politica-pendiente/",
             "https://www.nodoxxi.cl/cuadernos-de-coyuntura/cuadernos-de-coyuntura-archivo/2018/entrevista-a-antonio-negri-hoy-autonomia-significa-buscar-lo-comun/",
             "https://www.nodoxxi.cl/cuadernos-de-coyuntura/cuadernos-de-coyuntura-archivo/2018/mercado-y-subsidiariedad-el-financiamiento-de-la-investigacion-en-chile/"
             
)

datos_lista <- map_df(enlaces, scrape_url)

datos_filtrados <- datos_lista %>%
  filter_all(all_vars(. != "N/A"))

ruta_archivo <- "NXXI Investigación.xlsx"
write.xlsx(datos_filtrados, ruta_archivo, rowNames = FALSE)

cat("Web scraping para la lista de enlaces completado y datos filtrados guardados en", ruta_archivo, "\n")
