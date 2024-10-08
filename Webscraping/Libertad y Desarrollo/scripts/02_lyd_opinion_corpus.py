import requests
from bs4 import BeautifulSoup
import pandas as pd
import os

# Leer el archivo CSV con los enlaces
df = pd.read_csv('Webscraping/Libertad y Desarrollo/data/raw/lyd_opiniones.csv')

# Lista para almacenar los datos de cada artículo
datos_completos = []

# Iterar sobre cada enlace en el archivo CSV
for index, row in df.iterrows():
    url = row['Enlace']
    
    # Realizar la solicitud HTTP a cada enlace
    response = requests.get(url)
    
    # Verificar si la solicitud fue exitosa
    if response.status_code == 200:
        # Crear el objeto BeautifulSoup para analizar el contenido HTML
        soup = BeautifulSoup(response.content, 'html.parser')

        # Extraer la fecha de la noticia
        try:
            fecha_noticia = soup.select_one('span.elementor-post-info__item--type-date time').text.strip()
        except AttributeError:
            fecha_noticia = 'No encontrado'
        
        # Extraer el autor
        try:
            autor_noticia = soup.select_one('span.elementor-post-info__terms-list a').text.strip()
        except AttributeError:
            autor_noticia = 'No encontrado'

        # Extraer el nombre de la noticia
        try:
            nombre_noticia = soup.select_one('h1.elementor-heading-title').text.strip()
        except AttributeError:
            nombre_noticia = 'No encontrado'
        
        # Extraer el medio de comunicación
        try:
            medio_comunicacion = soup.select_one('h2.elementor-heading-title').text.strip()
        except AttributeError:
            medio_comunicacion = 'No encontrado'

        # Extraer el contenido del artículo (corpus de la noticia)
        try:
            corpus = soup.select_one('div.elementor-widget-theme-post-content').text.strip()
        except AttributeError:
            corpus = 'No encontrado'
        
        # Añadir los datos extraídos a la lista
        datos_completos.append({
            'Fecha': fecha_noticia,
            'Autor': autor_noticia,
            'Nombre de la noticia': nombre_noticia,
            'Medio de comunicación': medio_comunicacion,
            'Enlace': url,
            'Corpus': corpus
        })

        print(f"Procesado: {url}")
    else:
        print(f"Error al acceder a {url}. Código de estado: {response.status_code}")

# Convertir la lista de datos en un DataFrame
df_completo = pd.DataFrame(datos_completos)

# Crear la carpeta de destino si no existe
output_dir = 'Webscraping/Libertad y Desarrollo/data/raw'
os.makedirs(output_dir, exist_ok=True)

# Guardar el DataFrame en un archivo CSV en la ruta correcta
output_path = os.path.join(output_dir, 'lyd_noticias_completas.csv')
df_completo.to_csv(output_path, index=False, encoding='utf-8')

print(f"Extracción completada y datos guardados en '{output_path}'.")
