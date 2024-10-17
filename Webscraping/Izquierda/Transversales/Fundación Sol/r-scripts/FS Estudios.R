# ---*** R10 CODES ***--- N°52

library(rvest)
library(tidyverse)
library(openxlsx)

enlaces <- c("https://fundacionsol.cl/blog/estudios-2/post/imce-abril-junio-2023-7378",
             "https://fundacionsol.cl/blog/estudios-2/post/imce-marzo-mayo-2023-7372",
             "https://fundacionsol.cl/blog/estudios-2/post/imce-febrero-abril-2023-7362",
             "https://fundacionsol.cl/blog/estudios-2/post/pensiones-por-la-fuerza-2023-7338",
             "https://fundacionsol.cl/blog/estudios-2/post/reajuste-del-salario-minimo-2023-7334",
             "https://fundacionsol.cl/blog/estudios-2/post/endeudar-para-gobernar-y-mercantilizar-el-caso-del-cae-2023-7333",
             "https://fundacionsol.cl/blog/estudios-2/post/imce-enero-marzo-2023-7322",
             "https://fundacionsol.cl/blog/estudios-2/post/quien-es-quien-en-el-negocio-de-las-afp-y-companias-de-seguros-7299",
             "https://fundacionsol.cl/blog/estudios-2/post/imce-diciembre-febrero-2023-7251",
             "https://fundacionsol.cl/blog/estudios-2/post/imce-noviembre-enero-2022-6908",
             "https://fundacionsol.cl/blog/estudios-2/post/marginalizacion-y-fragmentacion-de-la-negociacion-colectiva-su-impacto-en-la-desigualdad-de-ingresos-6903",
             "https://fundacionsol.cl/blog/estudios-2/post/imce-octubre-diciembre-2022-6898",
             "https://fundacionsol.cl/blog/estudios-2/post/el-trabajo-desde-la-resistencia-y-la-rebeldia-6895",
             "https://fundacionsol.cl/blog/estudios-2/post/imce-septiembre-noviembre-2022-6884",
             "https://fundacionsol.cl/blog/estudios-2/post/imce-agosto-octubre-2022-6878",
             "https://fundacionsol.cl/blog/estudios-2/post/imce-julio-septiembre-2022-6863",
             "https://fundacionsol.cl/blog/estudios-2/post/tiempo-robado-pobreza-de-tiempo-productividad-y-acumulacion-capitalista-6859",
             "https://fundacionsol.cl/blog/estudios-2/post/tlcs-y-otras-sombras-del-modelo-chileno-7243",
             "https://fundacionsol.cl/blog/estudios-2/post/imce-junio-agosto-2022-6858",
             "https://fundacionsol.cl/blog/estudios-2/post/imce-mayo-julio-2022-6856",
             "https://fundacionsol.cl/blog/estudios-2/post/los-verdaderos-sueldos-de-chile-2022-6851",
             "https://fundacionsol.cl/blog/estudios-2/post/imce-abril-junio-2022-6850",
             "https://fundacionsol.cl/blog/estudios-2/post/imce-marzo-mayo-2022-6848",
             "https://fundacionsol.cl/blog/estudios-2/post/anillos-de-insercion-laboral-desde-el-centro-hasta-la-periferia-de-los-mundos-del-trabajo-en-chile-7336",
             "https://fundacionsol.cl/blog/estudios-2/post/trabajo-en-domicilio-pandemia-y-transformaciones-en-el-trabajo-textil-y-la-cadena-del-vestuario-en-chile-6845",
             "https://fundacionsol.cl/blog/estudios-2/post/reajuste-del-salario-minimo-2022-6838",
             "https://fundacionsol.cl/blog/estudios-2/post/inversiones-de-china-en-el-cono-sur-de-america-latina-6828",
             "https://fundacionsol.cl/blog/estudios-2/post/chile-30-anos-de-tratados-de-libre-comercio-6821",
             "https://fundacionsol.cl/blog/estudios-2/post/inversiones-electorales-grandes-grupos-economicos-y-elecciones-presidenciales-2021-6813",
             "https://fundacionsol.cl/blog/estudios-2/post/precarising-formality-understanding-current-labour-developments-in-chile-7337",
             "https://fundacionsol.cl/blog/estudios-2/post/pensiones-por-la-fuerza-2021-6797",
             "https://fundacionsol.cl/blog/estudios-2/post/los-verdaderos-sueldos-de-chile-2021-6796",
             "https://fundacionsol.cl/blog/estudios-2/post/la-pobreza-del-modelo-chileno-2021-6791",
             "https://fundacionsol.cl/blog/estudios-2/post/pensiones-sin-seguridad-social-como-se-calcula-el-monto-de-las-pensiones-en-chile-2021-6784",
             "https://fundacionsol.cl/blog/estudios-2/post/penalizacion-salarial-y-de-tiempo-para-madres-trabajadoras-6780",
             "https://fundacionsol.cl/blog/estudios-2/post/grandes-grupos-economicos-y-financiamiento-electoral-primarias-presidenciales-2021-6777",
             "https://fundacionsol.cl/blog/estudios-2/post/endeudar-para-gobernar-y-mercantilizar-el-caso-del-cae-2021-6773",
             "https://fundacionsol.cl/blog/estudios-2/post/pensiones-bajo-el-minimo-resultados-del-sistema-de-cuentas-individuales-de-las-afp-datos-actualizados-2020-6770",
             "https://fundacionsol.cl/blog/estudios-2/post/reajuste-del-salario-minimo-6756",
             "https://fundacionsol.cl/blog/estudios-2/post/grandes-grupos-economicos-y-financiamiento-electoral-6755",
             "https://fundacionsol.cl/blog/estudios-2/post/renta-basica-de-emergencia-rbe-6751",
             "https://fundacionsol.cl/blog/estudios-2/post/pobreza-de-tiempo-y-desigualdad-la-reproduccion-del-capital-desde-una-perspectiva-feminista-6744",
             "https://fundacionsol.cl/blog/estudios-2/post/afp-investments-in-extractive-companies-with-a-high-enviromental-impact-6737",
             "https://fundacionsol.cl/blog/estudios-2/post/los-verdaderos-sueldos-de-chile-2020-6700",
             "https://fundacionsol.cl/blog/estudios-2/post/inversiones-de-las-afp-en-empresas-extractivas-y-de-alto-impacto-ambiental-6684",
             "https://fundacionsol.cl/blog/estudios-2/post/nuevo-sistema-de-pensiones-para-chile-6649",
             "https://fundacionsol.cl/blog/estudios-2/post/salario-minimo-en-perspectiva-comparada-6648",
             "https://fundacionsol.cl/blog/estudios-2/post/quienes-ganan-el-salario-minimo-en-chile-6647",
             "https://fundacionsol.cl/blog/estudios-2/post/retiro-del-10-de-los-fondos-de-afp-cual-es-el-verdadero-impacto-en-las-pensiones-6137",
             "https://fundacionsol.cl/blog/estudios-2/post/emprendimiento-y-subsistencia-radiografia-a-los-microemprendimientos-en-chile-6145",
             "https://fundacionsol.cl/blog/estudios-2/post/reformas-en-tiempos-de-crisis-analisis-critico-de-la-agenda-laboral-del-gobierno-2020-6173",
             "https://fundacionsol.cl/blog/estudios-2/post/pensiones-por-la-fuerza-resultados-del-sistema-de-pensiones-de-las-fuerzas-armadas-y-de-orden-2020-6167",
             "https://fundacionsol.cl/blog/estudios-2/post/pensiones-bajo-el-minimo-2020-6161",
             "https://fundacionsol.cl/blog/estudios-2/post/one-life-over-another-english-version-2020-6168",
             "https://fundacionsol.cl/blog/estudios-2/post/unas-vidas-sobre-otras-2020-6132",
             "https://fundacionsol.cl/blog/estudios-2/post/endeudar-para-gobernar-y-mercantilizar-el-caso-del-cae-2020-6128",
             "https://fundacionsol.cl/blog/estudios-2/post/pensiones-sin-seguridad-social-2020-6191",
             "https://fundacionsol.cl/blog/estudios-2/post/afp-para-quien-2020-6130",
             "https://fundacionsol.cl/blog/estudios-2/post/no-es-amor-es-trabajo-no-pagado-2020-6177",
             "https://fundacionsol.cl/blog/estudios-2/post/derribando-mitos-sobre-los-sistemas-de-reparto-fondos-de-pensiones-para-la-seguridad-social-o-los-mercados-financieros-2020-6115",
             "https://fundacionsol.cl/blog/estudios-2/post/pensiones-por-la-fuerza-2019-6133",
             "https://fundacionsol.cl/blog/estudios-2/post/los-verdaderos-sueldos-de-chile-esi-2018-6140",
             "https://fundacionsol.cl/blog/estudios-2/post/pensiones-bajo-el-minimo-6124",
             "https://fundacionsol.cl/blog/estudios-2/post/endeudar-para-gobernar-y-mercantilizar-el-caso-del-cae-2019-6160",
             "https://fundacionsol.cl/blog/estudios-2/post/afp-para-quien-donde-se-invierten-los-fondos-de-pensiones-en-chile-6147",
             "https://fundacionsol.cl/blog/estudios-2/post/los-bajos-salarios-de-chile-2019-6158",
             "https://fundacionsol.cl/blog/estudios-2/post/analisis-critico-de-la-propuesta-de-pensiones-del-gobierno-de-sebastian-pinera-2019-6174",
             "https://fundacionsol.cl/blog/estudios-2/post/deuda-educativa-y-desposesion-de-estudiantes-con-credito-a-trabajadores-endeudados-7339",
             "https://fundacionsol.cl/blog/estudios-2/post/la-pobreza-del-modelo-chileno-la-insuficiencia-de-los-ingresos-del-trabajo-y-pensiones-6127",
             "https://fundacionsol.cl/blog/estudios-2/post/los-verdaderos-sueldos-de-chile-esi-2017-6188",
             "https://fundacionsol.cl/blog/estudios-2/post/mini-salario-minimo-6123",
             "https://fundacionsol.cl/blog/estudios-2/post/imce-febrero-abril-2018-6157",
             "https://fundacionsol.cl/blog/estudios-2/post/cae-2018-endeudar-para-gobernar-y-mercantilizar-6186",
             "https://fundacionsol.cl/blog/estudios-2/post/imce-enero-marzo-2018-6138",
             "https://fundacionsol.cl/blog/estudios-2/post/imce-diciembre-febrero-2018-6129",
             "https://fundacionsol.cl/blog/estudios-2/post/imce-noviembre-enero-2017-6105",
             "https://fundacionsol.cl/blog/estudios-2/post/imce-octubre-diciembre-2017-6126",
             "https://fundacionsol.cl/blog/estudios-2/post/imce-septiembre-noviembre-2017-6099",
             "https://fundacionsol.cl/blog/estudios-2/post/imce-agosto-octubre-2017-6169",
             "https://fundacionsol.cl/blog/estudios-2/post/elecciones-presidenciales-y-parlamentarias-en-chile-6164",
             "https://fundacionsol.cl/blog/estudios-2/post/empleo-publico-en-chile-trabajo-decente-en-el-estado-apuntes-para-el-debate-6125",
             "https://fundacionsol.cl/blog/estudios-2/post/imce-julio-septiembre-2017-6151",
             "https://fundacionsol.cl/blog/estudios-2/post/estudio-del-trabajo-en-domicilio-en-la-cadena-del-vestuario-en-chile-resumen-6196",
             "https://fundacionsol.cl/blog/estudios-2/post/estudio-del-trabajo-en-domicilio-en-la-cadena-del-vestuario-en-chile-estudio-completo-6172",
             "https://fundacionsol.cl/blog/estudios-2/post/informe-mensual-de-calidad-de-empleo-imce-junio-agosto-2017-6154",
             "https://fundacionsol.cl/blog/estudios-2/post/los-verdaderos-sueldos-en-chile-panorama-actual-del-valor-del-trabajo-esi-2016-6179",
             "https://fundacionsol.cl/blog/estudios-2/post/pobreza-y-fragilidad-del-modelo-6107",
             "https://fundacionsol.cl/blog/estudios-2/post/informe-mensual-de-calidad-del-empleo-imce-abril-junio-2017-6185",
             "https://fundacionsol.cl/blog/estudios-2/post/informe-mensual-de-calidad-del-empleo-imce-marzo-mayo-2017-6101",
             "https://fundacionsol.cl/blog/estudios-2/post/informe-mensual-de-calidad-del-empleo-imce-febrero-abril-2017-6170",
             "https://fundacionsol.cl/blog/estudios-2/post/endeudar-para-gobernar-y-mercantilizar-el-caso-del-cae-2017-6102",
             "https://fundacionsol.cl/blog/estudios-2/post/informe-mensual-de-calidad-del-empleo-imce-enero-marzo-2017-6166",
             "https://fundacionsol.cl/blog/estudios-2/post/los-bajos-salarios-de-chile-6195",
             "https://fundacionsol.cl/blog/estudios-2/post/informe-mensual-de-calidad-del-empleo-imce-diciembre-2016-febrero-2017-6194",
             "https://fundacionsol.cl/blog/estudios-2/post/informe-mensual-de-calidad-del-empleo-imce-noviembre-2016-enero-2017-6171",
             "https://fundacionsol.cl/blog/estudios-2/post/informe-mensual-de-calidad-del-empleo-imce-octubre-diciembre-2016-6131",
             "https://fundacionsol.cl/blog/estudios-2/post/informe-mensual-de-calidad-del-empleo-imce-septiembre-noviembre-2016-6162",
             "https://fundacionsol.cl/blog/estudios-2/post/informe-mensual-de-calidad-del-empleo-imce-agosto-octubre-2016-6192",
             "https://fundacionsol.cl/blog/estudios-2/post/pensiones-seguridad-social-o-gran-negocio-6104",
             "https://fundacionsol.cl/blog/estudios-2/post/salarios-en-el-sector-publico-6142",
             "https://fundacionsol.cl/blog/estudios-2/post/informe-mensual-de-calidad-del-empleo-imce-julio-septiembre-2016-6156",
             "https://fundacionsol.cl/blog/estudios-2/post/los-verdaderos-sueldos-de-la-region-del-biobio-2016-6136",
             "https://fundacionsol.cl/blog/estudios-2/post/informe-mensual-de-calidad-del-empleo-imce-junio-agosto-2016-6100",
             "https://fundacionsol.cl/blog/estudios-2/post/los-verdaderos-sueldos-de-la-region-de-valparaiso-2016-6187",
             "https://fundacionsol.cl/blog/estudios-2/post/informe-mensual-de-calidad-del-empleo-imce-mayo-julio-2016-6149",
             "https://fundacionsol.cl/blog/estudios-2/post/los-verdaderos-sueldos-en-chile-panorama-actual-del-valor-del-trabajo-nesi2015-6159",
             "https://fundacionsol.cl/blog/estudios-2/post/informe-mensual-de-calidad-del-empleo-imce-abril-junio-2016-6163",
             "https://fundacionsol.cl/blog/estudios-2/post/informe-mensual-de-calidad-del-empleo-imce-marzo-mayo-2016-6139",
             "https://fundacionsol.cl/blog/estudios-2/post/informe-mensual-de-calidad-del-empleo-imce-febrero-abril-2016-6190",
             "https://fundacionsol.cl/blog/estudios-2/post/los-verdaderos-sueldos-de-la-region-del-biobio-6141",
             "https://fundacionsol.cl/blog/estudios-2/post/informe-mensual-de-calidad-del-empleo-imce-enero-marzo-2016-6153",
             "https://fundacionsol.cl/blog/estudios-2/post/condicionantes-de-la-autonomia-economica-de-las-mujeres-6193",
             "https://fundacionsol.cl/blog/estudios-2/post/sindicatos-pulverizados-panorama-actual-y-reflexiones-para-la-transformacion-6143",
             "https://fundacionsol.cl/blog/estudios-2/post/endeudar-para-gobernar-y-mercantilizar-el-caso-del-cae-6165",
             "https://fundacionsol.cl/blog/estudios-2/post/ser-justos-es-lo-primero-los-trabajadores-dominicanos-6178",
             "https://fundacionsol.cl/blog/estudios-2/post/informe-mensual-de-calidad-del-empleo-imce-diciembre-febrero-2016-6152",
             "https://fundacionsol.cl/blog/estudios-2/post/reforma-laboral-ampliando-coberturas-6146",
             "https://fundacionsol.cl/blog/estudios-2/post/informe-mensual-de-calidad-del-empleo-imce-noviembre-enero-2015-6134",
             "https://fundacionsol.cl/blog/estudios-2/post/informe-mensual-de-calidad-del-empleo-imce-octubre-diciembre-2015-6103",
             "https://fundacionsol.cl/blog/estudios-2/post/informe-mensual-de-calidad-del-empleo-imce-septiembre-noviembre-2015-6180",
             "https://fundacionsol.cl/blog/estudios-2/post/despojo-salarial-y-pueblos-originarios-panorama-actual-valor-trabajo-usando-casen2013-6098",
             "https://fundacionsol.cl/blog/estudios-2/post/informe-mensual-de-calidad-del-empleo-imce-agosto-octubre-2015-6135",
             "https://fundacionsol.cl/blog/estudios-2/post/los-verdaderos-sueldos-de-chile-panorama-actual-del-valor-del-trabajo-nesi2014-6181",
             "https://fundacionsol.cl/blog/estudios-2/post/informe-mensual-de-calidad-del-empleo-imce-julio-septiembre-2015-6182",
             "https://fundacionsol.cl/blog/estudios-2/post/informe-mensual-de-calidad-del-empleo-imce-junio-agosto-2015-6148",
             "https://fundacionsol.cl/blog/estudios-2/post/para-una-historia-del-tiempo-presente-lo-que-cambio-el-plan-laboral-de-la-dictadura-6117",
             "https://fundacionsol.cl/blog/estudios-2/post/desposesion-salarial-en-chile-panorama-de-los-verdaderos-sueldos-usando-la-encuesta-casen-6189",
             "https://fundacionsol.cl/blog/estudios-2/post/proyecto-de-reforma-laboral-sintesis-de-los-principales-puntos-en-discusion-6109",
             "https://fundacionsol.cl/blog/estudios-2/post/negociacion-colectiva-por-sector-economico-productividad-empleo-y-desigualdad-un-analisis-comparado-6119",
             "https://fundacionsol.cl/blog/estudios-2/post/salario-minimo-y-casen-2013-trabajadores-ganando-el-salario-minimo-o-menos-en-chile-6113",
             "https://fundacionsol.cl/blog/estudios-2/post/reforma-laboral-pone-fin-al-plan-laboral-de-la-dictadura-o-lo-consolida-6106",
             "https://fundacionsol.cl/blog/estudios-2/post/mujeres-trabajando-una-exploracion-al-valor-del-trabajo-y-la-calidad-del-empleo-en-chile-6108",
             "https://fundacionsol.cl/blog/estudios-2/post/los-verdaderos-sueldos-en-chile-6155",
             "https://fundacionsol.cl/blog/estudios-2/post/antecedentes-del-modelo-de-relaciones-laborales-chileno-6175",
             "https://fundacionsol.cl/blog/estudios-2/post/los-verdaderos-sueldos-en-chile-panorama-actual-del-valor-del-trabajo-nesi2013-6176",
             "https://fundacionsol.cl/blog/estudios-2/post/sindicatos-y-negociacion-colectiva-6144",
             "https://fundacionsol.cl/blog/estudios-2/post/informe-mensual-de-calidad-del-empleo-imce-mayo-julio-2014-6184",
             "https://fundacionsol.cl/blog/estudios-2/post/diagnostico-y-propuesta-para-un-verdadero-sistema-de-pensiones-6121",
             "https://fundacionsol.cl/blog/estudios-2/post/la-acumulacion-flexible-en-chile-aportes-a-una-lectura-socio-historica-de-las-transformaciones-recientes-del-trabajo-6120",
             "https://fundacionsol.cl/blog/estudios-2/post/panorama-sindical-y-de-la-negociaci-on-colectiva-en-el-chile-de-los-us-22-655-6118",
             "https://fundacionsol.cl/blog/estudios-2/post/por-una-reforma-laboral-verdadera-6116",
             "https://fundacionsol.cl/blog/estudios-2/post/el-trabajo-como-centro-de-la-estrategia-de-desarrollo-6111",
             "https://fundacionsol.cl/blog/estudios-2/post/precariedad-laboral-y-modelo-productivo-en-chile-6112",
             "https://fundacionsol.cl/blog/estudios-2/post/politica-de-reajuste-del-salario-minimo-una-meta-para-avanzar-al-desarrollo-6122",
             "https://fundacionsol.cl/blog/estudios-2/post/el-desalojo-de-la-educacion-publica-6114",
             "https://fundacionsol.cl/blog/estudios-2/post/panorama-general-de-los-trabajadores-dependientes-que-ganan-el-salario-minimo-6183",
             "https://fundacionsol.cl/blog/estudios-2/post/caracterizacion-y-propuestas-de-cambio-al-sistema-de-gratificaciones-en-chile-6110"
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

nombre_archivo <- "FS Estudios.xlsx"
write.xlsx(datos_totales, file = nombre_archivo, row.names = FALSE)

mensaje_final <- paste("Los datos se han extraído correctamente y se han guardado en el archivo", nombre_archivo)
print(mensaje_final)
