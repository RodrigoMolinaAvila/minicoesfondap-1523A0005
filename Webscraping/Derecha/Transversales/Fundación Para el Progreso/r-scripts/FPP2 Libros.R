# ---*** R10 CODES ***--- N°11

library(rvest)
library(tidyverse)
library(openxlsx)

enlaces <- c("https://fppchile.org/publicacion/interventionism-and-misery-1929-2008/",
             "https://fppchile.org/publicacion/la-fatal-ignorancia-2/",
             "https://fppchile.org/publicacion/america-latina-tendencias-y-perspectivas-del-nuevo-siglo/",
             "https://fppchile.org/publicacion/volar-alto-la-revolucion-de-la-movilidad-social-en-chile/",
             "https://fppchile.org/publicacion/un-legado-de-libertad-milton-friedman-en-chile/",
             "https://fppchile.org/publicacion/una-obra-para-la-libertad/",
             "https://fppchile.org/publicacion/en-torno-a-dos-debates-para-el-mundo-de-hoy/",
             "https://fppchile.org/publicacion/raices-cristianas-de-la-economia-de-libre-mercado/",
             "https://fppchile.org/publicacion/fundamentos-de-la-sociedad-libre/",
             "https://fppchile.org/publicacion/la-moralidad-del-capitalismo/",
             "https://fppchile.org/publicacion/por-que-la-libertad/",
             "https://fppchile.org/publicacion/del-consenso-a-la-encrucijada-el-debate-en-torno-al-modelo-chileno/",
             "https://fppchile.org/publicacion/el-poco-excepcional-modelo-escandinavo/",
             "https://fppchile.org/publicacion/suecia-el-otro-modelo-del-estado-benefactor-al-estado-solidario/",
             "https://fppchile.org/publicacion/liberalismo-clasico-manual-basico/",
             "https://fppchile.org/publicacion/capitalismo-por-que-no/",
             "https://fppchile.org/publicacion/las-bondades-del-pesimismo-y-el-peligro-de-la-falsa-esperanza/",
             "https://fppchile.org/publicacion/afrodita-desenmascarada-una-defensa-del-feminismo-liberal/",
             "https://fppchile.org/publicacion/libertad-y-socialismo/",
             "https://fppchile.org/publicacion/inmigracion-y-emprendimiento/",
             "https://fppchile.org/publicacion/malcriando-a-los-jovenes-estadounidenses/",
             "https://fppchile.org/publicacion/locos-impostores-y-agitadores-pensadores-de-la-nueva-izquierda/",
             "https://fppchile.org/publicacion/breve-historia-de-la-libertad/",
             "https://fppchile.org/publicacion/el-chile-que-viene/",
             "https://fppchile.org/publicacion/la-filosofia-de-la-violencia/",
             "https://fppchile.org/publicacion/el-mito-del-estado-emprendedor/",
             "https://fppchile.org/publicacion/la-tirania-de-la-igualdad/"
)

datos_libros <- data.frame(Fecha_Publicacion = character(),
                           Titulo = character(),
                           Autor = character(),
                           URL = character(),
                           stringsAsFactors = FALSE)

for (i in 1:length(enlaces)) {
  page <- read_html(enlaces[i])
  
  fecha_publicacion <- page %>% html_node("span.py-2.text-capitalize") %>% html_text()
  
  titulo <- page %>% html_node("h1.py-3") %>% html_text()
  
  autor <- page %>% html_node("small.d-block.mt-5") %>% html_text()
  
  libro_actual <- data.frame(Fecha_Publicacion = fecha_publicacion,
                             Titulo = titulo,
                             Autor = autor,
                             URL = enlaces[i],
                             stringsAsFactors = FALSE)
  
  datos_libros <- rbind(datos_libros, libro_actual)
  
  cat("Libro", i, "procesado\n")
}

write.xlsx(datos_libros, file = "FPP - Libros.xlsx", rowNames = FALSE)

print("FPP Libros - Listo")
