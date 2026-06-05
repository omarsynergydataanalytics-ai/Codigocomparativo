# obt_creacion_sql.py — Versión corregida con conversión de tipo
import pyodbc
import os
import pandas as pd
from dotenv import load_dotenv

# Cargar variables de entorno
load_dotenv()

SQL_SERVER = os.getenv("SQL_SERVER")
SQL_UID    = os.getenv("SQL_UID")
SQL_PWD    = os.getenv("SQL_PWD")
CONN_APS_PORT = os.getenv("CONN_APS_PORT")
CONN_APS_DB   = os.getenv("CONN_APS_DB")

# Construir la cadena de conexión
conn_str = (
    f'DRIVER={{ODBC Driver 17 for SQL Server}};'
    f'SERVER={SQL_SERVER},{CONN_APS_PORT};'
    f'DATABASE={CONN_APS_DB};'
    f'UID={SQL_UID};'
    f'PWD={SQL_PWD};'
    'TrustServerCertificate=yes;'
)

try:
    # Conectar a la base de datos
    conn = pyodbc.connect(conn_str)
    print("✅ Conexión exitosa a la base de datos APS")

    # ---------------------------
    # 1️⃣ Consulta: Tabla Empresa
    # ---------------------------
    query_empresa = """
    SELECT TOP 10000  
        id,
        nombre,
        Estado,
        Municipio,
        brick,
        regionIms,
        ciudad,
        tipoCliente,
        marcaCategoria,
        latitud,
        longitud
    FROM Empresa
    WHERE NOT (latitud = 0 AND longitud = 0)
    ORDER BY id DESC
    """
    
    df_empresa = pd.read_sql(query_empresa, conn)
    print(f"📊 Se cargaron {len(df_empresa)} filas de Empresa")
    print("🔎 Columnas de Empresa:")
    print(df_empresa.columns.tolist())
    
    # ---------------------------
    # 2️⃣ Consulta: Tabla Ventas + VentasDetalles (merge)
    # ---------------------------
    query_ventas = """
    SELECT TOP 10000  
        v.id,
        v.fechaCreacion,
        v.fechaActualizacion,
        v.numeroDocumento,
        vd.id AS venta_detalle_id,
        vd.ventasId,
        vd.codigo AS codigoArticulo,
        vd.cantidad,
        vd.precio,
        vd.precioSinIVA,
        vd.precioCompra,
        vd.Generico
    FROM Ventas v
    JOIN VentasDetalles vd ON v.id = vd.ventasId
    ORDER BY v.fechaCreacion DESC
    """
    
    df_ventas = pd.read_sql(query_ventas, conn)
    print(f"📊 Se cargaron {len(df_ventas)} filas de Ventas + VentasDetalles")
    
    # ---------------------------
    # 3️⃣ Consulta: Tabla VentasDetalles (separada)
    # ---------------------------
    query_ventas_detalles = """
    SELECT TOP 10000  
        id,
        ventasId,
        codigo AS codigoArticulo,
        cantidad,
        precio,
        precioSinIVA,
        precioCompra,
        Generico
    FROM VentasDetalles
    ORDER BY id DESC
    """
    
    df_ventas_detalles = pd.read_sql(query_ventas_detalles, conn)
    print(f"📊 Se cargaron {len(df_ventas_detalles)} filas de VentasDetalles")
    
    # --------------------------------
    # 4️⃣ Merge entre Ventas y VentasDetalles
    # --------------------------------
    df_merged_vd = pd.merge(
        df_ventas, 
        df_ventas_detalles, 
        left_on="id", 
        right_on="ventasId", 
        how="inner"
    )
    
    print(f"\n📊 DataFrame merged (Ventas + VentasDetalles) tiene {len(df_merged_vd)} filas")
    print("🔎 Columnas después del merge:")
    print(df_merged_vd.columns.tolist())
    
    # ---------------------------
    # 5️⃣ Consulta: Tabla InvArticulos
    # ---------------------------
    query_invarticulos = """
    SELECT TOP 10000  
        Id,
        Descripcion,
        DescripcionLarga,
        CPE,
        PermisoSanitario,
        Rotacion,
        InvCategoriaId,
        CodBarraPrincipal,
        MarcaId,
        CodigoArticulo,
        TipoMaterial,
        GrupoMaterial,
        Categoria,
        Subcategoria,
        Departamento,
        CodigoProveedor,
        NombreProveedor,
        CodigoProveedorInterno,
        UnidadesBulto,
        UnidadFraccionFarmacia,
        Marca,
        Indexacion,
        Capacidad,
        Concentracion,
        Presentacion,
        nevera,
        Generico,
        CodigoComponente,
        Componente,
        CodigoControlSanitario,
        ControlSanitario,
        CodigoClaseTerapeutica,
        ClaseTerapeutica,
        MultiploCompra,
        Origen,
        Paciente,
        CodigoTratamiento,
        Tratamiento,
        Consignacion,
        GrupoCompra,
        DenominacionGrupoCompra,
        FechaCreacion,
        FechaModificacion,
        ExistenciaPropia,
        ExistenciaConsignacion,
        Vendedor,
        Consignacionmm,
        Subcategoria2
    FROM InvArticulos
    ORDER BY Id DESC
    """
    
    df_invarticulos = pd.read_sql(query_invarticulos, conn)
    print(f"📊 Se cargaron {len(df_invarticulos)} filas de InvArticulos")
    print("🔎 Columnas de InvArticulos:")
    print(df_invarticulos.columns.tolist())
    
    # 🚨 Conversión de tipo para CodigoArticulo
    df_invarticulos['CodigoArticulo'] = df_invarticulos['CodigoArticulo'].astype(str)
    
    # --------------------------------
    # 6️⃣ Merge final con InvArticulos usando codigoArticulo_x
    # --------------------------------
    df_final = pd.merge(
        df_merged_vd, 
        df_invarticulos, 
        left_on="codigoArticulo_x",  # <--- clave en df_merged_vd (tipo object)
        right_on="CodigoArticulo",    # <--- clave en df_invarticulos (ahora tipo string)
        how="inner"
    )
    
    print(f"\n📊 DataFrame final (Ventas + VentasDetalles + Empresa + InvArticulos) tiene {len(df_final)} filas")
    print("🔎 Columnas finales:")
    print(df_final.columns.tolist())
    
    # --------------------------------
    # 7️⃣ Feature Engineering
    # --------------------------------
    df_final["fechaCreacion"] = pd.to_datetime(df_final["fechaCreacion"])
    df_final["semana"]      = df_final["fechaCreacion"].dt.isocalendar().week.astype(int)
    df_final["dia_mes"]     = df_final["fechaCreacion"].dt.day
    df_final["mes"]         = df_final["fechaCreacion"].dt.month
    df_final["anio"]        = df_final["fechaCreacion"].dt.year
    df_final["dia_semana"]  = df_final["fechaCreacion"].dt.dayofweek
    
    # --------------------------------
    # 8️⃣ Seleccionar features y target (USANDO LOS SUFIJOS _x)
    # --------------------------------
    features = df_final[[
        "semana", 
        "dia_mes", 
        "mes", 
        "anio", 
        "dia_semana", 
        "codigoArticulo_x",   # <--- Usar _x
        "precio_x",           # <--- Usar _x
        "Generico_x",         # <--- Usar _x
        "Descripcion",        # <--- Ejemplo de feature de InvArticulos
        "Categoria",          # <--- Ejemplo de feature de InvArticulos
        "Subcategoria",       # <--- Ejemplo de feature de InvArticulos
        "Generico"            # <--- Ejemplo de feature de InvArticulos
        # ... agrega más columnas de InvArticulos según necesites
    ]]
    
    target = df_final["cantidad_x"]  # <--- Usar _x
    
    print("\n🎯 Features seleccionadas:")
    print(features.head())
    print("\n🎯 Target (primeras filas):")
    print(target.head())
    
except Exception as e:
    print(f"❌ Error: {e}")

finally:
    if 'conn' in locals():
        conn.close()
        print("\n🔒 Conexión cerrada")
