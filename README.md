# **Proyecto ML: Predicción de Unidades Vendidas (OBT Farmacias)**

## 📌 **Resumen del Proyecto**

Este proyecto tiene como objetivo construir un modelo de **regresión** para predecir la cantidad de unidades vendidas (`unidades_vendidas`) en una cadena de farmacias. Se utiliza un enfoque de **modelado global** donde se entrena un único modelo sobre **todos los clientes y artículos juntos**, utilizando `empresa_id` como feature categórica para capturar patrones específicos por cliente.

---

## 📂 **Estructura del Proyecto**

```
/
├── AGENTS.md                # Guía para el agente de ML (este archivo)
├── OBT prem.csv             # Dataset principal (límite 1.5M filas)
├── pyobt.py                 # Script principal de procesamiento y modelado
├── ddl/
│   └── obt_schema.sql       # Esquema DDL de la OBT (obligatorio para revisar)
├── outputs/                 # Directorio para resultados y modelos
│   ├── shap_beeswarm.png    # Gráfico SHAP beeswarm del modelo ganador
│   ├── shap_bar.png         # Gráfico SHAP bar del modelo ganador
│   └── modelo_ganador.pkl   # Modelo serializado del mejor performante
└── resultados/
    └── comparativa.txt      # Tabla comparativa de métricas de los modelos
```

---

## 🎯 **Objetivo Principal**

Construir un modelo de regresión que **minimice el RMSE** (Root Mean Squared Error) para predecir `unidades_vendidas` usando las features disponibles en la OBT, siguiendo estrictas restricciones de negocio y de calidad de datos.

---

## 🧩 **Componentes Clave del Proyecto**

### 1. **Dataset (`OBT prem.csv`)**

- **Formato**: CSV
- **Filas máximas permitidas**: 1,500,000 (sin autorización adicional)
- **Carga estándar**:
  ```python
  df = pd.read_csv("OBT prem.csv", nrows=1_500_000)
  ```

### 2. **Esquema DDL (`ddl/obt_schema.sql`)**

- **Propósito**: Definición de la estructura de la OBT
- **Uso obligatorio**: Revisar antes de crear nuevas features o hacer joins
- **Tablas fuente**:
  - `Ventas` + `VentasDetalles` (transacciones de venta)
  - `Empresa` (datos de la farmacia)
  - `InvArticulos` (catálogo de artículos)
  - `InventarioFarmacia` (stock actual por farmacia)
  - `InventarioCENDIS` (stock en bodega central)

### 3. **Script Principal (`pyobt.py`)**

- **Funcionalidades**:
  - Carga y pre-procesamiento de datos
  - Feature engineering estándar
  - Codificación de variables categóricas con `LabelEncoder`
  - Split train/test (80/20)
  - Entrenamiento de modelos: XGBoost, Random Forest, Prophet, SVR
  - Grid Search con validación cruzada (`cv=3`)
  - Evaluación de métricas: RMSE, MAE, R²
  - Generación de gráficos SHAP para interpretabilidad
  - Guardado del modelo ganador con `joblib`

---

## 📊 **Métricas de Evaluación**

- **Métrica principal**: **RMSE** (Root Mean Squared Error)
- **Métricas secundarias**: MAE (Mean Absolute Error), R² (Coeficiente de determinación)

---

## 🔧 **Feature Engineering Estándar**

Aplicado siempre desde `fecha_venta` antes de dropearla:

```python
df["fecha_venta"] = pd.to_datetime(df["fecha_venta"])
df["semana"]      = df["fecha_venta"].dt.isocalendar().week.astype(int)
df["dia_mes"]     = df["fecha_venta"].dt.day
df["mes"]         = df["fecha_venta"].dt.month
df["anio"]        = df["fecha_venta"].dt.year
df["dia_semana"]  = df["fecha_venta"].dt.dayofweek
```

---

## 📈 **Modelos a Evaluar**

| Modelo                | Librería                  |
|-----------------------|---------------------------|
| XGBoost Regressor     | `xgboost`                 |
| Random Forest Regressor | `sklearn.ensemble`        |
| Prophet               | `prophet`                 |
| SVR                   | `sklearn.svm`             |

### Grid Search Parameters

#### XGBoost
```python
param_grid = {
    "n_estimators": [200, 300],
    "learning_rate": [0.05, 0.1],
    "max_depth": [4, 6],
    "subsample": [0.8],
    "colsample_bytree": [0.8],
}
```

#### Random Forest
```python
param_grid = {
    "n_estimators": [100, 200],
    "max_depth": [6, 10, None],
    "min_samples_split": [2, 5],
}
```

#### Prophet
```python
param_grid = {
    "changepoint_prior_scale": [0.01, 0.1, 0.5],
    "seasonality_prior_scale": [1.0, 10.0],
}
```

#### SVR
```python
param_grid = {
    "C": [0.1, 1, 10],
    "epsilon": [0.1, 0.5],
    "kernel": ["rbf"],
}
```

---

## 📊 **Interpretabilidad con SHAP**

Después de entrenar el modelo ganador:

```python
explainer   = shap.Explainer(modelo_ganador)
shap_values = explainer(X_test)
```

Se generan y guardan:
- `outputs/shap_beeswarm.png`
- `outputs/shap_bar.png`

---

## 📁 **Salidas del Proyecto**

### `outputs/`
- **`shap_beeswarm.png`**: Gráfico beeswarm de SHAP para interpretar la contribución de cada feature.
- **`shap_bar.png`**: Gráfico de barras de SHAP para ver la importancia global de las features.
- **`modelo_ganador.pkl`**: Modelo serializado del mejor performante, guardado con `joblib`.

### `resultados/`
- **`comparativa.txt`**: Tabla comparativa de métricas de todos los modelos probados, incluyendo:
  - RMSE
  - MAE
  - R²
  - Tiempo de entrenamiento

---

## ⚠️ **Restricciones y Reglas de Negocio**

### Columnas **EXCLUIDAS** (por razón de negocio o leakage)

#### Por **leakage** (derivan del target)
```python
leakage_cols = [
    "monto_total",
    "monto_sin_iva",
    "costo_total",
    "utilidad",
    "totalFactura",
    "totalImpuesto",
]
```

#### Por **texto libre sin valor predictivo**
```python
texto_libre_cols = [
    "nombre_farmacia",
    "descripcion_articulo",
    "descripcion_maestra",
    "nombreCliente",
    "identificacionCliente",
    "direccion",
    "nombre",
]
```

#### Por **decisión de negocio** (Borrar=True)
```python
borrar_cols = [
    "usuarioAuditor",
    "migrar",
    "loteFabricante",
    "loteEntrada",
    "Componentes",
    "CodigoProveedor",
    "Marca",
    "Presentacion",
    "Parroquia",
    "Telefonos",
    "ZonaPostal",
    "HorarioApertura",
    "HorarioCierre",
    "Email",
    "ServiciosPick",
    "ServiciosDelivery",
    "ramo",
    "smart",
    "segmentacio_cliente",
    "Rotacion",
    "MarcaId",
    "UnidadFraccionFarmacia",
    "Indexacion",
    "Consignacionmm",
]
```

#### Por **IDs o claves sin poder predictivo**
```python
id_cols = [
    "id_linea_venta", "id_venta", "num_documento",
    "id", "ventasId", "compraId", "InvArticuloIdFcia",
    "codigoBarra", "codigo",
]
```

### Otras restricciones importantes

- **No usar columnas de leakage bajo ninguna circunstancia**
- **No superar 1.5M filas sin autorización**
- **No usar OneHotEncoding en columnas de alta cardinalidad**
- **No intentar JOIN de Compras hasta que esté en el OBT**
- **No usar lat/lon para features geoespaciales por ahora**
- **Filtrar registros con `latitud=0` Y `longitud=0` simultáneamente**
- **Leer `/ddl/obt_schema.sql` antes de proponer features nuevas**
- **Reportar métricas completas antes de declarar ganador**
- **Guardar modelo ganador con `joblib` al finalizar**

---

## 🔄 **Flujo de Aprobación de Cambios**

El agente opera en **modo sugerencia**. Cualquier cambio al código, features, parámetros o pipeline **requiere confirmación explícita del usuario**.

### Proceso obligatorio para cambios:

1. **Agente detecta oportunidad de mejora o el usuario lo solicita**
2. **Agente presenta la sugerencia con este formato:**
   ```
   ┌─────────────────────────────────────┐
   │ SUGERENCIA #N                       │
   │ Archivo: [nombre del archivo]       │
   │ Cambio:  [descripción en 1 línea]   │
   │                                     │
   │ ANTES:                              │
   │ [código actual]                     │
   │                                     │
   │ DESPUÉS:                            │
   │ [código propuesto]                  │
   │                                     │
   │ Razón: [por qué mejora el modelo]   │
   │ ¿Aplicar? → responde SÍ o NO        │
   └─────────────────────────────────────┘
   ```
3. **El usuario responde SÍ o NO**
4. **Si es SÍ → el agente aplica el cambio**
5. **Si es NO → el agente descarta y continúa**

> Si el usuario responde "sí a todas" o "aplica todo", el agente puede aplicar todas las sugerencias pendientes en esa sesión sin pedir confirmación individual.

---

## 📈 **Historial de Experimentos**

| Fecha | Modelo | RMSE | MAE | R² | Filas | Notas |
|-------|--------|------|-----|----|-------|-------|
| — | XGBoost baseline | — | — | — | 500k | Sin grid search, versión inicial |

> **Actualizar esta tabla después de cada experimento completado.**

---

## 🚀 **Cómo Ejecutar el Proyecto**

### Requisitos

- **Python 3.8+**
- **Librerías necesarias**:
  ```bash
  pip install pandas numpy scikit-learn xgboost prophet shap joblib
  ```

### Pasos para ejecutar

1. **Clona el repositorio o descarga los archivos**
2. **Asegúrate de tener el archivo `OBT prem.csv` en la raíz del proyecto**
3. **Ejecuta el script principal**:
   ```powershell
   python pyobt.py
