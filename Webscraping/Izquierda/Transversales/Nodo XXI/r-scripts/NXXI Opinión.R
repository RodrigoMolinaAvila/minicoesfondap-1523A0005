# ---*** R10 CODES ***--- N°62

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

enlaces <- c(
  "https://www.nodoxxi.cl/noticias/2023/conmemoracion-50-anos-del-golpe-de-estado-hay-derecha-democratica/",
  "https://www.nodoxxi.cl/noticias/2023/presentacion-de-la-ipn-no-10-887/",
  "https://www.nodoxxi.cl/noticias/2023/declaracion-iniciativas-populares-ciudadanas/",
  "https://www.nodoxxi.cl/noticias/2023/modernizacion-del-estado-y-sistema-de-financiamiento-de-la-educacion-superior/",
  "https://www.nodoxxi.cl/estudios/2023/entrevista-a-felipe-ruiz-nuevas-formas-de-trabajo-las-nuevas-tecnologias-y-los-desafios-de-la-juventud-sindicalista-en-la-region/",
  "https://www.nodoxxi.cl/otros/2023/nunca-mas-a-50-anos-del-golpe-de-estado/",
  "https://www.nodoxxi.cl/noticias/2023/no-son-pendulo-son-oposicionistas/",
  "https://www.nodoxxi.cl/noticias/2023/reactivacion-educativa/",
  "https://www.nodoxxi.cl/noticias/2023/la-pelota-en-la-cancha-republicana/",
  "https://www.nodoxxi.cl/noticias/2023/abordar-la-deuda-educativa-ademas-de-ser-un-asunto-de-justicia-y-de-responsabilidad-del-estado-es-un-problema-de-sostenibilidad-del-sistema-de-educacion-superior/",
  "https://www.nodoxxi.cl/noticias/2023/cuenta-publica-2023-un-camino-para-salir-del-pais-de-las-deudas-el-dilema-de-la-oposicion/",
  "https://www.nodoxxi.cl/noticias/2023/pierina-ferretti-balance-y-desafios-de-fundacion-nodo-xxi-en-sus-10-anos/",
  "https://www.nodoxxi.cl/noticias/2023/depende-que-subsidiariedad/",
  "https://www.nodoxxi.cl/noticias/2023/columna-de-felipe-ruiz-la-reforma-de-pensiones-un-desafio-politico-urgente/",
  "https://www.nodoxxi.cl/noticias/2022/columna-de-pierina-ferretti-un-acuerdo-contra-las-cuerdas/",
  "https://www.nodoxxi.cl/noticias/prensa/2022/pierina-ferreti-directora-ejecutiva-de-nodo-xxi-en-la-revuelta-se-vivio-la-crisis-de-dd-hh-mas-grande-desde-la-dictadura/",
  "https://www.nodoxxi.cl/noticias/2022/camila-miranda-sobre-el-acuerdo-constituyente-que-rol-jugaria-un-organo-electo-cuando-hay-un-marco-tan-establecido/",
  "https://www.nodoxxi.cl/noticias/2022/camila-miranda-sobre-los-discursos-de-odio-generan-un-animo-de-intolerancia-que-en-los-hechos-deviene-en-violencia/",
  "https://www.nodoxxi.cl/noticias/2022/columna-de-pierina-ferretti-a-proposito-de-meloni-estamos-listos/",
  "https://www.nodoxxi.cl/noticias/2022/red-de-centros-aprobemosxchile-se-reunen-en-pro-campana-electoral/",
  "https://www.nodoxxi.cl/noticias/opinion/2022/las-duras-semanas-de-campana-previas-al-plebiscito-de-salida-como-construir-una-mirada-politica-propia-frente-a-las-encuestas-de-opinion/",
  "https://www.nodoxxi.cl/noticias/2022/miradas-sobre-la-politica-del-gobierno-hacia-el-wallmapu/",
  "https://www.nodoxxi.cl/noticias/2022/un-espacio-de-encuentro-y-debate/",
  "https://www.nodoxxi.cl/noticias/prensa/2022/la-sostenibilidad-de-la-vida-como-fundamento-de-la-nueva-constitucion/",
  "https://www.nodoxxi.cl/noticias/entrevistas/2022/victor-orellana-sociologo-de-nodo-xxi-el-frente-amplio-tiene-el-desafio-de-saber-hacer-la-sintesis-entre-actores-sociales-y-accion-institucional/",
  "https://www.nodoxxi.cl/noticias/opinion/2022/elecciones-en-la-convencion-seguir-construyendo-un-nuevo-chile/",
  "https://www.nodoxxi.cl/noticias/prensa/2021/investigadoras-proponen-instaurar-el-derecho-a-los-cuidados-al-centro-de-la-nueva-constitucion/",
  "https://www.nodoxxi.cl/noticias/prensa/2021/daniela-lopez-leiva-socia-del-estudio-juridico-aml-defensa-de-mujeres-especializada-en-litigio-estrategico-en-familia-genero-infancia-y-adolescencia/",
  "https://www.nodoxxi.cl/noticias/prensa/2021/investigadora-pierina-ferretti-sobre-el-aborto-en-chile-sin-movilizaciones-sin-movimiento-feminista-no-existiria-este-debate/",
  "https://www.nodoxxi.cl/noticias/2021/camila-miranda-en-el-primer-cafe-de-radio-cooperativa-con-la-convencion-constitucional-estamos-en-un-proceso-de-construccion/",
  "https://www.nodoxxi.cl/noticias/2021/la-fundacion-nodo-xxi-ante-el-nuevo-escenario-politico/",
  "https://www.nodoxxi.cl/noticias/2021/el-dilema-presidencial-en-tiempo-de-crisis-de-la-oposicion-partidaria-a-una-alianza-popular/",
  "https://www.nodoxxi.cl/noticias/opinion/2021/propuesta-para-el-financiamiento-de-un-ingreso-basico-de-emergencia-para-chile-2/",
  "https://www.nodoxxi.cl/noticias/2021/carlos-ruiz-y-manifiesto-ampliar-la-democracia-entendemos-el-proceso-constituyente-como-la-apertura-de-un-camino/",
  "https://www.nodoxxi.cl/noticias/2021/mas-alla-del-tercer-retiro-las-pensiones-y-el-derecho-a-la-vida-digna/",
  "https://www.nodoxxi.cl/noticias/2021/ampliar-la-democracia-mas-poder-al-pueblo-en-la-nueva-constitucion/",
  "https://www.nodoxxi.cl/noticias/2021/carlos-ruiz-comunes-hay-que-apostar-a-una-redistribucion-del-poder-en-la-sociedad/",
  "https://www.nodoxxi.cl/noticias/2021/carta-victor-orellana/",
  "https://www.nodoxxi.cl/noticias/2021/diversos-actores-redactan-los-principios-constituyentes-para-refundar-el-estado/",
  "https://www.nodoxxi.cl/noticias/2021/debate-constituyente-lo-principal-es-frenar-el-poder-del-1-mas-rico-frenar-el-poder-de-los-grupos-economicos/",
  "https://www.nodoxxi.cl/noticias/2021/constitucion-y-economia-no-dejar-escrito-lo-minimo-sino-lo-necesario/",
  "https://www.nodoxxi.cl/noticias/2020/victor-orellana-el-candidato-comprometido-por-la-educacion-para-la-convencion-constitucional/",
  "https://www.nodoxxi.cl/noticias/2020/carta-abierta-a-carlos-ruiz-te-instamos-a-que-aceptes-una-candidatura-en-las-listas-de-izquierda/",
  "https://www.nodoxxi.cl/noticias/2020/de-los-derechos-sociales-a-la-republica-de-la-dignidad/",
  "https://www.nodoxxi.cl/noticias/2020/los-cuidados-principio-y-derecho-en-una-nueva-constitucion/",
  "https://www.nodoxxi.cl/noticias/2020/organizaciones-sociales-analizan-estrategias-constitucionales-de-cara-al-plebiscito-del-domingo/",
  "https://www.nodoxxi.cl/noticias/2020/octubre-paz-o-violencia/",
  "https://www.nodoxxi.cl/noticias/2020/la-construccion-de-una-nueva-constitucion-debe-incorporar-al-movimiento-social/",
  "https://www.nodoxxi.cl/noticias/2020/tras-la-pandemia-y-el-desempeno-laboral-es-urgente-la-creacion-de-un-sistema-nacional-de-cuidados-en-chile/",
  "https://www.nodoxxi.cl/noticias/2020/entra-en-vigencia-chao-dicom-la-ley-que-prohibe-informar-en-el-boletin-comercial-todas-las-deudas-por-estudios/",
  "https://www.nodoxxi.cl/noticias/2020/columna-de-carlos-ruiz-edwards-la-banalidad-de-la-banalidad/",
  "https://www.nodoxxi.cl/noticias/opinion/2020/limitaciones-politicas-luchas-sociales-y-alcances-del-proceso-constituyente/",
  "https://www.nodoxxi.cl/noticias/2020/jorge-arrate-y-carlos-ruiz-ante-las-intenciones-de-unidad-opositora/",
  "https://www.nodoxxi.cl/noticias/opinion/2020/el-plebiscito-es-otra-obra/",
  "https://www.nodoxxi.cl/noticias/2020/el-costo-de-la-pandemia-en-su-mayor-medida-la-cargan-los-trabajadores-y-trabajadoras-del-sector-publico/",
  "https://www.nodoxxi.cl/noticias/opinion/2020/lagos-el-cae-y-los-mitos-lecciones-para-el-futuro/",
  "https://www.nodoxxi.cl/noticias/2020/miradas-politico-sociales-sobre-los-cuidados-el-cuidado-es-un-derecho/",
  "https://www.nodoxxi.cl/noticias/2020/una-nueva-constitucion-es-mas-que-desarmar-cerrojos/",
  "https://www.nodoxxi.cl/noticias/2020/trabajadoras-de-casa-particular-y-por-cuenta-propia-son-quienes-mas-salen-en-transporte-publico-en-cuarentena/",
  "https://www.nodoxxi.cl/noticias/2020/el-proceso-constituyente-ya-empezo/",
  "https://www.nodoxxi.cl/noticias/2020/crisis-de-los-cuidados-miradas-politico-sociales-de-la-region/",
  "https://www.nodoxxi.cl/noticias/2020/la-dignidad-es-inconstitucional/",
  "https://www.nodoxxi.cl/noticias/2020/cristina-carrasco-el-cuidado-es-un-derecho-y-debe-ser-de-los-derechos-mas-basicos/",
  "https://www.nodoxxi.cl/noticias/opinion/2020/ni-biombos-ni-patriarcado-en-las-aulas-reflexiones-sobre-la-educacion-de-las-mujeres-en-chile/",
  "https://www.nodoxxi.cl/noticias/2020/crisis-de-los-cuidados-en-el-acceso-a-la-justicia/",
  "https://www.nodoxxi.cl/noticias/2020/y-el-estado/",
  "https://www.nodoxxi.cl/noticias/2020/crisis-educativa-y-pandemia-pongamos-la-vida-en-el-centro/",
  "https://www.nodoxxi.cl/noticias/2020/carlos-ruiz-y-crisis-sanitaria-tenemos-una-especie-de-estado-amputado/",
  "https://www.nodoxxi.cl/noticias/2020/crisis-de-los-cuidados-como-la-enfrentamos/",
  "https://www.nodoxxi.cl/noticias/2020/carlos-ruiz-en-revista-plebeya/",
  "https://www.nodoxxi.cl/noticias/entrevistas/2020/espacio-de-coyuntura-desafios-ante-la-crisis-social/",
  "https://www.nodoxxi.cl/noticias/entrevistas/2020/crisis-de-los-cuidados-las-mujeres-en-la-primera-linea/",
  "https://www.nodoxxi.cl/noticias/prensa/2020/reflexiones-en-tiempos-de-pandemia-analisis-de-coyuntura-n-o-2-fundacion-nodo-xxi-mayo-2020/",
  "https://www.nodoxxi.cl/noticias/entrevistas/2020/carlos-ruiz-en-radio-usach-se-acabo-la-politica-sin-sociedad/",
  "https://www.nodoxxi.cl/noticias/entrevistas/2020/victor-orellana-director-de-nodo-xxi-no-se-puede-descartar-un-cencosud-academico-en-el-rescate-de-a-los-negocios-privados-en-educacion/",
  "https://www.nodoxxi.cl/noticias/2020/reflexiones-en-tiempos-de-pandemia-analisis-de-coyuntura-n1-fundacion-nodo-xxi/",
  "https://www.nodoxxi.cl/noticias/opinion/2020/defender-el-trabajo-es-salvar-vidas/",
  "https://www.nodoxxi.cl/noticias/prensa/2020/adelanto-los-que-despertaron-a-chile-como-octubre-cambio-la-vision-respecto-a-los-jovenes/",
  "https://www.nodoxxi.cl/noticias/entrevistas/2020/4742/",
  "https://www.nodoxxi.cl/noticias/opinion/2020/es-contradictoria-la-lucha-por-la-vida-con-los-horizontes-de-cambios/",
  "https://www.nodoxxi.cl/noticias/entrevistas/2020/pandemia-y-crisis-social-tras-el-estallido-del-octubre-chileno/",
  "https://www.nodoxxi.cl/noticias/entrevistas/2020/el-nuevo-pueblo-volvera-a-plaza-dignidad/",
  "https://www.nodoxxi.cl/noticias/prensa/2020/la-protesta-se-resiste-a-morir/",
  "https://www.nodoxxi.cl/noticias/prensa/2020/the-clinic-lanza-reflexiones-en-pandemia-y-participa-carlos-ruiz-presidente-de-nodo-xxi/",
  "https://www.nodoxxi.cl/noticias/opinion/2020/en-crisis-sanitaria-una-educacion-al-servicio-de-la-vida/",
  "https://www.nodoxxi.cl/noticias/entrevistas/2020/la-crisis-sanitaria-aumentara-la-desigualdad-y-asi-el-malestar/",
  "https://www.nodoxxi.cl/noticias/opinion/2020/educacion-y-pandemia-tiempo-de-preguntas/",
  "https://www.nodoxxi.cl/noticias/prensa/2020/propuesta-para-el-financiamiento-de-un-ingreso-basico-de-emergencia-para-chile/",
  "https://www.nodoxxi.cl/noticias/prensa/2020/dialogar-con-la-derecha-en-medio-de-esta-crisis-como-el-virus-le-cambio-la-cancha-al-frente-amplio/",
  "https://www.nodoxxi.cl/noticias/prensa/2020/clases-a-distancia-debilidades-e-inequidades-del-sistema-aplicado-a-basica-y-media-para-sortear-la-pandemia/",
  "https://www.nodoxxi.cl/noticias/opinion/2020/violencia-economica-en-tiempos-de-pandemia/",
  "https://www.nodoxxi.cl/noticias/entrevistas/2020/en-chile-el-coronavirus-saca-a-la-luz-las-desigualdades-denunciadas-por-el-movimiento-social-publica-le-monde-francia/",
  "https://www.nodoxxi.cl/noticias/opinion/2020/carta-red-de-investigadoras-e-investigadores-del-trabajo-de-chile-sobre-covid-19-y-politicas-laborales/",
  "https://www.nodoxxi.cl/noticias/entrevistas/2020/pensando-en-politica-entrevista-a-carlos-ruiz-encina/",
  "https://www.nodoxxi.cl/noticias/entrevistas/2020/carlos-ruiz-sociologo-la-plaza-se-va-a-volver-a-llenar-de-dignidad-apenas-salgamos-de-la-cuarentena/",
  "https://www.nodoxxi.cl/noticias/entrevistas/2020/carlos-ruiz-y-el-estallido-de-octubre-tiene-que-ver-con-los-grados-de-incertidumbre-que-vive-la-gente/",
  "https://www.nodoxxi.cl/noticias/opinion/2020/la-crisis-de-los-cuidados-y-el-silencio-del-gobierno/",
  "https://www.nodoxxi.cl/noticias/prensa/2020/carlos-ruiz-y-la-irrupcion-de-un-nuevo-pueblo-en-el-octubre-chileno/",
  "https://www.nodoxxi.cl/noticias/opinion/2020/teletrabajo-riesgos-inadvertidos/",
  "https://www.nodoxxi.cl/noticias/entrevistas/2020/chile-reclamo-social-en-tiempos-de-coronavirus/",
  "https://www.nodoxxi.cl/noticias/entrevistas/2020/giorgio-boccardo-cuando-la-vida-esta-en-juego-nuestro-diseno-politico-institucional-no-da-abasto/",
  "https://www.nodoxxi.cl/noticias/2020/mesa-de-coyuntura-senala-tareas-para-la-izquierda-frente-al-proceso-constituyente/",
  "https://www.nodoxxi.cl/noticias/2019/nodo-xxi-deuda-educativa-y-fech-presentan-hoja-de-ruta-para-condonar-deudas-educativas/",
  "https://www.nodoxxi.cl/noticias/2019/nodo-xxi-presenta-propuesta-de-condonacion-de-deudas-por-estudiar/",
  "https://www.nodoxxi.cl/noticias/2019/mesa-de-coyuntura-de-nodo-xxi-analiza-el-caracter-y-usos-politicos-de-la-violencia-en-el-conflicto-nacional/",
  "https://www.nodoxxi.cl/noticias/2019/mesa-de-coyuntura-de-nodo-xxi-evalua-el-acuerdo-por-una-nueva-constitucion/",
  "https://www.nodoxxi.cl/noticias/2019/mesa-de-actores-sociales-politicos-e-intelectuales-senala-necesidad-de-combinar-avances-concretos-con-reformas-estructurales/",
  "https://www.nodoxxi.cl/noticias/2019/dirigentes-sociales-politicos-e-intelectuales-identifican-tres-ejes-para-dar-una-salida-politica-a-la-coyuntura/",
  "https://www.nodoxxi.cl/noticias/2019/un-nuevo-pueblo-nace-en-chile/",
  "https://www.nodoxxi.cl/noticias/2019/la-crisis-no-se-resuelve-con-un-arreglo-entre-cupulas/",
  "https://www.nodoxxi.cl/noticias/2019/agenda-corta-de-fin-a-los-abusos-por-estudiar-y-condonacion-total-de-la-deuda/",
  "https://www.nodoxxi.cl/noticias/2019/3262/",
  "https://www.nodoxxi.cl/noticias/actividades/2019/carlos-ruiz-aborda-desafios-laborales-en-foro-del-cep/",
  "https://www.nodoxxi.cl/noticias/2019/nodo-xxi-y-colegios-de-profesores-se-reunen-para-abordar-la-discusion-educativa/",
  "https://www.nodoxxi.cl/noticias/2019/primer-documento-espacio-de-coyuntura-nuevo-ciclo-de-la-politica-chilena/",
  "https://www.nodoxxi.cl/noticias/actividades/2019/nodo-xxi-lanza-escuela-de-formacion-feminista/",
  "https://www.nodoxxi.cl/noticias/actividades/2019/nodo-xxi-prepara-primer-documento-de-su-mesa-espacio-de-coyuntura/",
  "https://www.nodoxxi.cl/otros/2018/carlos-ruiz-la-izquierda-corre-el-riesgo-de-pavimentarle-el-camino-a-la-ultraderecha/",
  "https://www.nodoxxi.cl/noticias/opinion/2018/dilemas-de-la-consolidacion-del-frente-amplio/",
  "https://www.nodoxxi.cl/noticias/2018/nodo-xxi-lanza-infografia-con-perspectiva-critica-sobre-la-agenda-mujer-propuesta-por-el-gobierno-de-sebastian-pinera/",
  "https://www.nodoxxi.cl/cuadernos-de-coyuntura/cuadernos-de-coyuntura-archivo/2018/suscribete-a-la-revista-cuadernos-de-coyuntura/",
  "https://www.nodoxxi.cl/cuadernos-de-coyuntura/cuadernos-de-coyuntura-archivo/2018/editorial-20-la-emergencia-politica-pendiente/",
  "https://www.nodoxxi.cl/cuadernos-de-coyuntura/cuadernos-de-coyuntura-archivo/2018/entrevista-a-antonio-negri-hoy-autonomia-significa-buscar-lo-comun/",
  "https://www.nodoxxi.cl/noticias/2018/se-realiza-la-primera-version-del-encuentro-dialogos-feministas-de-la-fundacion-nodo-xxi/",
  "https://www.nodoxxi.cl/noticias/opinion/2018/la-improvisacion-de-ultimo-momento-en-derechos-humanos-de-la-nueva-mayoria/",
  "https://www.nodoxxi.cl/noticias/2018/nodo-xxi-realiza-un-balance-critico-de-las-politicas-de-genero-del-gobierno-de-bachelet-de-cara-al-8m/",
  "https://www.nodoxxi.cl/noticias/2017/luis-thielemann-historiador-aquello-que-necesita-vitalmente-oponerse-a-pinera-son-las-clases-populares-y-sus-luchas-no-la-concertacion-y-sus-partidos/",
  "https://www.nodoxxi.cl/noticias/2017/carlos-ruiz-encina-el-frente-amplio-no-va-a-ir-a-ninguna-parte-con-complejos-edipicos-respecto-de-la-concertacion-el-mercurio-24-de-diciembre-2017-2/"
  
)

datos_lista <- map_df(enlaces, scrape_url)

datos_filtrados <- datos_lista %>%
  filter_all(all_vars(. != "N/A"))

ruta_archivo <- "NXXI Opinión.xlsx"
write.xlsx(datos_filtrados, ruta_archivo, rowNames = FALSE)

cat("Web scraping para la lista de enlaces completado y datos filtrados guardados en", ruta_archivo, "\n")
