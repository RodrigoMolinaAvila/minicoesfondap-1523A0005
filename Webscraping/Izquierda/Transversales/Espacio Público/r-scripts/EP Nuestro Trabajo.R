# ---*** R10 CODES ***--- N°48

library(rvest)
library(tidyverse)
library(openxlsx)

lista_urls <- c(
  "https://espaciopublico.cl/nuestro_trabajo/desarrollo-del-transporte-en-regiones-radiografia-del-uso-del-fondo-espejo-y-propuestas/",
  "https://espaciopublico.cl/nuestro_trabajo/estado-de-situacion-del-transporte-en-las-ciudades-de-region-de-chile-lecciones-de-tres-casos-de-estudio-documento-de-referencia-n38/",
  "https://espaciopublico.cl/nuestro_trabajo/transantiago-nueva-licitacion-que-abre-oportunidades/",
  "https://espaciopublico.cl/nuestro_trabajo/analisis-de-incentivos-contractuales-y-propuestas-para-el-rediseno-de-transantiago-documento-de-referencia-n-35/",
  "https://espaciopublico.cl/nuestro_trabajo/propuestas-para-revertir-la-segregacion-urbana-en-nuestras-ciudades/",
  "https://espaciopublico.cl/nuestro_trabajo/institucionalidad-para-la-integracion-social-urbana-documento-de-referencia-n5/",
  "https://espaciopublico.cl/nuestro_trabajo/transporte-como-motor-de-integracion-social-urbana-documento-de-referencia-n6/",
  "https://espaciopublico.cl/nuestro_trabajo/control-de-la-segregacion-socio-espacial-rebatiendo-mitos-construyendo-propuestas-documento-de-referencia-n7/",
  "https://espaciopublico.cl/nuestro_trabajo/instrumentos-de-planificacion-territorial-para-la-integracion-social-en-areas-urbanas-documento-de-referencia-n8/",
  "https://espaciopublico.cl/nuestro_trabajo/informe-de-politica-publica-transferencias-del-estado-a-instituciones-privadas-diagnostico-y-propuestas-para-un-mejor-gasto-fiscal/",
  "https://espaciopublico.cl/nuestro_trabajo/informe-de-seguridad-publica-tendencias-recientes-en-crimen/",
  "https://espaciopublico.cl/nuestro_trabajo/informe-indicador-de-corrupcion-en-latinoamerica-implementacion-piloto-chile-colombia-y-mexico/",
  "https://espaciopublico.cl/nuestro_trabajo/libro-comision-de-sistema-politico-acuerdos-y-desacuerdos-en-los-cimientos-de-la-propuesta-constitucional/",
  "https://espaciopublico.cl/nuestro_trabajo/periodismo-de-investigacion-en-cuba-nuevas-voces-nuevos-relatos-2021-2022/",
  "https://espaciopublico.cl/nuestro_trabajo/derecho-penal-en-tiempos-de-covid-19-la-criminalizacion-de-los-incumplimientos-a-la-medida-de-aislamiento-social-preventivo-obligatorio-en-chile-y-la-argentina/",
  "https://espaciopublico.cl/nuestro_trabajo/recomendacion-legislativa-n27/",
  "https://espaciopublico.cl/nuestro_trabajo/lecciones-tras-la-primera-experiencia-de-votacion-en-dos-dias-en-chile/",
  "https://espaciopublico.cl/nuestro_trabajo/informe-lupa-electoral/",
  "https://espaciopublico.cl/nuestro_trabajo/real-informe-transparencia-y-prevencion-de-la-corrupcion-en-tiempos-de-pandemia-en-america-latina/",
  "https://espaciopublico.cl/nuestro_trabajo/corrupcion-en-america-latina-analisis-comparado-y-propuestas-para-enfrentarla-los-casos-de-chile-mexico-y-colombia/",
  "https://espaciopublico.cl/nuestro_trabajo/un-sistema-electoral-mixto-proporcional-paritario-y-con-representacion-de-pueblos-originarios/",
  "https://espaciopublico.cl/nuestro_trabajo/periodismo-de-investigacion-en-cuba-nuevas-voces-nuevos-relatos-2021/",
  "https://espaciopublico.cl/nuestro_trabajo/recomendaciones-sobre-probidad-y-prevencion-de-conflictos-de-intereses-para-la-convencion-constitucional/",
  "https://espaciopublico.cl/nuestro_trabajo/voto-anticipado-en-locales-de-votacion-perspectiva-comparada-y-revision-de-la-literatura/",
  "https://espaciopublico.cl/nuestro_trabajo/curso-de-periodismo-de-investigacion/",
  "https://espaciopublico.cl/nuestro_trabajo/voto-postal-desde-el-extranjero/",
  "https://espaciopublico.cl/nuestro_trabajo/voto-anticipado-y-urnas-moviles/",
  "https://espaciopublico.cl/nuestro_trabajo/voto-postal-en-perspectiva-comparada/",
  "https://espaciopublico.cl/nuestro_trabajo/encuesta-ipsos-espacio-publico-que-perfil-de-constituyentes-queremos-en-la-convencion/",
  "https://espaciopublico.cl/nuestro_trabajo/el-sistema-de-justicia-penal-y-su-lucha-contra-la-corrupcion-en-america-latina/",
  "https://espaciopublico.cl/nuestro_trabajo/encuesta-ipsos-espacio-publico-condiciones-para-un-plebiscito-seguro/",
  "https://espaciopublico.cl/nuestro_trabajo/contexto-factual/",
  "https://espaciopublico.cl/nuestro_trabajo/plataforma-contexto/",
  "https://espaciopublico.cl/nuestro_trabajo/elementos-sanitarios-y-medidas-para-promover-la-participacion-en-procesos-eleccionarios-en-contexto-de-pandemia/",
  "https://espaciopublico.cl/nuestro_trabajo/analisis-de-espacio-publico-a-la-cuenta-publica-presidencial-2020/",
  "https://espaciopublico.cl/nuestro_trabajo/periodismo-de-investigacion-en-cuba-nuevas-voces-nuevos-relatos/",
  "https://espaciopublico.cl/nuestro_trabajo/plebiscito-y-covid-19-consideraciones-y-recomendaciones-para-votar-de-manera-segura/",
  "https://espaciopublico.cl/nuestro_trabajo/proyecto-de-ley-que-establece-un-nuevo-estatuto-de-proteccion-en-favor-del-denunciante-recomendacion-legislativa-n26/",
  "https://espaciopublico.cl/nuestro_trabajo/recomendaciones-para-fomentar-inclusion-en-el-proceso-constituyente/",
  "https://espaciopublico.cl/nuestro_trabajo/proceso-de-descentralizacion-en-chile-diagnostico-y-propuestas/",
  "https://espaciopublico.cl/nuestro_trabajo/propuestas-para-iniciar-un-proceso-de-reforma-a-carabineros-de-chile/",
  "https://espaciopublico.cl/nuestro_trabajo/agenda-de-probidad-transparencia-y-lucha-contra-la-impunidad/",
  "https://espaciopublico.cl/nuestro_trabajo/agenda-para-combatir-la-impunidad/",
  "https://espaciopublico.cl/nuestro_trabajo/laboratorio-latinoamericano-de-politicas-de-probidad-y-transparencia-un-proyecto-de-cooperacion-sur-sur/",
  "https://espaciopublico.cl/nuestro_trabajo/reformas-anticorrupcion-en-chile-2015-2017-como-se-hizo-para-mejorar-la-democracia/",
  "https://espaciopublico.cl/nuestro_trabajo/indice-de-riesgo-de-corrupcion-en-el-sistema-de-compra-publica-colombiano-a-partir-de-una-metodologia-desarrollada-por-el-instituto-mexicano-para-la-competitividad-documento-de-referencia/",
  "https://espaciopublico.cl/nuestro_trabajo/compras-publicas-y-big-data-el-caso-mexicano-documento-de-referencia-n45/",
  "https://espaciopublico.cl/nuestro_trabajo/nota-tecnica-regional-compras-publicas-y-big-data-documento-de-referencia-n46/",
  "https://espaciopublico.cl/nuestro_trabajo/apoyo-para-la-implementacion-de-un-plan-estrategico-de-anticorrupcion-en-ecuador/",
  "https://espaciopublico.cl/nuestro_trabajo/apoyo-para-la-implementacion-de-una-agenda-anticorrupcion-en-peru/",
  "https://espaciopublico.cl/nuestro_trabajo/analisis-de-espacio-publico-a-la-cuenta-publica-presidencial-2019/",
  "https://espaciopublico.cl/nuestro_trabajo/programa-para-mejorar-la-gobernanza-en-provision-de-infraestructura-publica-en-america-latina/",
  "https://espaciopublico.cl/nuestro_trabajo/periodismo-de-investigacion-en-cuba-nuevas-voces-nuevos-relatos-2/",
  "https://espaciopublico.cl/nuestro_trabajo/proyecto-de-ley-modifica-la-ley-sobre-acceso-a-la-informacion-publica-recomendacion-legislativa-n23/",
  "https://espaciopublico.cl/nuestro_trabajo/informes-panoramicos-anticorrupcion-real/",
  "https://espaciopublico.cl/nuestro_trabajo/propuestas-sobre-transparencia-acceso-a-informacion-publica-y-gestion-de-informacion-en-el-estado/",
  "https://espaciopublico.cl/nuestro_trabajo/proyecto-de-ley-que-fortalece-la-integridad-publica-recomendacion-legislativa-n22/",
  "https://espaciopublico.cl/nuestro_trabajo/analisis-de-implementacion-de-las-nuevas-reglas-de-financiamiento-a-la-politica-y-campanas-electorales/",
  "https://espaciopublico.cl/nuestro_trabajo/minuta-proyecto-de-ley-de-integridad-publica-recomendacion-legislativa-n21/",
  "https://espaciopublico.cl/nuestro_trabajo/propuesta-tipificacion-a-delitos-de-cohecho-y-soborno-boletin-n-10-739-recomendacion-legislativa-n20/",
  "https://espaciopublico.cl/nuestro_trabajo/laboratorio-latinoamericano-de-politicas-anticorrupcion/",
  "https://espaciopublico.cl/nuestro_trabajo/observatorio-anticorrupcion-2-0/",
  "https://espaciopublico.cl/nuestro_trabajo/obras-publicas-infraestructura-y-corrupcion/",
  "https://espaciopublico.cl/nuestro_trabajo/periodismo-de-investigacion-en-contextos-politicos-complejos-experiencias-para-informar-y-combatir-la-corrupcion-caso-chileno-y-cubano/",
  "https://espaciopublico.cl/nuestro_trabajo/regulacion-del-nepotismo-recomendacion-legislativa-n19/",
  "https://espaciopublico.cl/nuestro_trabajo/proyecto-de-ley-que-modifica-la-ley-organica-constitucional-del-congreso-nacional-y-otros-cuerpos-legales-en-lo-relativo-a-probidad-y-transparencia-recomendacion-legislativa-n18/",
  "https://espaciopublico.cl/nuestro_trabajo/proyecto-de-ley-que-modifica-las-penas-en-delitos-de-cohecho-y-soborno-tipifica-el-soborno-entre-particulares-y-la-administracion-desleal-y-modifica-la-ley-de-responsabilidad-penal-de-las-perso/",
  "https://espaciopublico.cl/nuestro_trabajo/real-red-anticorrupcion-de-latinoamerica/",
  "https://espaciopublico.cl/nuestro_trabajo/chile-check/",
  "https://espaciopublico.cl/nuestro_trabajo/hacia-el-chile-que-queremos-propuestas-para-enriquecer-los-debates-programaticos-de-las-candidaturas-presidenciales/",
  "https://espaciopublico.cl/nuestro_trabajo/proyecto-de-ley-de-puerta-giratoria-e-inhabilidades-recomendacion-legislativa-n16/",
  "https://espaciopublico.cl/nuestro_trabajo/proyecto-de-ley-de-audiencias-para-nombramientos-del-congreso-recomendacion-legislativa-n15/",
  "https://espaciopublico.cl/nuestro_trabajo/proyecto-de-ley-que-tipifica-el-delito-de-corrupcion-entre-particulares-y-modifica-delitos-funcionarios-recomendacion-legislativa-n14-noviembre-2016/",
  "https://espaciopublico.cl/nuestro_trabajo/lupa-electoral/",
  "https://espaciopublico.cl/nuestro_trabajo/proyecto-de-ley-de-audiencias-para-nombramientos-del-congreso-recomendaciones-legislativas-no-13/",
  "https://espaciopublico.cl/nuestro_trabajo/propuestas-de-indicaciones-al-proyecto-de-fortalecimiento-al-congreso-en-materia-de-probidad-y-transparencia-recomendaciones-legislativas-no-11/",
  "https://espaciopublico.cl/nuestro_trabajo/proyecto-de-fortalecimiento-al-congreso-en-materia-de-probidad-y-transparencia-recomendaciones-legislativas-no-10/",
  "https://espaciopublico.cl/nuestro_trabajo/emparejando-la-cancha-nueva-institucionalidad-para-la-accion-legislativa/",
  "https://espaciopublico.cl/nuestro_trabajo/observaciones-al-proyecto-de-ley-que-perfecciona-el-sistema-de-alta-direccion-publica-recomendaciones-legislativas-no-9/",
  "https://espaciopublico.cl/nuestro_trabajo/organismos-independientes-para-el-analisis-presupuestario-y-economico-una-propuesta-para-chile-documento-de-referencia-n31/",
  "https://espaciopublico.cl/nuestro_trabajo/acceso-a-informacion-publica-para-la-investigacion-documento-de-referencia-n32/",
  "https://espaciopublico.cl/nuestro_trabajo/proyecto-de-ley-de-partidos-politicos-recomendaciones-legislativas-no-8/",
  "https://espaciopublico.cl/nuestro_trabajo/proyecto-de-ley-de-partidos-politicos-recomendaciones-legislativas-no-7/",
  "https://espaciopublico.cl/nuestro_trabajo/proyecto-de-ley-de-fortalecimiento-y-transparencia-de-la-democracia-recomendaciones-legislativas-no-6/",
  "https://espaciopublico.cl/nuestro_trabajo/desafios-para-una-politica-publica-en-base-a-dos-decadas-de-aprendizaje-documento-de-referencia-n27/",
  "https://espaciopublico.cl/nuestro_trabajo/observatorio-anticorrupcion/",
  "https://espaciopublico.cl/nuestro_trabajo/fortalecimiento-del-servel-recomendaciones-legislativas-no-5/",
  "https://espaciopublico.cl/nuestro_trabajo/proyecto-de-ley-de-partidos-politicos-recomendaciones-legislativas-no-4/",
  "https://espaciopublico.cl/nuestro_trabajo/proyecto-de-ley-que-perfecciona-el-sistema-de-alta-direccion-publica-recomendaciones-legislativas-no-3/",
  "https://espaciopublico.cl/nuestro_trabajo/proyecto-de-autonomia-del-servel-recomendaciones-legislativas-no-2/",
  "https://espaciopublico.cl/nuestro_trabajo/proyecto-de-ley-de-partidos-politicos-recomendaciones-legislativas-no-1/",
  "https://espaciopublico.cl/nuestro_trabajo/confianza-en-instituciones-politicas-en-chile-documento-de-referencia-n25/",
  "https://espaciopublico.cl/nuestro_trabajo/remando-para-el-mismo-lado-jovenes-consumo-de-medios-participacion-politica-y-confianza-en-instituciones-en-chile-2009-2013-documento-de-referencia-n26/",
  "https://espaciopublico.cl/nuestro_trabajo/mas-democracia-para-chile-propuestas-para-avanzar-hacia-una-saludable-relacion-entre-dinero-y-politica/",
  "https://espaciopublico.cl/nuestro_trabajo/debilidades-de-la-regulacion-chilena-sobre-la-relacion-entre-dinero-y-politica-experiencia-internacional-y-mejores-practicas-para-chile-documento-de-referencia-n20/",
  "https://espaciopublico.cl/nuestro_trabajo/politicas-de-integracion-de-poblacion-migrante-en-municipios-chilenos/",
  "https://espaciopublico.cl/nuestro_trabajo/observatorio-pactos-de-migracion-en-america-latina/",
  "https://espaciopublico.cl/nuestro_trabajo/estudio-de-analisis-comparativo-regional-de-las-regulaciones-migratorias-en-america-latina-documento-de-referencia-n39/",
  "https://espaciopublico.cl/nuestro_trabajo/chile-diverso-institucionalidad-para-la-igualdad/",
  "https://espaciopublico.cl/nuestro_trabajo/institucionalidad-antidiscriminacion-una-perspectiva-desde-el-derecho-comparado-documento-de-referencia-n33/",
  "https://espaciopublico.cl/nuestro_trabajo/diagnostico-de-la-institucionalidad-sobre-diversidad-y-no-discriminacion-en-el-estado-chileno-documento-de-referencia-n34/",
  "https://espaciopublico.cl/nuestro_trabajo/propuesta-de-reforma-a-la-regulacion-de-la-transmision-electrica-en-chile-documento-de-referencia-n14/",
  "https://espaciopublico.cl/nuestro_trabajo/observatorio-del-empleo-joven-la-mirada-de-losas-jovenes-sobre-el-mercado-laboral/",
  "https://espaciopublico.cl/nuestro_trabajo/el-primer-empleo-como-forma-de-reduccion-de-la-violencia-y-discriminacion-el-caso-arbusta/",
  "https://espaciopublico.cl/nuestro_trabajo/la-otra-pandemia-consecuencias-en-el-empleo-femenino-diagnostico-y-recomendaciones-para-su-reactivacion/",
  "https://espaciopublico.cl/nuestro_trabajo/hagamos-la-pega-propuestas-para-activar-laboralmente-a-los-grupos-excluidos/",
  "https://espaciopublico.cl/nuestro_trabajo/informe-jovenes-en-la-mira-discriminacion-violencia-y-estigmatizacion-en-america-latina-y-el-caribe/",
  "https://espaciopublico.cl/nuestro_trabajo/recuperacion-de-empleos-con-triple-ganancia-resiliencia-climatica-inclusion-social-y-multiplicador-fiscal/",
  "https://espaciopublico.cl/nuestro_trabajo/analisis-de-espacio-publico-a-la-cuenta-publica-presidencial-2019/",
  "https://espaciopublico.cl/nuestro_trabajo/informe-de-evaluacion-programa-sumate-a-tu-oportunidad-de-fundacion-sumate-del-hogar-de-cristo/",
  "https://espaciopublico.cl/nuestro_trabajo/millennials-en-america-latina-y-el-caribe-trabajar-o-estudiar/",
  "https://espaciopublico.cl/nuestro_trabajo/desigualdades-de-genero-en-la-educacion-media-tecnico-profesional-informe-final-estudio-cualitativo-documento-de-referencia-n37/",
  "https://espaciopublico.cl/nuestro_trabajo/insercion-laboral-y-social-de-los-jovenes-una-revision-internacional-documento-de-referencia-n22/",
  "https://espaciopublico.cl/nuestro_trabajo/ongs-trabajando-con-jovenes-vulnerables-en-chile-identificacion-y-descripcion-de-casos-de-exito-documento-de-referencia-n23/",
  "https://espaciopublico.cl/nuestro_trabajo/un-centro-nacional-de-liderazgo-escolar-en-chile-antecedentes-para-su-diseno-documento-de-referencia-n21/",
  "https://espaciopublico.cl/nuestro_trabajo/hacia-un-sistema-escolar-mas-inclusivo-como-reducir-la-segregacion-escolar-en-chile/",
  "https://espaciopublico.cl/nuestro_trabajo/logra-la-subvencion-escolar-preferencial-igualar-los-resultados-educativos-documento-de-referencia-n9/",
  "https://espaciopublico.cl/nuestro_trabajo/los-efectos-de-la-eleccion-escolar-en-la-segregacion-socioeconomica-en-chile-un-analisis-georeferenciado-documento-de-referencia-n1/",
  "https://espaciopublico.cl/nuestro_trabajo/desigualdad-de-oportunidades-para-elegir-escuela-preferencias-libertad-de-eleccion-y-segregacion-escolar-documento-de-referencia-n2/",
  "https://espaciopublico.cl/nuestro_trabajo/segregacion-y-polarizacion-en-el-sistema-escolar-chileno-y-recientes-tendencias-que-ha-sucedido-con-los-grupos-medios-documento-de-referencia-n3/",
  "https://espaciopublico.cl/nuestro_trabajo/proyecto-que-crea-la-comision-de-valores-y-seguros-recomendaciones-legislativas-no-12/",
  "https://espaciopublico.cl/nuestro_trabajo/aclarando-las-reglas-del-juego-propuestas-para-mejorar-la-coordinacion-entre-el-sernac-y-los-reguladores-sectoriales/",
  "https://espaciopublico.cl/nuestro_trabajo/hacia-una-mejor-coordinacion-entre-las-instituciones-publicas-relacionadas-con-la-proteccion-al-consumidor-documento-de-referencia-n24/",
  "https://espaciopublico.cl/nuestro_trabajo/promocion-de-la-competencia-en-el-sector-electrico-documento-de-referencia-n16/",
  "https://espaciopublico.cl/nuestro_trabajo/propuestas-para-una-proteccion-efectiva-de-los-consumidores/",
  "https://espaciopublico.cl/nuestro_trabajo/proteccion-efectiva-del-consumidor-documento-de-referencia-n4/",
  "https://espaciopublico.cl/nuestro_trabajo/informe-de-politica-publica-crisis-de-las-isapres-vias-de-solucion-para-un-problema-cronico/",
  "https://espaciopublico.cl/nuestro_trabajo/nota-de-politica-publica-no1-autoprestamos-en-el-sistema-de-pensiones/",
  "https://espaciopublico.cl/nuestro_trabajo/encuesta-ep-pnud-e-ipsos-anhelos-y-preocupaciones-de-la-ciudadania-frente-a-la-reforma-previsional/",
  "https://espaciopublico.cl/nuestro_trabajo/pensar-la-pandemia-desde-un-nuevo-enfoque-6-propuestas-para-la-gestion-del-riesgo-de-desastres-como-marco-de-accion-para-la-pandemia-y-la-recuperacion/",
  "https://espaciopublico.cl/nuestro_trabajo/retiro-del-10-emergencia-economica-y-necesidad-de-una-reforma-estructural-a-las-pensiones/",
  "https://espaciopublico.cl/nuestro_trabajo/encuesta-ipsos-espacio-publico-como-se-vive-la-cuarentena-en-la-region-metropolitana-y-regiones/",
  "https://espaciopublico.cl/nuestro_trabajo/espacio-publico-presenta-reportes-semanales-de-la-evolucion-del-contagio-y-fallecidos-por-covid-19-chile-y-resto-del-mundo-en-fechas-comparables/",
  "https://espaciopublico.cl/nuestro_trabajo/analisis-de-espacio-publico-reformas-de-salud-del-gobierno/",
  "https://espaciopublico.cl/nuestro_trabajo/analisis-de-espacio-publico-a-la-cuenta-publica-presidencial-2019/",
  "https://espaciopublico.cl/nuestro_trabajo/principios-para-una-reforma-al-sistema-de-pensiones/",
  "https://espaciopublico.cl/nuestro_trabajo/sistema-de-pensiones-opiniones-y-demandas-ciudadanas-documento-de-referencia-n36/",
  "https://espaciopublico.cl/nuestro_trabajo/tratamiento-para-un-enfermo-critico-propuestas-para-el-sistema-de-salud-chileno/",
  "https://espaciopublico.cl/nuestro_trabajo/propuesta-de-reformas-a-los-prestadores-publicos-de-servicios-medicos-en-chile-documento-de-referencia-n12/",
  "https://espaciopublico.cl/nuestro_trabajo/el-mercado-de-los-seguros-privados-obligatorios-de-salud-diagnostico-y-reforma-documento-de-referencia-n11/",
  "https://espaciopublico.cl/nuestro_trabajo/opciones-de-reforma-a-la-seguridad-social-en-salud-en-chile-documento-de-referencia-n13/",
  "https://espaciopublico.cl/nuestro_trabajo/mujeres-empleos-verdes-y-pueblos-indigenas-construyendo-el-camino-para-una-recuperacion-justa-y-resiliente-en-america-latina/",
  "https://espaciopublico.cl/nuestro_trabajo/recuperacion-justa-y-resiliente-en-chile-en-el-contexto-del-covid-19/",
  "https://espaciopublico.cl/nuestro_trabajo/latinoamerica-sostenible-recuperacion-justa-y-resiliente-en-america-latina-para-enfrentar-el-cambio-climatico/",
  "https://espaciopublico.cl/nuestro_trabajo/viviendas-y-transporte-urbano-sustentable-claves-para-construir-ciudades-resilientes-en-chile/",
  "https://espaciopublico.cl/nuestro_trabajo/descarbonizacion-en-chile-como-avanzar-a-traves-de-instrumentos-economicos-y-fiscales/",
  "https://espaciopublico.cl/nuestro_trabajo/reconstruyendo-la-piedra-angular-de-la-economia-latinoamericana-como-crear-mas-y-mejores-empleos/",
  "https://espaciopublico.cl/nuestro_trabajo/latinoamerica-sostenible-cambiando-el-rumbo-hacia-una-recuperacion-justa-y-resiliente/",
  "https://espaciopublico.cl/nuestro_trabajo/informe-hallazgos-y-recomendaciones-para-mejorar-la-calidad-de-la-participacion-en-territorios-con-mineria-a-gran-escala/",
  "https://espaciopublico.cl/nuestro_trabajo/latinoamerica-sostenible-propuestas-para-una-reactivacion-resiliente-y-justa/",
  "https://espaciopublico.cl/nuestro_trabajo/anteproyecto-de-ley-marco-de-cambio-climatico-recomendacion-legislativa-n25/",
  "https://espaciopublico.cl/nuestro_trabajo/proyecto-de-ley-que-modifica-la-institucionalidad-ambiental-y-el-sistema-de-evaluacion-de-impacto-ambiental-recomendacion-legislativa-n24/",
  "https://espaciopublico.cl/nuestro_trabajo/participacion-en-la-cop25-en-chile/",
  "https://espaciopublico.cl/nuestro_trabajo/evaluacion-socio-ambiental-de-proyectos-geotermicos-y-eolicos/",
  "https://espaciopublico.cl/nuestro_trabajo/sistema-de-dialogo-entre-empresas-comunidades-y-estado-en-proyectos-de-inversion/",
  "https://espaciopublico.cl/nuestro_trabajo/plataformas-de-dialogo-en-industrias-extractivas-en-chile-y-peru/",
  "https://espaciopublico.cl/nuestro_trabajo/acuerdo-de-escazu/",
  "https://espaciopublico.cl/nuestro_trabajo/derribando-mitos-propuestas-para-mejorar-el-acceso-a-la-justicia-ambiental/",
  "https://espaciopublico.cl/nuestro_trabajo/del-conflicto-al-dialogo-como-avanzar-hacia-un-sistema-de-decisiones-ambientales-participativas-en-chile/",
  "https://espaciopublico.cl/nuestro_trabajo/estrategias-y-practicas-de-relacionamiento-comunitario-en-el-marco-de-participacion-ciudadana-documento-de-referencia-n28/",
  "https://espaciopublico.cl/nuestro_trabajo/experiencia-nacional-e-internacional-en-mediacion-de-conflictos-socio-ambientales-documento-de-referencia-n29/",
  "https://espaciopublico.cl/nuestro_trabajo/sociedad-civil-por-la-accion-climatica/",
  "https://espaciopublico.cl/nuestro_trabajo/politicas-nacionales-territorios-regionales-propuestas-para-un-ordenamiento-territorial-en-energia/",
  "https://espaciopublico.cl/nuestro_trabajo/impuestos-verdes-a-los-combustibles-una-propuesta-para-su-implementacion-en-chile-documento-de-referencia-n10/",
  "https://espaciopublico.cl/nuestro_trabajo/desarrollo-de-la-ernc-en-chile-desafios-tecnicos-regulatorios-e-institucionales-documento-de-referencia-n19/",
  "https://espaciopublico.cl/nuestro_trabajo/energia-y-orden-territorial-documento-de-referencia-n17/",
  "https://espaciopublico.cl/nuestro_trabajo/participacion-ciudadana-en-el-sector-energetico-chileno-elementos-clave-y-propuestas-documento-de-referencia-n18/",
  "https://espaciopublico.cl/nuestro_trabajo/como-vemos-el-proceso-constituyente-2023-miradas-a-una-segunda-oportunidad/",
  "https://espaciopublico.cl/nuestro_trabajo/encuesta-espacio-publico-ipsos-2022-chilenas-y-chilenos-hoy/",
  "https://espaciopublico.cl/nuestro_trabajo/encuesta-ipsos-espacio-publico-por-proceso-constituyente-noviembre-2022/",
  "https://espaciopublico.cl/nuestro_trabajo/proyecto-ipsos-espacio-publico-como-vemos-el-proceso-constituyente-miradas-a-un-momento-historico/",
  "https://espaciopublico.cl/nuestro_trabajo/encuesta-espacio-publico-ipsos-2021-chilenas-y-chilenos-hoy/",
  "https://espaciopublico.cl/nuestro_trabajo/debate-digital/",
  "https://espaciopublico.cl/nuestro_trabajo/encuesta-ipsos-ep-participacion-ciudadana-en-proceso-constituyente/",
  "https://espaciopublico.cl/nuestro_trabajo/encuesta-espacio-publico-ipsos-chilenas-y-chilenos-hoy-2020/",
  "https://espaciopublico.cl/nuestro_trabajo/encuesta-ipsos-espacio-publico-que-perfil-de-constituyentes-queremos-en-la-convencion/",
  "https://espaciopublico.cl/nuestro_trabajo/encuesta-ipsos-espacio-publico-condiciones-para-un-plebiscito-seguro/",
  "https://espaciopublico.cl/nuestro_trabajo/encuesta-ipsos-espacio-publico-como-se-vive-la-cuarentena-en-la-region-metropolitana-y-regiones/",
  "https://espaciopublico.cl/nuestro_trabajo/encuesta-espacio-publico-ipsos-chilenas-y-chilenos-hoy-2019/",
  "https://espaciopublico.cl/nuestro_trabajo/encuesta-espacio-publico-ipsos-movilizaciones-2019/",
  "https://espaciopublico.cl/nuestro_trabajo/segunda-edicion-chilenas-y-chilenos-hoy-desafiando-los-prejuicios-complejizando-la-discusion/",
  "https://espaciopublico.cl/nuestro_trabajo/chilenas-y-chilenos-hoy-desafiando-los-prejuicios-complejizando-la-discusion/"
)

lista_resultados <- list()

for (i in seq_along(lista_urls)) {
  url <- lista_urls[i]
  
  cat("Enlace ", i, " de ", length(lista_urls), " procesado\n")
  
  page <- read_html(url)
  
  titulo <- page %>%
    html_node("title") %>%
    html_text() %>%
    str_remove(" – Espacio Público")
  
  fecha_publicacion <- page %>%
    html_node(xpath = "//span[contains(., 'Fecha de publicación')]/text()") %>%
    html_text() %>%
    str_remove("Fecha de publicación: ")
  
  tipo_publicacion <- page %>%
    html_node(xpath = "//span[contains(., 'Tipo:')]/a") %>%
    html_text()
  
  area_estudio <- page %>%
    html_node(xpath = "//span[contains(., 'Área de estudio:')]/a") %>%
    html_text()
  
  autores <- page %>%
    html_nodes("span.ficha-proyecto-equipo li") %>%
    html_text() %>%
    paste(collapse = ", ")
  
  url_variable <- url
  
  datos <- data.frame(
    Titulo = titulo,
    Fecha_de_publicacion = fecha_publicacion,
    Tipo_de_publicacion = tipo_publicacion,
    Area_de_estudio = area_estudio,
    Autores = autores,
    URL = url_variable
  )
  
  lista_resultados[[url]] <- datos
}

resultados_completos <- do.call(rbind, lista_resultados)

write.xlsx(resultados_completos, "EP Nuestro Trabajo.xlsx")

cat("Listo :)")
