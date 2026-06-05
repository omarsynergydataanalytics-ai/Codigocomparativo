# Scripts OBT (One Big Table) - Cobeca Lakehouse

Este directorio contiene scripts para crear un OBT (One Big Table) a partir de las bases de datos APS utilizando los joins especificados.

## 📋 Archivos creados

### 1. `obt_creacion.py`
**Enfoque**: Extrae cada tabla por separado y hace los joins en Python usando pandas.

**Ventajas**:
- Más control sobre cada paso del proceso
- Fácil de depurar
- Permite guardar datos intermedios

**Salidas**:
- `obt_completo.csv` - OBT completo con todos los joins
- `ventas_completo.csv` - Módulo de ventas
- `compras_completo.csv` - Módulo de compras
- `inventario_completo.csv` - Módulo de inventario

### 2. `obt_creacion_sql.py`
**Enfoque**: Realiza los joins directamente en SQL Server, más eficiente para grandes volúmenes.

**Ventajas**:
- Más rápido para grandes datasets
- Menor uso de memoria en Python
- SQL Server optimiza los joins

**Salidas**:
- `obt_completo_unificado.csv` - OBT completo unificado
- `modulo_ventas.csv` - Módulo especializado de ventas
- `modulo_compras.csv` - Módulo especializado de compras
- `modulo_inventario.csv` - Módulo especializado de inventario
- `resumen_empresas.csv` - Resumen estadístico por empresa

## 🔗 Relaciones implementadas

Los scripts implementan los siguientes joins según las llaves especificadas:

```
Empresa.id = Ventas.id
Ventas.id = VentasDetalles.ventasid
Empresa.id = Compras.id
Compras.id = ComprasDetalles.comprasid
InvArticulos.id = InvArticuloFcia.InvArticuloid
Empresa.id = InvArticuloFcia.Empresaid
```

## ⚙️ Requisitos

### 1. Archivo `.env`
Debe existir un archivo `.env` con las siguientes variables:

```
SQL_SERVER=nombre_del_servidor
SQL_UID=usuario_sql
SQL_PWD=contraseña_sql
CONN_APS_PORT=puerto_aps
CONN_APS_DB=nombre_db_aps
```

### 2. Dependencias Python
Instalar las dependencias:

```bash
pip install pyodbc pandas python-dotenv
```

## 🚀 Ejecución

### Opción 1: Usar pandas para joins (más control)
```bash
python obt_creacion.py
```

### Opción 2: Usar SQL para joins (más eficiente)
```bash
python obt_creacion_sql.py
```

## 📊 Estructura del OBT resultante

El OBT contendrá información de:

### 1. **Empresa** (tabla base)
- Información básica de la empresa
- Datos de contacto y ubicación

### 2. **Ventas**
- Cabeceras de ventas
- Detalles por producto vendido
- Totales y subtotales

### 3. **Compras**
- Cabeceras de compras
- Detalles por producto comprado
- Información de proveedores

### 4. **Inventario**
- Maestro de artículos
- Stock por farmacia
- Niveles mínimo/máximo
- Ubicaciones

## 🔍 Análisis disponible

Los scripts generan métricas de:
- **Cobertura**: Porcentaje de empresas con datos en cada módulo
- **Estadísticas**: Totales de ventas, compras e inventario
- **Resumen**: Dashboard empresarial consolidado

## ⚠️ Consideraciones

### Rendimiento
- Para datasets pequeños (< 100k registros): Usar `obt_creacion.py`
- Para datasets grandes (> 100k registros): Usar `obt_creacion_sql.py`

### Memoria
- El script pandas puede consumir mucha RAM si las tablas son muy grandes
- El script SQL es más eficiente en memoria ya que el join se hace en la BD

### Columnas
- Los nombres de columnas pueden variar según la estructura real de la BD
- Si hay errores de columna, verificar los nombres exactos en el DDL

## 📈 Posibles extensiones

1. **Agregar filtros por fecha**: Para limitar el rango temporal
2. **Incluir más tablas**: Como CENDIS, Clientes, etc.
3. **Exportar a Parquet**: Para mejor compresión y compatibilidad
4. **Subir a S3**: Integración con el pipeline existente de v14
5. **Generar reportes automáticos**: Con visualizaciones básicas

## 🛠️ Solución de problemas

### Error: "No se puede conectar a la base de datos"
1. Verificar que el archivo `.env` existe y tiene las variables correctas
2. Confirmar que el servidor SQL está accesible
3. Verificar permisos del usuario

### Error: "Columna no encontrada"
1. Revisar los nombres exactos de las tablas y columnas en el DDL
2. Actualizar los nombres en los scripts según corresponda
3. Verificar que las tablas existen en la base de datos

### Error: "MemoryError" o rendimiento lento
1. Usar `obt_creacion_sql.py` en lugar de `obt_creacion.py`
2. Agregar filtros para limitar los datos
3. Procesar en lotes si es necesario

## 📞 Soporte

Para problemas o preguntas, revisar:
1. El archivo DDL `ddl/obt_schema.sql` para verificar nombres de tablas/columnas
2. El script `v14` para ver la configuración de conexión original
3. Los logs de ejecución para identificar errores específicos