import requests
from bs4 import BeautifulSoup
import pandas as pd
import os
import re
from datetime import datetime

# Definir las URLs base
base_url = "https://lyd.org/category/estudios/informes-economicos/page/"
page_limit = 12  # Número máximo de páginas a recorrer en Informes Económicos

# Lista para almacenar los datos
data = []

# Función para convertir la fecha en formato adecuado
def procesar_fecha(fecha_str):
    try:
        # Separar los valores de la fecha "dd MMM | yy"
        dia, mes_abbr, year = fecha_str.replace('|', '').split()
        # Crear una fecha en formato completo
        meses = {'Ene': '01', 'Feb': '02', 'Mar': '03', 'Abr': '04', 'May': '05', 'Jun': '06',
                 'Jul': '07', 'Ago': '08', 'Sep': '09', 'Oct': '10', 'Nov': '11', 'Dic': '12'}
        mes = meses[mes_abbr]  # Convertir el mes abreviado a número
        year = '20' + year  # Convertir el año corto a completo (asumimos que estamos en 20xx)
        return f"{year}-{mes}-{dia.zfill(2)}"  # Devolver la fecha en formato YYYY-MM-DD
    except Exception as e:
        print(f"Error procesando la fecha: {fecha_str} - {str(e)}")
        return 'Fecha no encontrada'

# Iterar sobre cada página de 1 a page_limit
for page in range(1, page_limit + 1):
    url = f"{base_url}{page}/"

    # Realizar la solicitud HTTP a la página
    response = requests.get(url)

    # Verificar si la solicitud fue exitosa
    if response.status_code == 200:
        # Crear el objeto BeautifulSoup para analizar el contenido HTML
        soup = BeautifulSoup(response.content, 'html.parser')

        # Encontrar todos los divs que contienen los informes relevantes
        articles = soup.select('div.elementor-widget-wrap.elementor-element-populated')

        # Iterar sobre cada artículo y extraer la información de informes válidos
        for article in articles:
            try:
                # Fecha de publicación
                fecha = article.select_one('span.elementor-post-info__item--type-date time').text.strip()
                fecha = procesar_fecha(fecha)  # Procesar la fecha en formato adecuado
            except AttributeError:
                fecha = 'No encontrado'
            
            try:
                # Título del informe
                titulo = article.select_one('h1.elementor-heading-title').text.strip()
            except AttributeError:
                titulo = 'No encontrado'
            
            try:
                # Enlace del informe (PDF)
                enlace = article.select_one('a.whq-custom-element--button-file__button')['href']
            except (AttributeError, TypeError):
                enlace = 'No encontrado'
            
            try:
                # Etiquetas del informe
                etiquetas = ', '.join([tag.text.strip() for tag in article.select('span.elementor-post-info__terms-list-item')])
            except AttributeError:
                etiquetas = 'No encontrado'

            # Agregar los datos a la lista sólo si tienen un enlace válido
            if enlace != 'No encontrado' and titulo != 'No encontrado':
                data.append({
                    'Fecha': fecha,
                    'Título': titulo,
                    'Etiquetas': etiquetas,
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
output_path = os.path.join(output_dir, 'lyd_informes_economicos.csv')
df.to_csv(output_path, index=False, encoding='utf-8')

print(f"Scraping completado y datos guardados en '{output_path}'.")
