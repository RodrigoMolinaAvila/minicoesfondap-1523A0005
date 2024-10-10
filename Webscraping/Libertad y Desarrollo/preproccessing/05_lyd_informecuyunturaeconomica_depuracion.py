import pandas as pd
import os

# Definir la ruta del archivo CSV de entrada
input_file = r'C:\Users\rodri\OneDrive\Escritorio\Git MiniCoes\minicoesfondap-1523A0005\Webscraping\Libertad y Desarrollo\data\raw\lyd_informes_economicos.csv'

# Definir la ruta del archivo CSV y Excel de salida
output_dir = r'C:\Users\rodri\OneDrive\Escritorio\Git MiniCoes\minicoesfondap-1523A0005\Webscraping\Libertad y Desarrollo\data\cleaned'
os.makedirs(output_dir, exist_ok=True)
output_csv = os.path.join(output_dir, 'lyd_informes_economicos_limpio.csv')
output_excel = os.path.join(output_dir, 'lyd_informes_economicos_limpio.xlsx')

# Cargar los datos desde el archivo CSV
df = pd.read_csv(input_file)

# 1. Eliminar duplicados
df_limpio = df.drop_duplicates()

# 2. Revisión de valores faltantes (NaN)
# Comprobar cuántos valores faltan en cada columna
valores_faltantes = df_limpio.isnull().sum()
print("Valores faltantes por columna:")
print(valores_faltantes)

# También podemos visualizar el porcentaje de valores faltantes por columna
porcentaje_faltantes = df_limpio.isnull().mean() * 100
print("\nPorcentaje de valores faltantes por columna:")
print(porcentaje_faltantes)

# 3. Eliminar filas con valores faltantes en columnas críticas (Fecha, Título, Enlace)
columnas_criticas = ['Fecha', 'Título', 'Enlace']
df_limpio = df_limpio.dropna(subset=columnas_criticas)

# 4. Convertir la columna 'Fecha' a formato datetime (si aún no está)
df_limpio['Fecha'] = pd.to_datetime(df_limpio['Fecha'], errors='coerce')

# 5. Volver a eliminar cualquier duplicado basado en el enlace
df_limpio = df_limpio.drop_duplicates(subset=['Enlace'])

# 6. Guardar el DataFrame limpio en un archivo CSV
df_limpio.to_csv(output_csv, index=False, encoding='utf-8')
print(f"Datos limpios guardados en '{output_csv}'.")

# 7. Guardar el DataFrame limpio en un archivo Excel
df_limpio.to_excel(output_excel, index=False, engine='openpyxl')
print(f"Datos limpios guardados en '{output_excel}'.")
