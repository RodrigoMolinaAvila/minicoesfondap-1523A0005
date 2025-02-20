import requests
from bs4 import BeautifulSoup
from tqdm import tqdm
import time
import pandas as pd

# Lista de URLs proporcionadas
urls = [
"https://fppchile.org/fernando-claro-en-la-segunda-del-informe-del-pnud-no-se-puede-concluir-que-chile-quiera-transformaciones-profundas/", 
"https://fppchile.org/como-se-juega-hoy-la-batalla-cultural-que-winter-cs-llamo-a-disputar-el-mercurio/", 
"https://fppchile.org/sanhueza-cuestiona-a-cfa-y-dipres-por-el-calculo-del-litio-las-dos-propuestas-son-demasiado-conservadoras/", 
"https://fppchile.org/axel-kaiser-veo-bastante-sintonia-entre-la-experiencia-de-javier-milei-y-la-mia/", 
"https://fppchile.org/forbes-centroamerica-una-economia-contra-el-populismo/", 
"https://fppchile.org/de-la-economia-a-la-ficcion-el-sorprendente-giro-de-axel-kaiser-en-su-nuevo-libro/", 
"https://fppchile.org/rompe-la-forma-evade-el-fondo/", 
"https://fppchile.org/fernando-claro-en-el-mercurio-republicanos-no-representa-una-derecha-extrema-ni-radical/", 
"https://fppchile.org/mara-sedini-en-pelle-magazine-el-problema-con-el-feminismo-de-hoy-es-que-esta-tomado-y-controlado-por-organizaciones-politicas-de-izquierda-radical/", 
"https://fppchile.org/axel-kaiser-en-chile-la-elite-se-desconecto-de-la-realidad-de-la-mayoria/", 
"https://fppchile.org/fernando-claro-en-ex-ante-la-udi-deberia-juntarse-con-el-partido-republicano-hacer-las-paces-son-todos-viejos-amigos/", 
"https://fppchile.org/entrevista-axel-kaiser-en-la-estrella-de-panama/", 
"https://fppchile.org/nada-fuera-del-estado/", 
"https://fppchile.org/patricio-aylwin-2/", 
"https://fppchile.org/el-futuro-de-la-seguridad-en-chile/", 
"https://fppchile.org/axel-kaiser-en-la-nacion-si-en-la-argentina-hubiera-libre-comercio-desaparece-inmediatamente-el-70-de-la-casta/", 
"https://fppchile.org/liberemos-la-educacion/", 
"https://fppchile.org/publican-ensayos-de-jorge-millas-sobre-la-violencia/", 
"https://fppchile.org/jefe-de-fpp-los-rios-marcos-balmaceda-fue-seleccionado-en-el-programa-de-posgrado-idea/", 
"https://fppchile.org/editorial-revista-atomo-n-3/", 
"https://fppchile.org/coronavirus-rescatar-la-economia-o-transformarla/", 
"https://fppchile.org/la-razon-y-el-fantasma-de-la-tribu/", 
"https://fppchile.org/el-encanto-del-dragon-cual-es-la-estrategia-china-de-influencia-en-america-latina/", 
"https://fppchile.org/o-conmigo-o-en-mi-contra-identidad-malestar-politica/", 
"https://fppchile.org/la-etica-de-los-infelices/", 
"https://fppchile.org/para-que-ser-victimas-si-podemos-ser-libres/", 
"https://fppchile.org/el-avance-de-los-autoritarismos-y-la-democracia-en-retirada/", 
"https://fppchile.org/venezuela-los-pasos-a-la-servidumbre/", 
"https://fppchile.org/liberalismo-hacia-la-articulacion-de-una-estrategia-emocional/", 
"https://fppchile.org/fake-news-la-mentira-en-el-siglo-xxi/", 
"https://fppchile.org/la-identidad-contra-la-democracia/", 
"https://fppchile.org/de-que-hablamos-cuando-hablamos-de-incorreccion-politica/", 
"https://fppchile.org/la-presuncion-de-inocencia-frente-a-la-tirania-de-la-correccion-politica/", 
"https://fppchile.org/la-neolengua-como-herramienta-de-manipulacion-politica/", 
"https://fppchile.org/distopia-digital-cuatro-herramientas-que-china-usa-para-controlar-a-su-poblacion/", 
"https://fppchile.org/una-verdadera-feminista/", 
"https://fppchile.org/chile-un-buen-pais-para-ser-mujer/", 
"https://fppchile.org/lun-fernando-claro-la-lenta-reconstruccion-ha-delatado-la-inoperancia-estatal-en-su-maxima-expresion/", 
"https://fppchile.org/la-tercera-malo-y-apresurado-los-centros-de-estudios-de-derecha-se-dividen-ante-acuerdo-por-reforma-previsional/", 
"https://fppchile.org/axel-kaiser-en-la-tercera-mi-hermano-johannes-encarnaria-mejor-un-gobierno-libertario-que-matthei-y-que-kast/", 
"https://fppchile.org/axel-kaiser-el-ultimo-entrevistado-del-podcast-de-jordan-peterson/", 
"https://fppchile.org/kaiser-ante-candidatura-presidencial-antes-lo-descartaba-100-ahora-no-lo-descarto-100/", 
"https://fppchile.org/axel-kaiser-milei-ha-sabido-hacer-del-liberalismo-algo-sexy-y-atractivo-para-los-jovenes/", 
"https://fppchile.org/milei-no-es-loco-ni-bobo-es-brillante/", 
"https://fppchile.org/los-40-minutos-de-kaiser-a-solas-con-milei-no-me-cabe-duda-de-que-argentina-sera-otro-pais-despues-de-su-gobierno/", 
"https://fppchile.org/el-provocador-y-disruptivo-libro-de-axel-kaiser-y-rainer-zitelmann/", 
"https://fppchile.org/axel-kaiser-el-odio-a-los-ricos-esta-en-el-centro-del-estancamiento-economico-en-chile/", 
"https://fppchile.org/el-odio-a-los-ricos-el-provocador-libro-que-axel-kaiser-lanzara-a-fines-de-este-mes/", 
"https://fppchile.org/a-favor-de-la-corriente/", 
"https://fppchile.org/dato-de-la-semana-aunque-se-ha-debilitado-en-la-ultima-decada-chile-continua-siendo-el-pais-con-mas-libertad-economica-en-sudamerica/", 
"https://fppchile.org/editorial-revista-atomo-n-3/", 
"https://fppchile.org/decalogo-del-feminismo-liberal/", 
"https://fppchile.org/el-mito-del-banco-central-autonomo/", 
"https://fppchile.org/coronavirus-rescatar-la-economia-o-transformarla/", 
"https://fppchile.org/la-razon-y-el-fantasma-de-la-tribu/", 
"https://fppchile.org/el-encanto-del-dragon-cual-es-la-estrategia-china-de-influencia-en-america-latina/", 
"https://fppchile.org/o-conmigo-o-en-mi-contra-identidad-malestar-politica/", 
"https://fppchile.org/la-etica-de-los-infelices/", 
"https://fppchile.org/para-que-ser-victimas-si-podemos-ser-libres/", 
"https://fppchile.org/el-avance-de-los-autoritarismos-y-la-democracia-en-retirada/", 
"https://fppchile.org/venezuela-los-pasos-a-la-servidumbre/", 
"https://fppchile.org/liberalismo-hacia-la-articulacion-de-una-estrategia-emocional/", 
"https://fppchile.org/fake-news-la-mentira-en-el-siglo-xxi/", 
"https://fppchile.org/la-identidad-contra-la-democracia/", 
"https://fppchile.org/de-que-hablamos-cuando-hablamos-de-incorreccion-politica/", 
"https://fppchile.org/la-presuncion-de-inocencia-frente-a-la-tirania-de-la-correccion-politica/", 
"https://fppchile.org/la-neolengua-como-herramienta-de-manipulacion-politica/", 
"https://fppchile.org/distopia-digital-cuatro-herramientas-que-china-usa-para-controlar-a-su-poblacion/", 
"https://fppchile.org/una-verdadera-feminista/", 
"https://fppchile.org/chile-un-buen-pais-para-ser-mujer/", 
"https://fppchile.org/gonzalo-sanhueza-hoy-el-banco-central-tiene-un-espacio-para-ser-mas-agresivo-en-bajar-la-tasa-de-interes/", 
"https://fppchile.org/fernando-claro-en-la-segunda-del-informe-del-pnud-no-se-puede-concluir-que-chile-quiera-transformaciones-profundas/", 
"https://fppchile.org/axel-kaiser-en-entrevista-en-llego-la-hora-de-radio-agricultura/", 
"https://fppchile.org/entrevista-de-terapia-chilensis-a-nuestro-director-ejecutivo-fernando-claro/", 
"https://fppchile.org/ariel-ruiz-urquiola-activista-cientifico-y-disidente-cubano/", 
"https://fppchile.org/axel-kaiser-director-ejecutivo-de-la-fundacion-para-el-progreso-logramos-despegarnos-por-30-anos-de-america-latina-y-ahora-volvemos-a-ser-un-pais-mediocre-conflictivo-y-populista/"
"https://fppchile.org/entrevista-a-axel-kaiser-la-dc-si-fuera-consecuente-con-sus-principios-deberia-abandonar-el-gobierno-y-pasar-a-la-oposicion/", 

]

def obtener_fecha_publicacion(url):
    """Obtiene la fecha de publicación desde el meta tag del HTML."""
    headers = {
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.36"
    }
    
    try:
        response = requests.get(url, headers=headers, timeout=10)
        response.raise_for_status()
        
        soup = BeautifulSoup(response.text, 'html.parser')
        meta_tag = soup.find("meta", {"property": "article:published_time"})
        
        if meta_tag and meta_tag.get("content"):
            return meta_tag["content"]
        else:
            return "Fecha no encontrada"
    
    except requests.RequestException as e:
        return f"Error: {e}"

# Procesar todas las URLs con una barra de progreso
resultados = {}
for url in tqdm(urls, desc="Extrayendo fechas"):
    fecha = obtener_fecha_publicacion(url)
    resultados[url] = fecha
    time.sleep(1)  # Evita sobrecargar el servidor

# Mostrar resultados
for url, fecha in resultados.items():
    print(f"{url} -> {fecha}")

    # Crear un DataFrame con los resultados
    df = pd.DataFrame(list(resultados.items()), columns=["URL", "Fecha de Publicación"])

    # Exportar a un archivo Excel
    df.to_excel("fechas_publicacion.xlsx", index=False)

    print("Fechas de publicación exportadas a fechas_publicacion.xlsx")
