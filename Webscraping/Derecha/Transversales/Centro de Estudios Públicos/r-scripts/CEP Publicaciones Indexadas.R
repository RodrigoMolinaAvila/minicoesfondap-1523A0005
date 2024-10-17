# ---*** R10 CODES ***--- N°6

library(rvest)
library(openxlsx)
library(tidyverse)

enlaces <- c("https://www.cepchile.cl/investigacion/sesgo-notas-ensenanza-media-nem-propuestas-para-perfeccionar-instrumentos-seleccion-educacion-superior/",
             "https://www.cepchile.cl/investigacion/educacion-en-tiempos-de-pandemia-antecedentes-y-recomendaciones-para-la-discusion-en-chile/",
             "https://www.cepchile.cl/investigacion/la-constitucion-y-los-derechos-economicos-y-sociales-capitulo-de-libro/",
             "https://www.cepchile.cl/investigacion/estado-subsidiario-y-estado-empresario-capitulo-de-libro/",
             "https://www.cepchile.cl/investigacion/donde-estudian-como-les-va-y-que-impacto-tienen-los-escolares-inmigrantes-capitulo-de-libro/",
             "https://www.cepchile.cl/investigacion/introduccion-los-entes-autonomos-en-el-derecho-constitucional-latinoamericano/",
             "https://www.cepchile.cl/investigacion/el-derecho-administrativo-comun-en-america-latina-desde-una-perspectiva-comparada-consideraciones-introductorias/",
             "https://www.cepchile.cl/investigacion/sexo-del-candidato-corrupcion-y-voto/",
             "https://www.cepchile.cl/investigacion/la-derecha-chilena-en-la-encrucijada-la-contrahegemonia-de-los-liderazgos-subnacionales-y-solidarios-2/",
             "https://www.cepchile.cl/investigacion/cooperacion-y-polarizacion-en-un-congreso-bajo-regimen-presidencial-redes-de-co-autoria-en-la-camara-de-diputados-chilena-2006-2017/",
             "https://www.cepchile.cl/investigacion/las-protestas-chilenas-de-2019-2020-una-primera-mirada-a-sus-causas-y-participantes/",
             "https://www.cepchile.cl/investigacion/educacion-en-tiempos-de-pandemia-antecedentes-y-recomendaciones-para-la-discusion-en-chile/",
             "https://www.cepchile.cl/investigacion/actitudes-y-sensibilidades-politicas-en-la-actual-centro-derecha-chilena-capitulo-de-libro/",
             "https://www.cepchile.cl/investigacion/evopoli-la-construccion-de-una-nueva-centro-derecha-en-chile-capitulo-de-libro/",
             "https://www.cepchile.cl/investigacion/cuan-similares-son-las-actitudes-de-los-hombres-y-las-mujeres-dirigentes-brechas-de-genero-y-moderacion-en-la-centro-derecha-chilena/",
             "https://www.cepchile.cl/investigacion/la-batalla-por-las-ideas-en-tiempos-post-ideologicos-adaptaciones-y-permanencias-ideologicas-en-la-nueva-centro-derecha-chilena/",
             "https://www.cepchile.cl/investigacion/terremotos-democracia-y-dictadura-en-chile-en-el-siglo-20-el-funcionamiento-del-orden-publico-y-del-orden-social-en-eventos-catastroficos/",
             "https://www.cepchile.cl/investigacion/transicion-inducida-por-migraciones-en-estructuras-sociales-una-vision-desde-el-modelo-de-interacciones-sociales-de-sakoda/",
             "https://www.cepchile.cl/investigacion/una-crisis-de-marea-roja-vivida-por-twitter-en-la-isla-de-chiloe-chile-que-se-puede-obtener-para-la-investigacion-socio-ecologica-a-traves-del-analisis-de-social-media/",
             "https://www.cepchile.cl/investigacion/lineamientos-para-una-sociologia-evolutiva-de-la-diferenciacion-funcional-en-america-latina/",
             "https://www.cepchile.cl/investigacion/gobernando-la-sustentabilidad-o-gobernanza-sustentable-constelaciones-semanticas-sobre-la-interseccion-sustentabilidad-gobernanza-en-la-literatura-academica/",
             "https://www.cepchile.cl/investigacion/analisis-de-sentimiento-de-datos-de-twitter-durante-eventos-criticos-por-medio-de-clasificadores-de-red-bayesianos/",
             "https://www.cepchile.cl/investigacion/de-la-inmunidad-a-la-autoinmunidad-la-disolucion-del-orden-social/",
             "https://www.cepchile.cl/investigacion/para-una-politica-reflexiva-de-inmigracion-en-chile-una-aproximacion-sociologica-capitulo-de-libro/",
             "https://www.cepchile.cl/investigacion/pedro-morande-del-barroco-a-los-sistemas-sociales/",
             "https://www.cepchile.cl/investigacion/etica-de-la-contingencia-para-mundos-incompletos/",
             "https://www.cepchile.cl/investigacion/la-crisis-como-control-de-hipertrofia/",
             "https://www.cepchile.cl/investigacion/la-constitucion-de-1925-crisis-y-legitimacion-en-perspectiva-constitucional-capitulo-de-libro/",
             "https://www.cepchile.cl/investigacion/crisis-y-critica-sobre-los-fragiles-fundamentos-de-la-vida-social-por-rodrigo-cordero-resena/",
             "https://www.cepchile.cl/investigacion/eleccion-de-colegio-en-un-entorno-de-mercado-expectativas-individuales-versus-sociales/",
             "https://www.cepchile.cl/investigacion/controversias-en-sistemas-socioecologicos-lecciones-de-una-crisis-de-marea-roja-mayor-en-la-isla-de-chiloe-chile/",
             "https://www.cepchile.cl/investigacion/manejando-la-crisis-educacional-chilena-de-1920-una-vision-historica-combinada-con-aprendizaje-automatico/",
             "https://www.cepchile.cl/investigacion/crisis-constituyentes-el-poder-de-la-contingencia/",
             "https://www.cepchile.cl/investigacion/esse-sequitur-operari-o-el-nuevo-giro-de-la-teoria-sociologica-contemporanea-bourdieu-archer-luhmann/",
             "https://www.cepchile.cl/investigacion/sobre-la-reflexividad-de-las-crisis-lecciones-desde-la-teoria-critica-y-la-teoria-de-sistemas/",
             "https://www.cepchile.cl/investigacion/deconstitucionalizando-a-america-latina-capitulo-de-libro/",
             "https://www.cepchile.cl/investigacion/la-emergencia-de-redes-clientelares-en-america-latina-una-perspectiva-teorica/",
             "https://www.cepchile.cl/investigacion/constitucionalismo-en-el-contexto-global-por-poul-f-kjaer-resena/",
             "https://www.cepchile.cl/investigacion/redes-informales-e-instituciones-democraticas-en-america-latina/",
             "https://www.cepchile.cl/investigacion/la-incompletitud-de-la-autopoiesis-irritacion-codificacion-y-crisis/",
             "https://www.cepchile.cl/investigacion/jorge-larrain-o-la-pasion-por-la-distincion-conceptual/",
             "https://www.cepchile.cl/investigacion/crisis-en-sistemas-sociales-complejos-una-mirada-desde-la-teoria-social-ilustrada-con-el-caso-chileno/",
             "https://www.cepchile.cl/investigacion/la-relevancia-de-la-propiedad-y-la-autodireccion-self-command-en-la-teoria-de-los-sentimientos-morales-de-adam-smith/",
             "https://www.cepchile.cl/investigacion/adam-smith-lo-que-pensaba-y-por-que-importa-resena/",
             "https://www.cepchile.cl/investigacion/milton-friedman-en-chile-terapia-de-shock-libertad-economica-y-tasas-de-cambio/",
             "https://www.cepchile.cl/investigacion/la-idea-fundacional-de-la-persuasion-simpatetica-de-adam-smith/",
             "https://www.cepchile.cl/investigacion/adam-smith-en-contexto-una-revaluacion-critica-de-algunos-aspectos-centrales-de-su-pensamiento-libro/",
             "https://www.cepchile.cl/investigacion/milton-friedman-y-sus-visitas-a-chile/",
             "https://www.cepchile.cl/investigacion/friedrich-hayek-y-sus-visitas-a-chile/",
             "https://www.cepchile.cl/investigacion/la-idea-de-la-sociedad-comercial-en-la-ilustracion-escocesa-resena/",
             "https://www.cepchile.cl/investigacion/friedrich-hayek-y-sus-visitas-a-chile-2/",
             "https://www.cepchile.cl/investigacion/directores-dictadores-y-protectores-las-formas-de-la-politica-revolucionaria-en-el-cono-sur-1810-1824/",
             "https://www.cepchile.cl/investigacion/terremotos-democracia-y-dictadura-en-chile-en-el-siglo-20-el-funcionamiento-del-orden-publico-y-del-orden-social-en-eventos-catastroficos/",
             "https://www.cepchile.cl/investigacion/del-rechazo-al-reconocimiento-y-la-disputa-cuatro-momentos-en-los-origenes-de-la-democracia-representativa-chilena-1822-1851/",
             "https://www.cepchile.cl/investigacion/chile-constitucional-libro/",
             "https://www.cepchile.cl/investigacion/economia-politica-en-el-tribunal-del-consulado-de-santiago-de-chile-el-caso-de-manuel-de-salas-1795-1810/",
             "https://www.cepchile.cl/investigacion/indios-seducidos-participacion-politico-militar-de-los-mapuche-durante-la-restauracion-de-fernando-vii/",
             "https://www.cepchile.cl/investigacion/retomar-la-constitucion-de-1925-reflexiones-burkeanas-capitulo-de-libro/",
             "https://www.cepchile.cl/investigacion/miguel-eyzaguirre-las-redes-de-un-chileno-reformista-en-la-lima-del-virrey-abascal-1803-1816/",
             "https://www.cepchile.cl/investigacion/militancia-y-representacion-parlamentaria-en-chile-1840-1870-notas-para-un-estdio-prosografico-de-la-camara-de-diputados/",
             "https://www.cepchile.cl/investigacion/revolucion-y-construccion-republicana-1808-1851-capitulo-de-libro/",
             "https://www.cepchile.cl/investigacion/monopolio-de-nadie-el-liberalismo-chileno-en-el-periodo-posindependiente-1823-1830/",
             "https://www.cepchile.cl/investigacion/dos-actas-de-independencia-para-dos-estados-soberanos-chile-y-el-rio-de-la-plata-1816-1818/",
             "https://www.cepchile.cl/investigacion/la-reconstruccion-del-ejercito-de-chile-en-una-era-reformista-1762-1810/",
             "https://www.cepchile.cl/investigacion/el-gobierno-de-bernardo-ohiggins-mirado-a-traves-de-cinco-agentes-estadounidenses/",
             "https://www.cepchile.cl/investigacion/1814-en-chile-de-la-desobediencia-a-lima-al-quiebre-con-espana/",
             "https://www.cepchile.cl/investigacion/revolucionarios-rebeldes-y-contrarrevolucionarios-un-analisis-comparativo-entre-chile-y-el-cuzco-1812-1816/",
             "https://www.cepchile.cl/investigacion/monsters-in-law-una-lectura-de-ester-de-jean-racine/",
             "https://www.cepchile.cl/investigacion/aprovechamientos-de-andres-bello-una-estrategia-americana/",
             "https://www.cepchile.cl/investigacion/locuras-y-corduras-de-la-justicia-en-don-quijote/",
             "https://www.cepchile.cl/investigacion/canon-vs-cannon-la-desarmaduria-muller/",
             "https://www.cepchile.cl/investigacion/aleksievich-una-espia-resena/",
             "https://www.cepchile.cl/investigacion/eso-es-imposible-willow-el-fin-de-la-magia/",
             "https://www.cepchile.cl/investigacion/competir-por-la-plataforma-continental-los-derechos-legales-frente-a-los-geofisicos/",
             "https://www.cepchile.cl/investigacion/aspectos-economicos-de-la-constitucion-alternativas-y-propuestas-para-chile-libro/",
             "https://www.cepchile.cl/investigacion/iniciativa-presidencial-exclusiva-en-materia-de-gasto-publico-capitulo-de-libro/",
             "https://www.cepchile.cl/investigacion/la-propiedad-privada-capitulo-de-libro/"
             
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
  
  cat("Publicación Indexada", i, "Procesada\n")
}

datos_completos <- do.call(rbind, resultados)

print(datos_completos)

write.xlsx(datos_completos, "CEP Publicaciónes Indexadas.xlsx")
