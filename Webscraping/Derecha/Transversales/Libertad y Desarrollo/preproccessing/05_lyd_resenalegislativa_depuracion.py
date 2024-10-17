import pandas as pd
import os

# Ruta del archivo CSV sin procesar
input_path = r'C:\Users\rodri\OneDrive\Escritorio\Git MiniCoes\minicoesfondap-1523A0005\Webscraping\Libertad y Desarrollo\data\raw\lyd_resena_legislativa.csv'

# Ruta para guardar el archivo limpio
output_dir = r'C:\Users\rodri\OneDrive\Escritorio\Git MiniCoes\minicoesfondap-1523A0005\Webscraping\Libertad y Desarrollo\data\cleaned'
os.makedirs(output_dir, exist_ok=True)

# Cargar el archivo CSV sin procesar
df = pd.read_csv(input_path)

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

# 3. Eliminar filas con valores faltantes en columnas críticas (Título y Enlace)
# Si decides que columnas como "Título" y "Enlace" son críticas,
# puedes eliminar las filas que tengan valores faltantes en esas columnas:
columnas_criticas = ['Título', 'Enlace']
df_limpio = df_limpio.dropna(subset=columnas_criticas)

# 4. Guardar el DataFrame limpio en un archivo CSV
csv_output_path = os.path.join(output_dir, 'lyd_resena_legislativa_limpio.csv')
df_limpio.to_csv(csv_output_path, index=False, encoding='utf-8')
print(f"Datos limpios guardados en '{csv_output_path}'.")

# 5. Guardar el DataFrame limpio en un archivo Excel
excel_output_path = os.path.join(output_dir, 'lyd_resena_legislativa_limpio.xlsx')
df_limpio.to_excel(excel_output_path, index=False, engine='openpyxl')
print(f"Datos limpios guardados en '{excel_output_path}'.")
