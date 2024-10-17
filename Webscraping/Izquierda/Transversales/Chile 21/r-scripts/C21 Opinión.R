# ---*** R10 CODES ***--- N°43

enlaces <- c("https://chile21.cl/chile-2023-como-reducir-la-brecha-de-ingobernabilidad-democratica/",
             "https://chile21.cl/analisis-de-los-programas-de-gobierno-en-educacion-de-las-candidaturas-de-centro-izquierda/",
             "https://chile21.cl/el-relativismo-historico-puede-conducir-al-fascismo/",
             "https://chile21.cl/el-descaro-pinera-y-allamand-se-van-a-europa/",
             "https://chile21.cl/candidatos-y-cultura/",
             "https://chile21.cl/por-una-deliberacion-de-calidad-en-la-convencion-constitucional/",
             "https://chile21.cl/a-pesar-de-las-excusas-y-falta-de-voluntad-no-todo-esta-perdido/",
             "https://chile21.cl/mapuche-gente-de-la-tierra/",
             "https://chile21.cl/la-arquitectura-constitucional-de-la-desigualdad/",
             "https://chile21.cl/transparencia-informacion-y-proceso-constituyente/",
             "https://chile21.cl/el-mejor-plebiscito-del-mundo-2/",
             "https://chile21.cl/plebiscito-cuidado-con-las-noticias-falsas/",
             "https://chile21.cl/el-mejor-plebiscito-del-mundo/",
             "https://chile21.cl/america-latina-tras-seis-meses-de-pandemia/",
             "https://chile21.cl/otra-mirada-a-50-anos-del-triunfo-de-salvador-allende/",
             "https://chile21.cl/es-posible-una-nueva-europa/",
             "https://chile21.cl/rectificar-el-rumbo-para-volver-a-lo-mismo/",
             "https://chile21.cl/fin-del-dogma/",
             "https://chile21.cl/estallidos-a-flor-de-piel/",
             "https://chile21.cl/acuerdo-nacional-la-agenda-oculta/",
             "https://chile21.cl/un-mundo-nunca-imaginado/",
             "https://chile21.cl/se-deben-modificar-las-atribuciones-constitucionales-de-las-fuerzas-armadas-y-carabineros/",
             "https://chile21.cl/el-malestar-social-chileno/",
             "https://chile21.cl/que-mas-debe-suceder-para-que-los-politicos-escuchen-a-la-ciencia/",
             "https://chile21.cl/cambio-de-era/",
             "https://chile21.cl/el-chile-de-hoy-y-el-progresismo-del-manana-desde-la-crisis-social-a-la-institucional-y-a-la-pandemia/",
             "https://chile21.cl/despues-de-la-pandemia-desglobalizacion-estado-policial-o-mas-democracia/",
             "https://chile21.cl/peras-al-olmo/",
             "https://chile21.cl/america-latina-democracia-amenazada/",
             "https://chile21.cl/covid-19-datos-abiertos-ahora/",
             "https://chile21.cl/barrer-la-violencia-bajo-la-alfombra/",
             "https://chile21.cl/una-agenda-sin-dientes-contra-los-abusos-del-consumidor/",
             "https://chile21.cl/chile-estallido-social-e-imagen-exterior/",
             "https://chile21.cl/desafios-politicos-a-ambos-lados-del-rio-de-la-plata/",
             "https://chile21.cl/bolivia-la-tragedia-altiplanica/",
             "https://chile21.cl/el-problema-es-la-crisis-del-regimen-representativo/",
             "https://chile21.cl/proceso-constituyente/",
             "https://chile21.cl/expectativas-sobre-un-nuevo-pacto/",
             "https://chile21.cl/alcances-y-limites-de-la-nueva-agenda-social-del-gobierno/",
             "https://chile21.cl/el-guason-y-la-explosion-de-la-sociedad-civil-en-chile/",
             "https://chile21.cl/un-debate-economico-sin-complejos/",
             "https://chile21.cl/la-rebelion/",
             "https://chile21.cl/el-octubre-rojo-latinoamericano/",
             "https://chile21.cl/la-estrategia-de-seguridad-del-gobierno-fracaso-2/",
             "https://chile21.cl/el-libro-de-landerretche-de-populismo-y-del-gobierno-de-los-que-saben/",
             "https://chile21.cl/presupuesto-2020-y-agenda-reactivadora/",
             "https://chile21.cl/gobernadores-regionales-oportunidad-para-las-metropolis/",
             "https://chile21.cl/liderazgo-internacional-del-presidente-pinera/",
             "https://chile21.cl/tiempo-de-accion-no-de-actuacion/",
             "https://chile21.cl/y-el-centro-de-gobierno/",
             "https://chile21.cl/divorcio-entre-tecnica-y-politica-o-el-argumento-tecnico-como-forma-de-hacer-politica/",
             "https://chile21.cl/el-ultimo-libro-de-piketty-la-reivindicacion-del-socialismo-participativo/",
             "https://chile21.cl/que-paso-en-las-paso/",
             "https://chile21.cl/rrss-en-campana-peligro-de-sordera/",
             "https://chile21.cl/gobierno-de-pinera-quo-vadis/",
             "https://chile21.cl/argentina-el-fracaso-economico-de-macri/",
             "https://chile21.cl/cuando-la-politica-comunicacional-toma-el-lugar-de-la-politica-economica/",
             "https://chile21.cl/desierto-florido/",
             "https://chile21.cl/renovacion-en-el-pc/",
             "https://chile21.cl/economia-y-corrupcion-las-antilecciones-macristas/",
             "https://chile21.cl/hemos-fracasado/",
             "https://chile21.cl/ficciones-argentinas-el-asado-segun-macri-o-peron/",
             "https://chile21.cl/la-inteligencia-y-el-terrorismo/",
             "https://chile21.cl/regulacion-en-problemas/",
             "https://chile21.cl/no-llores-por-mi-argentina/",
             "https://chile21.cl/cumbre-g20-un-encuentro-inocuo/",
             "https://chile21.cl/espana-el-complejo-camino-a-la-investidura-de-sanchez/",
             "https://chile21.cl/rebobinando-que-esta-en-juego-con-la-reforma-tributaria-y-la-de-pensiones/",
             "https://chile21.cl/encuestas-y-medios-perversa-luna-de-miel/",
             "https://chile21.cl/el-nuevo-gabinete/",
             "https://chile21.cl/china-ee-uu-guerra-fria-siglo-xxi/",
             "https://chile21.cl/el-cambio-de-equipo-ministerial-permite-superar-los-deficits-de-la-conduccion-economica/",
             "https://chile21.cl/la-democracia-secuestrada-por-los-partidos/",
             "https://chile21.cl/el-futuro-del-trabajo-en-un-mundo-complejo/",
             "https://chile21.cl/chile-avanza-hacia-la-confianza/",
             "https://chile21.cl/elecciones-en-el-parlamento-europeo-una-mirada-no-complaciente/",
             "https://chile21.cl/de-oposiciones-y-pensiones/",
             "https://chile21.cl/los-sinsabores-de-un-cliente-de-movistar/",
             "https://chile21.cl/triunfo-del-psoe-esperanza-politica-para-europa/",
             "https://chile21.cl/expectativas-negativas-convergen-con-la-desaceleracion-de-la-economia/",
             "https://chile21.cl/europa-en-tiempos-de-borrasca/",
             "https://chile21.cl/sanchez-la-esperanza-y-la-coincidencia/",
             "https://chile21.cl/hablar-de-seguridad-es-hablar-de-desigualdad/",
             "https://chile21.cl/venezuela-una-disputa-sin-ganadores-pero-con-miles-de-perdedores/",
             "https://chile21.cl/chile-la-centroizquierda-dividida/",
             "https://chile21.cl/luces-pero-mas-sombras/",
             "https://chile21.cl/volver-a-discutir-para-construir-identidad/",
             "https://chile21.cl/el-tpp-11/",
             "https://chile21.cl/els-perills-per-a-la-democracia-a-america-llatina/",
             "https://chile21.cl/debate-tributario-gravosa-carga/",
             "https://chile21.cl/jugando-con-el-miedo-politicas-de-inseguridad-en-chile-y-argentina/",
             "https://chile21.cl/vigilancia-y-datos-personales/",
             "https://chile21.cl/bolsonaro-mal-pronostico/",
             "https://chile21.cl/aprender-a-vivir-en-un-mundo-con-drogas/",
             "https://chile21.cl/cabalgamos-sancho/",
             "https://chile21.cl/dialogo-y-acuerdos/",
             "https://chile21.cl/nuevas-razones-para-rechazar-idea-de-legislar-la-reforma-tributaria/",
             "https://chile21.cl/coherencia-democratica-y-convicciones-politicas/",
             "https://chile21.cl/el-cambio-de-gabinete-la-respuesta-a-los-problemas-del-gobierno/",
             "https://chile21.cl/el-largo-camino-que-espera-a-la-oposicion/",
             "https://chile21.cl/chile-una-politica-exterior-erronea/",
             "https://chile21.cl/afps-las-beneficiarias-de-la-reforma/",
             "https://chile21.cl/efectismo-y-politicas-publicas/",
             "https://chile21.cl/oposicion-en-la-encrucijada/",
             "https://chile21.cl/transferencia-de-competencias-a-gobiernos-regionales-un-menu-con-gusto-a-poco/",
             "https://chile21.cl/en-defensa-del-dato-oficial/",
             "https://chile21.cl/chile-en-marcha-hacia-donde/",
             "https://chile21.cl/presidente-con-chile-no-se-juega/",
             "https://chile21.cl/noticias-falsas-y-responsabilidad-social/",
             "https://chile21.cl/100-anos-de-la-oit-mas-vigente-y-necesaria-que-nunca/",
             "https://chile21.cl/por-que-frei-una-verdad-historica-que-nos-compromete-con-el-futuro/",
             "https://chile21.cl/chile-y-la-percepcion-de-corrupcion/",
             "https://chile21.cl/como-parar-a-la-extrema-derecha-en-el-mundo-occidental/",
             "https://chile21.cl/la-izquierda-madurista/",
             "https://chile21.cl/tiempos-de-tormenta-o-de-colera-para-la-europa-del-2019/",
             "https://chile21.cl/un-esfuerzo-transversal-para-la-modernizacion-del-estado/",
             "https://chile21.cl/jaime-ensignia-en-el-periodista-6/",
             "https://chile21.cl/columna-de-gloria-de-la-fuente-el-pacto/",
             "https://chile21.cl/gloria-de-la-fuente-en-la-tercera-el-dia-de-la-marmota/",
             "https://chile21.cl/jaime-ensignia-en-catalunyapress-brasil-una-amarga-derrota/",
             "https://chile21.cl/jaime-ensignia-en-catalunyapress-brasil-una-amarga-derrota-2/",
             "https://chile21.cl/jaime-ensignia-en-panoramica/",
             "https://chile21.cl/carlos-ominami-la-responsabilidad-democratica-de-la-izquierda/",
             "https://chile21.cl/gloria-de-la-fuente-oposiciones-y-sentido-comun/",
             "https://chile21.cl/jaime-ensignia-elecciones-regionales-en-baviera-requiem-para-los-socialdemocratas/",
             "https://chile21.cl/columna-de-carlos-ominami-defensa-de-una-carta/",
             "https://chile21.cl/columna-de-gloria-de-la-fuente-hasta-siempre-ana/",
             "https://chile21.cl/jaime-ensignia-en-el-periodista-5/",
             "https://chile21.cl/jaime-ensignia-en-el-periodista-4/",
             "https://chile21.cl/jaime-ensignia-en-el-periodista-3/",
             "https://chile21.cl/gloria-de-la-fuente-en-la-tercera-4/",
             "https://chile21.cl/francisco-vidal-en-el-mercurio/",
             "https://chile21.cl/carlos-ominami-en-la-tercera-4/",
             "https://chile21.cl/gloria-de-la-fuente-en-la-tercera-3/"
             
)

library(rvest)
library(tidyverse)
library(openxlsx)

resultados <- list()

for (i in seq_along(enlaces)) {
  url <- enlaces[i]
  webpage <- read_html(url)
  
  fecha_publicacion <- webpage %>%
    html_nodes('meta[property="article:published_time"]') %>%
    html_attr("content")
  
  titulo <- webpage %>%
    html_nodes('meta[property="og:title"]') %>%
    html_attr("content")
  
  fecha_publicacion <- ifelse(length(fecha_publicacion) > 0, fecha_publicacion, NA)
  titulo <- ifelse(length(titulo) > 0, titulo, NA)
  
  data <- data.frame(Enlace = url,
                     Fecha_Publicacion = fecha_publicacion,
                     Titulo = titulo)
  
  resultados[[i]] <- data
  
  cat("Web scraping completado para el enlace", i, "\n")
}

resultados_completos <- bind_rows(resultados)

nombre_archivo <- "C21 Opinión.xlsx"
write.xlsx(resultados_completos, nombre_archivo, row.names = FALSE)

cat("Los datos se han guardado en el archivo", nombre_archivo, "\n")
