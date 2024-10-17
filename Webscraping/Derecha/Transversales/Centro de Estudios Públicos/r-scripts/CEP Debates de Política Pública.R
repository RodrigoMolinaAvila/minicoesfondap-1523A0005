# ---*** R10 CODES ***--- N°1


library(rvest)
library(openxlsx)
library(tidyverse)

enlaces <- c("https://www.cepchile.cl/investigacion/una-mirada-a-la-dependencia-en-chile/",
             "https://www.cepchile.cl/investigacion/radiografia-a-las-necesidades-de-los-grupos-a-y-b-de-fonasa/",
             "https://www.cepchile.cl/investigacion/covid%e2%80%9019-algunos-aprendizajes-para-enfrentar-la-pandemia-en-chile/",
             "https://www.cepchile.cl/investigacion/etica-de-la-abogacia-en-chile-el-problema-de-la-regulacion/",
             "https://www.cepchile.cl/investigacion/impacto-de-la-construccion-de-condominios-sociales-en-altura-en-los-precios-y-la-cantidad-de-transacciones-de-las-viviendas-ubicadas-en-zonas-aledanas/",
             "https://www.cepchile.cl/investigacion/nombramientos-de-ministros-de-las-cortes-de-apelaciones-y-de-la-corte-suprema-sintesis-y-sistematizacion-de-su-regulacion/",
             "https://www.cepchile.cl/investigacion/financiamiento-de-la-educacion-superior-gratuidad-y-proyecto-de-nuevo-credito-estudiantil/",
             "https://www.cepchile.cl/investigacion/aportes-para-una-reforma-a-los-seguros-de-salud-una-propuesta-y-tres-comentarios/",
             "https://www.cepchile.cl/investigacion/de-la-casa-al-trabajo-analisis-de-un-tiempo-perdido/",
             "https://www.cepchile.cl/investigacion/un-estado-para-la-ciudadania-resumen-de-propuestas/",
             "https://www.cepchile.cl/investigacion/reformas-a-la-justicia-2006-2017/",
             "https://www.cepchile.cl/investigacion/rediseno-de-la-politica-social-avanzando-a-una-menor-desigualdad/",
             "https://www.cepchile.cl/investigacion/reformando-el-sistema-de-seguros-de-salud-chileno-eleccion-competencia-regulada-y-subsidios-por-riesgo/",
             "https://www.cepchile.cl/investigacion/incendios-forestales-implicancias-de-politica-publica/",
             "https://www.cepchile.cl/investigacion/political-approval-ratings-and-economic-performance-evidence-from-latin-america/",
             "https://www.cepchile.cl/investigacion/quien-debe-iniciar-la-accion-penal-en-materia-tributaria/",
             "https://www.cepchile.cl/investigacion/criticas-a-la-metodologia-y-sistematizacion-del-proceso-constitucional/",
             "https://www.cepchile.cl/investigacion/autonomia-de-las-instituciones-de-educacion-superior-en-el-proyecto-de-ley-de-educacion-superior-una-mirada-desde-la-perspectiva-de-los-criterios-de-la-comunidad-europea/",
             "https://www.cepchile.cl/investigacion/desarrollo-urbano-de-santiago-perspectivas-y-lecciones/",
             "https://www.cepchile.cl/investigacion/mas-equidad-y-eficiencia-en-isapres-evaluacion-y-propuestas-al-mecanismo-de-compensacion-de-riesgos/",
             "https://www.cepchile.cl/investigacion/acuerdo-transpacifico-de-libre-comercio-tpp-propiedad-intelectual-e-internet-dos-visiones-2/",
             "https://www.cepchile.cl/investigacion/tricel-historia-legislacion-comparada-y-revision-de-sus-funciones/",
             "https://www.cepchile.cl/investigacion/el-dialogo-de-dos-desafios-evolucion-y-relacion-de-la-desigualdad-y-la-escolaridad-en-chile/",
             "https://www.cepchile.cl/investigacion/cambios-en-la-participacion-electoral-tras-la-inscripcion-automatica-y-el-voto-voluntario/",
             "https://www.cepchile.cl/investigacion/las-desigualdades-en-la-atencion-medica-en-los-ultimos-20-anos/",
             "https://www.cepchile.cl/investigacion/enfoques-complementarios-para-la-evaluacion-social-de-proyectos/",
             "https://www.cepchile.cl/investigacion/reforma-de-la-politica-una-mirada-sistemica/",
             "https://www.cepchile.cl/investigacion/comunidades-locales-y-proyectos-de-inversion-hacia-la-construccion-de-consensos/",
             "https://www.cepchile.cl/investigacion/la-prohibicion-a-los-fines-de-lucro-y-propuestas-de-gobierno-para-las-universidades-chilenas/",
             "https://www.cepchile.cl/investigacion/fortalecimiento-de-la-carrera-docente/",
             "https://www.cepchile.cl/investigacion/fortalecimiento-de-la-funcion-fiscalizadora-del-servel/",
             "https://www.cepchile.cl/investigacion/subsidio-al-arriendo-primeros-resultados-y-pasos-a-seguir/",
             "https://www.cepchile.cl/investigacion/el-sector-energetico-en-chile-y-la-agenda-de-energia-2014-algunos-elementos-para-la-discusion/",
             "https://www.cepchile.cl/investigacion/impuesto-territorial-y-financiamiento-municipal/",
             "https://www.cepchile.cl/investigacion/desafios-y-algunos-lineamientos-para-el-sistema-de-seguros-de-salud-en-chile/",
             "https://www.cepchile.cl/investigacion/financiamiento-permanente-no-electoral-de-los-partidos-politicos/",
             "https://www.cepchile.cl/investigacion/un-sistema-electoral-mixto-para-el-presidencialismo-chileno/"
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
  
  cat("Debate de Política Pública", i, "Procesado\n")
}

datos_completos <- do.call(rbind, resultados)

print(datos_completos)

write.xlsx(datos_completos, "CEP Debates de Política Pública.xlsx")
