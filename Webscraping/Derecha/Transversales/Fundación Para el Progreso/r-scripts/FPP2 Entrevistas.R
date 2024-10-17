# ---*** R10 CODES ***--- N°13

library(rvest)
library(tidyverse)
library(openxlsx)

urls <- c(
  "https://fppchile.org/forbes-centroamerica-una-economia-contra-el-populismo/",
  "https://fppchile.org/mara-sedini-en-el-pinguino-la-gente-le-dio-mayoritariamente-el-voto-a-boric-confio-y-en-menos-de-un-ano-se-dio-cuenta-de-que-ha-sido-un-completo-desastre/",
  "https://fppchile.org/fernando-claro-en-el-mercurio-republicanos-no-representa-una-derecha-extrema-ni-radical/",
  "https://fppchile.org/mara-sedini-en-pelle-magazine-el-problema-con-el-feminismo-de-hoy-es-que-esta-tomado-y-controlado-por-organizaciones-politicas-de-izquierda-radical/",
  "https://fppchile.org/axel-kaiser-en-chile-la-elite-se-desconecto-de-la-realidad-de-la-mayoria/",
  "https://fppchile.org/fernando-claro-en-ex-ante-la-udi-deberia-juntarse-con-el-partido-republicano-hacer-las-paces-son-todos-viejos-amigos/",
  "https://fppchile.org/entrevista-axel-kaiser-en-la-estrella-de-panama/",
  "https://fppchile.org/axel-kaiser-en-la-nacion-si-en-la-argentina-hubiera-libre-comercio-desaparece-inmediatamente-el-70-de-la-casta/",
  "https://fppchile.org/fernando-claro-y-50-anos-del-golpe-desgraciadamente-no-lo-hemos-superado/",
  "https://fppchile.org/gonzalo-sanhueza-el-problema-de-la-economia-chilena-ya-no-es-la-inflacion-es-el-crecimiento/",
  "https://fppchile.org/gonzalo-sanhueza-hacia-mitad-de-este-ano-probablemente-estemos-con-una-tasa-de-interes-en-10/",
  "https://fppchile.org/axel-kaiser-en-entrevista-en-llego-la-hora-de-radio-agricultura/",
  "https://fppchile.org/yo-no-digo-que-no-haya-nada-de-redistribucion-lo-que-digo-es-que-la-prioridad-tiene-que-ser-la-creacion-de-riqueza/",
  "https://fppchile.org/pajaro-liberal/",
  "https://fppchile.org/entrevista-de-terapia-chilensis-a-nuestro-director-ejecutivo-fernando-claro/",
  "https://fppchile.org/correccion-politica-censura-y-liberalismo-en-la-region/",
  "https://fppchile.org/la-repregunta-mientras-mas-ricos-tenga-un-pais-y-mas-ricos-sean-mejor-para-todo-ese-pais-mas-ricos-vamos-a-ser-los-que-no-somos-ricos/",
  "https://fppchile.org/entrevista-a-deirdre-mccloskey-desafortunadamente-la-mayoria-de-las-personas-prefiere-no-ser-libre/",
  "https://fppchile.org/el-dificil-laberinto-de-lo-politicamente-correcto/",
  "https://fppchile.org/publican-ensayos-de-jorge-millas-sobre-la-violencia/",
  "https://fppchile.org/jefe-de-fpp-los-rios-marcos-balmaceda-fue-seleccionado-en-el-programa-de-posgrado-idea/",
  "https://fppchile.org/ariel-ruiz-urquiola-activista-cientifico-y-disidente-cubano/",
  "https://fppchile.org/coordinadora-de-proyectos-fpp-sascha-hannig-gana-beca-de-la-japan-international-cooperation-agency/",
  "https://fppchile.org/el-liberalismo-es-en-esencia-una-doctrina-humanista/",
  "https://fppchile.org/entrevista-a-fernando-claro-en-la-seccion-satirica-del-diario-el-mercurio/",
  "https://fppchile.org/entrevista-a-fernando-claro-v-desbordes-se-parece-a-peron/",
  "https://fppchile.org/coronavirus-no-podemos-concentrarnos-en-una-enfermedad-siempre-hay-que-ver-la-salud-en-general-dice-un-referente-mundial/",
  "https://fppchile.org/populismo-de-derecha-estados-unidos-europa-y-america-latina/",
  "https://fppchile.org/entrevista-joshua-wong-hong-kong-china/",
  "https://fppchile.org/entrevista-a-axel-kaiser-nunca-fue-tan-facil-que-te-llamen-fascista/",
  "https://fppchile.org/entrevista-a-fengsuo-zhou-sobreviviente-de-la-masacre-china-de-tiananmen/",
  "https://fppchile.org/ayaan-hirsi-ali-aqui-no-hay-islamofobia/",
  "https://fppchile.org/nicolas-ibanez-esta-la-conviccion-de-que-hay-que-dar-la-lucha-por-las-ideas/",
  "https://fppchile.org/niall-ferguson-no-pretendamos-que-la-revolucion-tecnologica-no-tiene-costos-hay-costos-reales/",
  "https://fppchile.org/niall-ferguson-los-partidarios-de-trump-no-estan-mejor-que-hace-12-meses-pero-eso-no-les-importa/",
  "https://fppchile.org/dos-liberales-cara-a-cara-gloria-alvarez-y-axel-kaiser/",
  "https://fppchile.org/si-iglesias-llega-al-poder-aprobaria-medidas-para-restringir-las-capacidades-de-los-ciudadanos/",
  "https://fppchile.org/la-crisis-sera-un-paseo-por-el-campo-en-comparacion-con-lo-que-hara-podemos/",
  "https://fppchile.org/un-gobierno-de-podemos-seria-catastrofico/",
  "https://fppchile.org/4431-2/",
  "https://fppchile.org/axel-kaiser-los-derechos-sociales-son-un-mito-un-derecho-social-es-un-derecho-a-la-plata-de-otro/",
  "https://fppchile.org/reflexione-la-utopia-comunista/",
  "https://fppchile.org/la-desigualdad-es-parte-del-proceso-de-crecimiento-economico-que-beneficia-a-todos/",
  "https://fppchile.org/ampuero-en-el-chile-profundo/",
  "https://fppchile.org/la-mayoria-de-la-gente-no-quiere-ser-igual-en-la-miseria/",
  "https://fppchile.org/rosende-todo-sugiere-que-nuestro-crecimiento-a-largo-plazo-sera-relativamente-mediocre/",
  "https://fppchile.org/roberto-ampuero-si-algo-ha-logrado-el-gobierno-ha-sido-latinoamericanizar-por-completo-a-chile/",
  "https://fppchile.org/axel-kaiser-director-ejecutivo-de-la-fundacion-para-el-progreso-logramos-despegarnos-por-30-anos-de-america-latina-y-ahora-volvemos-a-ser-un-pais-mediocre-conflictivo-y-populista/",
  "https://fppchile.org/entrevista-a-axel-kaiser-la-dc-si-fuera-consecuente-con-sus-principios-deberia-abandonar-el-gobierno-y-pasar-a-la-oposicion/",
  "https://fppchile.org/axel-kaiser-no-soy-de-derecha-y-si-alguien-de-izquierda-promueve-la-libertad-lo-apoyare/"
)

datos_lista <- list()

for (url in urls) {
  page <- read_html(url)
  
  publicacion <- page %>%
    html_node("a.source") %>%
    html_text()
  
  titulo <- page %>%
    html_node("h1") %>%
    html_text()
  
  autor <- page %>%
    html_node("span.nameAutor a") %>%
    html_text()
  
  url_variable <- url
  
  datos <- data.frame(URL = url_variable,
                      Publicación = publicacion,
                      Título = titulo,
                      Autor = autor)
  
  datos_lista[[url]] <- datos
  
  cat("Enlace Extraido:", url, "\n")
}

datos_completos <- bind_rows(datos_lista)

cat("Se ha completado el webscraping de todas las URLs.")

write.xlsx(datos_completos, file = "FPP - Entrevistas.xlsx")
