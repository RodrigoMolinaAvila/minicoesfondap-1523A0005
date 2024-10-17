import pandas as pd
import os

# Cargar el archivo CSV con los datos extraídos
df = pd.read_csv('C:/Users/Rodrigo/Desktop/MiniCOES/minicoesfondap-1523A0005/Webscraping/Derecha/Transversales/Libertad y Desarrollo/data/raw/lyd_noticias_completas.csv')

# 1. Eliminar duplicados
df_limpio = df.drop_duplicates()

# 2. Revisión de valores faltantes (NaN)
valores_faltantes = df_limpio.isnull().sum()
print("Valores faltantes por columna:")
print(valores_faltantes)

# También podemos visualizar el porcentaje de valores faltantes por columna
porcentaje_faltantes = df_limpio.isnull().mean() * 100
print("\nPorcentaje de valores faltantes por columna:")
print(porcentaje_faltantes)

# 3. Eliminar filas con valores faltantes en columnas críticas
columnas_criticas = ['Fecha', 'Autor', 'Nombre de la noticia', 'Corpus']
df_limpio = df_limpio.dropna(subset=columnas_criticas)

# 4. Convertir la columna 'Fecha' al formato datetime
# Suponiendo que la fecha está en el formato '30 septiembre 2024'
meses = {
    'enero': '01', 'febrero': '02', 'marzo': '03', 'abril': '04', 
    'mayo': '05', 'junio': '06', 'julio': '07', 'agosto': '08', 
    'septiembre': '09', 'octubre': '10', 'noviembre': '11', 'diciembre': '12'
}

# Función para convertir las fechas con meses en español
def convertir_fecha(fecha_str):
    try:
        dia, mes, año = fecha_str.split()
        mes_numero = meses[mes.lower()]
        return pd.to_datetime(f"{año}-{mes_numero}-{dia}")
    except Exception as e:
        return pd.NaT  # Devuelve NaT si hay algún error en la conversión

# Aplicar la función para convertir la columna de fechas
df_limpio['Fecha'] = df_limpio['Fecha'].apply(convertir_fecha)

# Crear la carpeta de destino si no existe
output_dir = 'C:/Users/Rodrigo/Desktop/MiniCOES/minicoesfondap-1523A0005/Webscraping/Derecha/Transversales/Libertad y Desarrollo/data/cleaned'
os.makedirs(output_dir, exist_ok=True)

# 5. Guardar el DataFrame limpio en un archivo CSV
csv_output_path = os.path.join(output_dir, 'lyd_noticias_limpias.csv')
df_limpio.to_csv(csv_output_path, index=False, encoding='utf-8')
print(f"Datos limpios guardados en '{csv_output_path}'.")

# 6. Guardar el DataFrame limpio en un archivo Excel
excel_output_path = os.path.join(output_dir, 'lyd_noticias_limpias.xlsx')
df_limpio.to_excel(excel_output_path, index=False, engine='openpyxl')
print(f"Datos limpios guardados en '{excel_output_path}'.")
