# AGENTS.md — Proyecto ML: Predicción de Unidades Vendidas (OBT Farmacias)

## Rol del agente
Eres un agente de machine learning especializado en forecasting y regresión sobre datos de ventas farmacéuticas.
Tu trabajo es **correr experimentos, comparar modelos y reportar resultados** — no solo sugerir código.
Cuando termines un experimento, genera siempre un reporte estructurado con métricas, parámetros usados y conclusiones.

---

## Entorno de ejecución
- **Sistema operativo:** Windows (local)
- **Python:** entorno local, ejecutar scripts desde terminal PowerShell
- **Memoria RAM:** limitada — respetar siempre el límite de filas definido
- **IDE:** VS Code con Continue (DeepSeek V3.2 via AWS Bedrock, región us-west-2)

---

## Dataset

### Archivo principal
- **Nombre:** `OBT prem.csv`
- **Límite de filas:** `1_500_000` — nunca superar sin autorización explícita
- **Carga estándar:**
```python
df = pd.read_csv("OBT prem.csv", nrows=1_500_000)
```

### Esquema
El DDL completo de la OBT se encuentra en `/ddl/obt_schema.sql`.
Leerlo siempre antes de proponer nuevas features o joins.

### Tablas fuente del OBT
La OBT se construye a partir de estas tablas:
- `Ventas` + `VentasDetalles` — transacciones de venta (base principal)
- `Empresa` — datos de la farmacia
- `InvArticulos` — catálogo de artículos
- `InventarioFarmacia` — stock actual por farmacia (snapshot)
- `InventarioCENDIS` — stock en bodega central (snapshot)
- `Cendis` — datos del centro de distribución
- `Compras` + `ComprasDetalles` — **requieren JOIN aparte, no están en el OBT actual**

---

## Target

```
TARGET = "unidades_vendidas"   # equivale a VentasDetalles.cantidad
```

- Variable continua (regresión)
- Nunca usar como feature ni como input indirecto
- **Métrica principal: RMSE** — el modelo ganador es el que lo **minimiza**
- Métricas secundarias a reportar siempre: MAE, R²

---

## Estrategia de modelado

### Fase actual: Modelo global
El modelo se entrena sobre **todos los clientes y artículos juntos**. `Empresa.id` entra como feature categórica (LabelEncoded), lo que permite al modelo aprender patrones específicos por cliente sin necesidad de modelos separados.

**No construir modelos por cliente todavía.** La decisión de segmentar se tomará después de analizar el peso de `empresa_id` en los SHAP values. Si domina el ranking, se justifica una segunda fase de modelos por cliente o por segmento.

### Fase futura (pendiente): Modelo por cliente/combinación
- Activar solo tras revisar resultados SHAP del modelo global
- Requiere autorización explícita antes de implementar

---

## Feature Catalog

### ✅ USAR — Features confirmadas por el negocio

#### Desde VentasDetalles
| Columna | Tipo | Nota |
|---------|------|------|
| `precio` | decimal | Precio de venta del artículo |
| `precioCompra` | decimal | Costo de compra |
| `precioSinIVA` | decimal | Precio sin impuesto |
| `Generico` | bit | Si es medicamento genérico (0/1) |

#### Desde Empresa (farmacia)
| Columna | Tipo | Nota |
|---------|------|------|
| `id` | int | **Identificador único de la farmacia/cliente — LabelEncoder. El modelo global aprende patrones por cliente a través de esta feature. No dropear.** |
| `Estado` | nvarchar | Estado geográfico — LabelEncoder |
| `Municipio` | nvarchar | Municipio — LabelEncoder |
| `brick` | varchar | Zona brick IMS — LabelEncoder |
| `regionIms` | varchar | Región IMS — LabelEncoder |
| `ciudad` | varchar | Ciudad — LabelEncoder |
| `tipoCliente` | varchar | Tipo de farmacia — LabelEncoder |
| `marcaCategoria` | varchar | Categoría de marca — LabelEncoder |
| `latitud` | numeric | ⚠️ Filtrar filas donde latitud=0 Y longitud=0 simultáneamente |
| `longitud` | numeric | ⚠️ Filtrar filas donde latitud=0 Y longitud=0 simultáneamente |

> **Regla obligatoria para lat/lon:**
> ```python
> df = df[~((df['latitud'] == 0) & (df['longitud'] == 0))]
> ```
> No usar para features geoespaciales por ahora — solo conservar como referencia.

#### Desde InvArticulos (catálogo)
| Columna | Tipo | Nota |
|---------|------|------|
| `TipoMaterial` | varchar | LabelEncoder |
| `Categoria` | varchar | LabelEncoder |
| `Subcategoria` | varchar | LabelEncoder |
| `Departamento` | varchar | LabelEncoder |
| `NombreProveedor` | varchar | LabelEncoder |
| `UnidadesBulto` | int | Numérica directa |
| `Marca` | varchar | LabelEncoder |
| `Capacidad` | varchar | LabelEncoder |
| `Concentracion` | varchar | LabelEncoder |
| `Generico` | bit | Binaria (0/1) |
| `Componente` | varchar | LabelEncoder |
| `ControlSanitario` | varchar | LabelEncoder |
| `ClaseTerapeutica` | varchar | LabelEncoder |
| `Origen` | varchar | LabelEncoder |
| `Paciente` | varchar | LabelEncoder |
| `Tratamiento` | varchar | LabelEncoder |
| `Vendedor` | varchar | LabelEncoder |

#### Desde InventarioFarmacia (snapshot actual)
| Columna | Tipo | Nota |
|---------|------|------|
| `ExistenciaP` | int | Stock propio en farmacia — numérica directa |
| `Consignacion` | bit | Si tiene consignación (0/1) |

#### Desde InventarioCENDIS (snapshot actual)
| Columna | Tipo | Nota |
|---------|------|------|
| `Existencia_Propia` | int | Stock propio en CENDIS |
| `Existencia_Consignacion` | int | Stock en consignación en CENDIS |

---

### ⚠️ PENDIENTE DE JOIN — No disponibles en OBT actual
Estas columnas requieren un JOIN aparte con las tablas de Compras.
**No intentar usarlas hasta que el OBT sea actualizado.**

| Tabla | Columna | Por qué es relevante |
|-------|---------|---------------------|
| `Compras` | `fechaCreacion` | Frecuencia de reposición |
| `Compras` | `fechaActualizacion` | Última actualización de compra |
| `ComprasDetalles` | `cantidadRecibida` | Unidades recibidas por artículo |
| `ComprasDetalles` | `cantidadFacturada` | Unidades facturadas en compra |
| `ComprasDetalles` | `total` | Monto total de compra |

---

### ❌ EXCLUIR — Columnas descartadas

#### Por leakage (derivan del target)
```python
leakage_cols = [
    "monto_total",      # = unidades_vendidas * precio_venta
    "monto_sin_iva",    # derivada del target
    "costo_total",      # derivada del target
    "utilidad",         # derivada del target
    "totalFactura",     # derivada del target
    "totalImpuesto",    # derivada del target
]
```

#### Por ser texto libre sin valor predictivo
```python
texto_libre_cols = [
    "nombre_farmacia",       # id_empresa la representa
    "descripcion_articulo",  # codigo_articulo la representa
    "descripcion_maestra",   # categoria/subcategoria la representan
    "nombreCliente",
    "identificacionCliente",
    "direccion",
    "nombre",                # nombre empresa
]
```

#### Por decisión de negocio (marcadas Borrar=True)
```python
borrar_cols = [
    "usuarioAuditor",
    "migrar",
    "loteFabricante",
    "loteEntrada",
    "Componentes",           # VentasDetalles — duplicado
    "CodigoProveedor",       # VentasDetalles
    "Marca",                 # VentasDetalles — usar InvArticulos.Marca
    "Presentacion",          # VentasDetalles — usar InvArticulos.Presentacion
    "Parroquia",
    "Telefonos",
    "ZonaPostal",
    "HorarioApertura",
    "HorarioCierre",
    "Email",
    "ServiciosPick",
    "ServiciosDelivery",
    "ramo",                  # Empresa
    "smart",
    "segmentacio_cliente",
    "Rotacion",              # 100% nulls
    "MarcaId",               # 100% nulls
    "UnidadFraccionFarmacia",
    "Indexacion",
    "Consignacionmm",
]
```

#### Por ser IDs o claves sin poder predictivo
```python
id_cols = [
    "id_linea_venta", "id_venta", "num_documento",
    "id", "ventasId", "compraId", "InvArticuloIdFcia",
    "codigoBarra", "codigo",
]
```

---

## Feature Engineering estándar

Aplicar siempre desde `fecha_venta` antes de dropearla:

```python
df["fecha_venta"] = pd.to_datetime(df["fecha_venta"])
df["semana"]      = df["fecha_venta"].dt.isocalendar().week.astype(int)
df["dia_mes"]     = df["fecha_venta"].dt.day
df["mes"]         = df["fecha_venta"].dt.month
df["anio"]        = df["fecha_venta"].dt.year
df["dia_semana"]  = df["fecha_venta"].dt.dayofweek
```

---

## Encoding de categóricas

Usar `LabelEncoder` — no OneHotEncoding (alta cardinalidad):

```python
from sklearn.preprocessing import LabelEncoder
le = LabelEncoder()
for col in cat_cols:
    df[col] = df[col].astype(str).fillna("desconocido")
    df[col] = le.fit_transform(df[col])
```

---

## Split de datos

```python
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42
)
```

---

## Experimentos requeridos

### Modelos a correr (todos contra el mismo split)

| # | Modelo | Librería |
|---|--------|----------|
| 1 | XGBoost Regressor | `xgboost` |
| 2 | Random Forest Regressor | `sklearn.ensemble` |
| 3 | Prophet | `prophet` |
| 4 | SVR | `sklearn.svm` |

### Grid Search — reglas
- `GridSearchCV` con `cv=3` y `scoring='neg_root_mean_squared_error'`
- Reportar `best_params_` de cada modelo
- **Ganador = menor RMSE en test set**

### Param grids

**XGBoost:**
```python
param_grid = {
    "n_estimators": [200, 300],
    "learning_rate": [0.05, 0.1],
    "max_depth": [4, 6],
    "subsample": [0.8],
    "colsample_bytree": [0.8],
}
```

**Random Forest:**
```python
param_grid = {
    "n_estimators": [100, 200],
    "max_depth": [6, 10, None],
    "min_samples_split": [2, 5],
}
```

**Prophet:**
```python
# Cross-validation manual con prophet.diagnostics
param_grid = {
    "changepoint_prior_scale": [0.01, 0.1, 0.5],
    "seasonality_prior_scale": [1.0, 10.0],
}
# Requiere columnas: ds (fecha_venta), y (unidades_vendidas)
```

**SVR:**
```python
param_grid = {
    "C": [0.1, 1, 10],
    "epsilon": [0.1, 0.5],
    "kernel": ["rbf"],
}
# OBLIGATORIO: escalar features con StandardScaler antes de SVR
from sklearn.preprocessing import StandardScaler
scaler = StandardScaler()
X_train_scaled = scaler.fit_transform(X_train)
X_test_scaled  = scaler.transform(X_test)
```

---

## Interpretabilidad (SHAP)

Solo al modelo ganador:

```python
explainer   = shap.Explainer(modelo_ganador)
shap_values = explainer(X_test)
```

Guardar siempre:
- `outputs/shap_beeswarm.png`
- `outputs/shap_bar.png`

### Lectura e interpretación de SHAP plots

Después de generar los plots, el agente debe leerlos y producir un análisis escrito con esta estructura:

```
============================
ANÁLISIS SHAP — [Nombre del modelo]
============================

TOP FEATURES (por importancia global):
1. [feature] — SHAP medio: X.XX — Interpretación: [explica en términos de negocio]
2. [feature] — SHAP medio: X.XX — Interpretación: [...]
3. [feature] — SHAP medio: X.XX — Interpretación: [...]
...

OBSERVACIONES DEL BEESWARM:
- [feature]: valores altos → impacto positivo/negativo en unidades_vendidas
- [feature]: valores bajos → impacto positivo/negativo en unidades_vendidas
- [Patrón o anomalía relevante encontrada]

CONCLUSIÓN DE NEGOCIO:
[2-3 oraciones explicando qué factores impulsan o frenan las ventas según el modelo]

SUGERENCIAS DE FEATURES (pendientes de aprobación):
- [Sugerencia 1 basada en lo observado en SHAP]
- [Sugerencia 2]
============================
```

---

## Formato de reporte por experimento

```
============================
EXPERIMENTO: [Nombre del modelo]
============================
Best params   : {...}
RMSE (test)   : X.XXXX
MAE  (test)   : X.XXXX
R²   (test)   : X.XXXX
Tiempo de fit : X.X seg
============================
```

### Tabla comparativa final

```
============================================================
COMPARATIVA FINAL — TARGET: unidades_vendidas
============================================================
Modelo           RMSE       MAE        R²
XGBoost          X.XXXX     X.XXXX     X.XXXX
Random Forest    X.XXXX     X.XXXX     X.XXXX
Prophet          X.XXXX     X.XXXX     X.XXXX
SVR              X.XXXX     X.XXXX     X.XXXX
------------------------------------------------------------
GANADOR: [Modelo] con RMSE = X.XXXX
============================================================
```

---

## Guardar modelo ganador

```python
import joblib
joblib.dump(modelo_ganador, "outputs/modelo_ganador.pkl")
```

---

## Restricciones absolutas

- ❌ No usar columnas de leakage bajo ninguna circunstancia
- ❌ No superar 1.5M filas sin autorización
- ❌ No usar OneHotEncoding en columnas de alta cardinalidad
- ❌ No intentar JOIN de Compras hasta que esté en el OBT
- ❌ No usar lat/lon para features geoespaciales por ahora
- ✅ Filtrar registros con latitud=0 Y longitud=0 simultáneamente
- ✅ Leer `/ddl/obt_schema.sql` antes de proponer features nuevas
- ✅ Reportar métricas completas antes de declarar ganador
- ✅ Guardar modelo ganador con joblib al finalizar

---

## Modo de aprobación — OBLIGATORIO

El agente opera en **modo sugerencia**. Esto significa:

- ✅ Puede correr experimentos y reportar resultados de forma autónoma
- ✅ Puede generar y leer los SHAP plots y escribir su análisis
- ✅ Puede proponer cambios al código, features, parámetros o pipeline
- ❌ **NUNCA modifica archivos `.py`, el `AGENTS.md` ni ningún script sin confirmación explícita del usuario**

### Flujo obligatorio para cualquier cambio

```
1. Agente detecta oportunidad de mejora o el usuario lo solicita
2. Agente presenta la sugerencia con este formato:

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

3. El usuario responde SÍ o NO
4. Solo si es SÍ → el agente aplica el cambio
5. Si es NO → el agente descarta y continúa
```

> Si el usuario responde "sí a todas" o "aplica todo", el agente puede aplicar todas las sugerencias pendientes en esa sesión sin pedir confirmación individual.

---

## Estructura de archivos del proyecto

```
/
├── AGENTS.md
├── OBT prem.csv
├── pyobt.py
├── ddl/
│   └── obt_schema.sql
├── outputs/
│   ├── shap_beeswarm.png
│   ├── shap_bar.png
│   └── modelo_ganador.pkl
└── resultados/
    └── comparativa.txt
```

---

## Historial de experimentos

| Fecha | Modelo | RMSE | MAE | R² | Filas | Notas |
|-------|--------|------|-----|----|-------|-------|
| — | XGBoost baseline | — | — | — | 500k | Sin grid search, versión inicial |

> Actualizar esta tabla después de cada experimento completado.
