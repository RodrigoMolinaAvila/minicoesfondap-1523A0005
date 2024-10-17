# ---*** R10 CODES ***--- N°18
library(rvest)
library(tidyverse)
library(openxlsx)
library(sys)

enlaces <- c(
  "https://www.ieschile.cl/2023/05/punto-y-coma-8-la-gran-fractura-ideas-y-politica-en-el-chile-actual/",
  "https://www.ieschile.cl/2022/09/punto-y-coma-7/",
  "https://www.ieschile.cl/2022/04/nueva-edicion-de-punto-y-coma/",
  "https://www.ieschile.cl/2022/04/gabriela-mistral-entre-el-progreso-y-la-tradicion/",
  "https://www.ieschile.cl/2021/12/democracia-la-otra-revolucion/",
  "https://www.ieschile.cl/2021/11/ivan-valenzuela/",
  "https://www.ieschile.cl/2021/11/mediacion-politica-y-cambio-constitucional/",
  "https://www.ieschile.cl/2021/11/mariana-enriquez-y-su-parte-de-noche/",
  "https://www.ieschile.cl/2021/10/patria-amarga/",
  "https://www.ieschile.cl/2021/10/el-estado-en-crisis/",
  "https://www.ieschile.cl/2021/10/un-conservadurismo-verde/",
  "https://www.ieschile.cl/2021/09/puntoycoma5/",
  "https://www.ieschile.cl/2021/06/entrevista-a-gosta-esping-andersen/",
  "https://www.ieschile.cl/2021/05/entrevista-a-kathya-araujo/",
  "https://www.ieschile.cl/2021/03/punto-y-coma-4/",
  "https://www.ieschile.cl/2020/11/una-revolucion-que-ilumina-un-estallido/",
  "https://www.ieschile.cl/2020/11/en-busca-de-un-pacto-social/",
  "https://www.ieschile.cl/2020/10/pacto-de-clases/",
  "https://www.ieschile.cl/2020/10/teresa-bejan-la-sensacion-de-perdida-de-lo-comun-esta-en-muchas-partes/",
  "https://www.ieschile.cl/2020/10/exitoso-lanzamiento-de-revista-punto-y-coma-no3/",
  "https://www.ieschile.cl/2020/09/joaquin-fermandois-la-idea-de-revolucion-no-tiene-la-fuerza-semantica-que-tuvo-hasta-los-setenta/",
  "https://www.ieschile.cl/2020/09/patrick-iber/",
  "https://www.ieschile.cl/2020/09/puntoycoma3/",
  "https://www.ieschile.cl/2020/09/revolucion-con-banda-sonora/",
  "https://www.ieschile.cl/2020/09/las-ficciones-y-el-malestar/",
  "https://www.ieschile.cl/2020/08/la-unidad-popular-ante-la-historia-un-panorama-historiografico/",
  "https://www.ieschile.cl/2020/08/podria-haber-triunfado-allende/",
  "https://www.ieschile.cl/2020/08/un-fracaso-respetable/",
  "https://www.ieschile.cl/2020/07/fear-the-walking-dead-el-temor-a-la-anomia/",
  "https://www.ieschile.cl/2020/07/punto-y-coma-entrevista-a-gabriel-rodriguez/",
  "https://www.ieschile.cl/2020/06/una-literatura-de-puertas-abiertas/",
  "https://www.ieschile.cl/2020/06/primera-persona-singular-2/",
  "https://www.ieschile.cl/2020/06/noticias-falsas-en-la-era-del-ciberpesimismo/",
  "https://www.ieschile.cl/2020/02/diablo-conocido/",
  "https://www.ieschile.cl/2020/02/el-vicente-sin-cabeza/",
  "https://www.ieschile.cl/2020/01/el-ultimo-de-los-hegelianos/",
  "https://www.ieschile.cl/2020/01/banda-sonora/",
  "https://www.ieschile.cl/2020/01/olimpo-hannah-arendt/",
  "https://www.ieschile.cl/2020/01/lucho-gatica-suave-invasion/",
  "https://www.ieschile.cl/2020/01/houellebecq-el-sociologo/",
  "https://www.ieschile.cl/2019/12/nemesio-antunez-un-obituario-diferido/",
  "https://www.ieschile.cl/2019/12/la-vocacion-en-tiempos-de-desencanto/",
  "https://www.ieschile.cl/2019/12/el-populismo-en-el-siglo-xxi/",
  "https://www.ieschile.cl/2019/12/hacia-un-mundo-bipolar/",
  "https://www.ieschile.cl/2019/11/la-identidad-y-sus-consecuencias/",
  "https://www.ieschile.cl/2019/11/manual-para-dictadores/",
  "https://www.ieschile.cl/2019/11/innerarity-y-su-guia-para-perplejos/",
  "https://www.ieschile.cl/2019/10/el-liberalismo-y-su-historia/",
  "https://www.ieschile.cl/2019/10/alan-knight-si-el-populismo-alcanza-el-poder-suele-perder-su-dinamismo-y-si-sobrevive-suele-convertirse-en-una-forma-de-maquinaria-clientelista/",
  "https://www.ieschile.cl/2019/10/los-infortunios-de-la-democracia/",
  "https://www.ieschile.cl/2019/09/contrapunto-los-limites-de-el-liberalismo/",
  "https://www.ieschile.cl/2019/09/contrapunto-lamento-gregoriano/",
  "https://www.ieschile.cl/2019/09/con-debate-sobre-populismo-ies-lanza-nueva-revista-punto-y-coma/",
  "https://www.ieschile.cl/2019/08/editorial-punto-y-coma/",
  "https://www.ieschile.cl/2019/08/este-es-el-indice-del-primer-numero-de-punto-y-coma/"
)

datos_lista <- list()

for (i in seq_along(enlaces)) {
  enlace <- enlaces[i]
  
  cat(paste("Procesando enlace", i, "\n"))
  
  scraped_data <- read_html(enlace) %>%
    html_nodes("head") %>%
    html_nodes("title") %>%
    html_text()
  
  titulo <- scraped_data
  fecha_publicacion <- read_html(enlace) %>%
    html_nodes("meta[property='article:published_time']") %>%
    html_attr("content")
  autor <- read_html(enlace) %>%
    html_nodes("meta[name='twitter:data1']") %>%
    html_attr("content")
  
  datos_enlace <- data.frame(URL = enlace,
                             Título = titulo,
                             `Fecha de publicación` = fecha_publicacion,
                             Autor = autor)
  
  datos_lista[[enlace]] <- datos_enlace
  
  if (i < length(enlaces)) {
    Sys.sleep(2)
  }
}

datos_completos <- do.call(rbind, datos_lista)

print(datos_completos)

wb <- createWorkbook()

addWorksheet(wb, "Datos")

writeData(wb, "Datos", datos_completos)

saveWorkbook(wb, "IES Punto y Coma.xlsx", overwrite = TRUE)

cat("Información de Punto y Coma de IES Procesada Exitosamente")
