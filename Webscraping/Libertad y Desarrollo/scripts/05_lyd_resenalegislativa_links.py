import requests
from bs4 import BeautifulSoup
import pandas as pd
import os
from datetime import datetime

# Mapeo de meses abreviados en español a números
meses = {
    'Ene': '01', 'Feb': '02', 'Mar': '03', 'Abr': '04', 'May': '05', 'Jun': '06',
    'Jul': '07', 'Ago': '08', 'Sep': '09', 'Oct': '10', 'Nov': '11', 'Dic': '12'
}

# Función para procesar la fecha en formato '24 Ene | 19'
def procesar_fecha(fecha_str):
    try:
        # Eliminar el símbolo "|"
        fecha_str = fecha_str.replace("|", "").strip()

        # Separar la fecha en día, mes, y año corto
        partes_fecha = fecha_str.split()

        # Asegurarnos de que haya exactamente 3 partes: día, mes, y año
        if len(partes_fecha) != 3:
            return 'Fecha inválida'

        dia, mes_abreviado, anio_corto = partes_fecha
        dia = dia.zfill(2)  # Asegurarnos de que el día tenga dos dígitos
        mes = meses.get(mes_abreviado, '00')  # Convertir el mes abreviado al número del mes

        # Asumir siglo correcto para el año
        anio = '20' + anio_corto if int(anio_corto) <= 50 else '19' + anio_corto

        return f'{anio}-{mes}-{dia}'
    except Exception as e:
        print(f"Error procesando la fecha: {fecha_str} - {e}")
        return 'Fecha inválida'

# Definir las URLs base
base_url = "https://lyd.org/category/estudios/resena-legislativa/page/"
page_limit = 23  # Número máximo de páginas a recorrer en Reseña Legislativa

# Lista para almacenar los datos
data = []

# Iterar sobre cada página de 1 a page_limit
for page in range(1, page_limit + 1):
    url = f"{base_url}{page}/"
    print(f"Procesando página: {url}")

    # Realizar la solicitud HTTP a la página
    response = requests.get(url)

    # Verificar si la solicitud fue exitosa
    if response.status_code == 200:
        # Crear el objeto BeautifulSoup para analizar el contenido HTML
        soup = BeautifulSoup(response.content, 'html.parser')

        # Encontrar todos los divs que contienen los estudios relevantes
        articles = soup.select('div.elementor-widget-wrap.elementor-element-populated')

        if not articles:
            print(f"No se encontraron artículos en la página {page}")
        
        # Iterar sobre cada artículo y extraer la información de estudios válidos
        for article in articles:
            try:
                # Extraer la fecha del artículo
                fecha_original = article.select_one('span.elementor-post-info__item--type-date time').text.strip()
                fecha_procesada = procesar_fecha(fecha_original)
            except AttributeError:
                fecha_procesada = 'No encontrado'

            try:
                # Título del estudio
                titulo = article.select_one('h1.elementor-heading-title').text.strip()
            except AttributeError:
                titulo = 'No encontrado'

            try:
                # Enlace del estudio (PDF)
                enlace = article.select_one('a.whq-custom-element--button-file__button')['href']
            except (AttributeError, TypeError):
                enlace = 'No encontrado'

            # Agregar los datos solo si el título y el enlace son válidos
            if titulo != 'No encontrado' and enlace != 'No encontrado':
                data.append({
                    'Fecha': fecha_procesada,
                    'Título': titulo,
                    'Enlace': enlace
                })

        print(f"Página {page} procesada correctamente.")
    else:
        print(f"Error al acceder a la página {page}. Código de estado: {response.status_code}")

# Convertir la lista de datos en un DataFrame
df = pd.DataFrame(data)

# Crear la carpeta de destino si no existe
output_dir = r'C:\Users\rodri\OneDrive\Escritorio\Git MiniCoes\minicoesfondap-1523A0005\Webscraping\Libertad y Desarrollo\data\raw'
os.makedirs(output_dir, exist_ok=True)

# Guardar el DataFrame en un archivo CSV en la ruta correcta
output_path = os.path.join(output_dir, 'lyd_resena_legislativa.csv')
df.to_csv(output_path, index=False, encoding='utf-8')

print(f"Scraping completado y datos guardados en '{output_path}'.")
