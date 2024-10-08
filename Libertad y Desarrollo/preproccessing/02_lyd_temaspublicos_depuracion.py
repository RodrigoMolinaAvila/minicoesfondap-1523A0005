import pandas as pd
import os

# Cargar el archivo CSV con los datos extraídos
input_path = 'Webscraping/Libertad y Desarrollo/data/raw/lyd_temas_publicos.csv'
df = pd.read_csv(input_path)

# 1. Contar los enlaces duplicados
duplicados = df[df.duplicated(subset=['Enlace'], keep=False)]  # Mantener todas las filas duplicadas
num_duplicados = duplicados.shape[0]
print(f"Se encontraron {num_duplicados} filas duplicadas basadas en el enlace.")

# Guardar el archivo de duplicados para revisión si es necesario
output_dir = 'Webscraping/Libertad y Desarrollo/data/outputs'
os.makedirs(output_dir, exist_ok=True)
duplicados_output_path = os.path.join(output_dir, 'lyd_temas_publicos_duplicados.csv')
duplicados.to_csv(duplicados_output_path, index=False, encoding='utf-8')
print(f"Datos duplicados guardados en '{duplicados_output_path}' para su revisión.")

# 2. Proceso de limpieza: eliminar duplicados, priorizando las filas con etiquetas
# Primero creamos una columna auxiliar para identificar si una fila tiene etiquetas o no
df['Tiene_Etiquetas'] = df['Etiquetas'].apply(lambda x: 0 if x == 'Sin etiquetas' else 1)

# Ordenar por enlace y por la columna 'Tiene_Etiquetas', de modo que las filas con etiquetas queden primero
df_sorted = df.sort_values(by=['Enlace', 'Tiene_Etiquetas'], ascending=[True, False])

# Eliminar duplicados basados en el enlace, manteniendo la primera ocurrencia (que será la que tiene etiquetas si existía)
df_clean = df_sorted.drop_duplicates(subset=['Enlace'], keep='first')

# Eliminar la columna temporal 'Tiene_Etiquetas'
df_clean = df_clean.drop(columns=['Tiene_Etiquetas'])

# 3. Guardar el DataFrame limpio en un archivo CSV
output_clean_dir = 'Webscraping/Libertad y Desarrollo/data/cleaned'
os.makedirs(output_clean_dir, exist_ok=True)
output_clean_path_csv = os.path.join(output_clean_dir, 'lyd_temas_publicos_limpio.csv')
df_clean.to_csv(output_clean_path_csv, index=False, encoding='utf-8')

# Guardar el DataFrame limpio en un archivo Excel
output_clean_path_excel = os.path.join(output_clean_dir, 'lyd_temas_publicos_limpio.xlsx')
df_clean.to_excel(output_clean_path_excel, index=False, engine='openpyxl')

print(f"Datos limpios guardados en:\n - {output_clean_path_csv}\n - {output_clean_path_excel}")
