import requests
from bs4 import BeautifulSoup
import pandas as pd
import os

# Definir las URLs base
base_url = "https://lyd.org/category/estudios/temas-publicos/page/"
page_limit = 46  # Número máximo de páginas a recorrer en Temas Públicos

# Lista para almacenar los datos
data = []

# Función para extraer la fecha desde el enlace
def obtener_fecha_desde_enlace(enlace):
    try:
        # Extraer el año y el mes desde el enlace
        partes = enlace.split('/')
        year = partes[-3]  # El año está en la penúltima posición
        month = partes[-2]  # El mes está justo después del año

        # Formatear la fecha como 'YYYY-MM-DD', asumiendo que el día es el 01
        fecha = f"{year}-{month}-01"
        return fecha
    except:
        return 'Fecha inválida'

# Iterar sobre cada página de 1 a page_limit
for page in range(1, page_limit + 1):
    url = f"{base_url}{page}/"

    # Realizar la solicitud HTTP a la página
    response = requests.get(url)

    # Verificar si la solicitud fue exitosa
    if response.status_code == 200:
        # Crear el objeto BeautifulSoup para analizar el contenido HTML
        soup = BeautifulSoup(response.content, 'html.parser')

        # Encontrar todos los divs que contienen los estudios relevantes
        articles = soup.select('div.elementor-widget-wrap.elementor-element-populated')

        # Iterar sobre cada artículo y extraer la información de estudios válidos
        for article in articles:
            try:
                # Título del estudio
                titulo = article.select_one('h1.elementor-heading-title').text.strip()
            except AttributeError:
                titulo = None
            
            try:
                # Enlace del estudio (PDF)
                enlace = article.select_one('a.whq-custom-element--button-file__button')['href']
                # Extraer la fecha desde el enlace
                fecha = obtener_fecha_desde_enlace(enlace)
            except (AttributeError, TypeError):
                enlace = None
                fecha = None
            
            try:
                # Etiquetas del estudio
                etiquetas = ', '.join([tag.text.strip() for tag in article.select('span.elementor-post-info__terms-list-item')])
            except AttributeError:
                etiquetas = None

            # Solo agregar a la lista si todos los campos contienen información válida
            if all([fecha, titulo, enlace, etiquetas]):
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
output_dir = r'C:\Users\Rodrigo\Desktop\MiniCOES\minicoesfondap-1523A0005\Webscraping\Derecha\Transversales\Libertad y Desarrollo\data\raw'
os.makedirs(output_dir, exist_ok=True)

# Guardar el DataFrame en un archivo CSV en la ruta correcta
output_path = os.path.join(output_dir, 'lyd_temas_publicos_filtrado.csv')
df.to_csv(output_path, index=False, encoding='utf-8')

print(f"Scraping completado y datos guardados en '{output_path}'.")
