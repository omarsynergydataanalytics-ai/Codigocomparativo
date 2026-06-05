import pyodbc
import pandas as pd
import os
from dotenv import load_dotenv

# Cargar variables de entorno
load_dotenv()

# Configuración de conexión (usando la misma que en v14)
SQL_SERVER = os.getenv("SQL_SERVER")
SQL_UID    = os.getenv("SQL_UID")
SQL_PWD    = os.getenv("SQL_PWD")

# Conexión a APS
CONN_APS = (
    'DRIVER={ODBC Driver 17 for SQL Server};'
    f'SERVER={SQL_SERVER},{os.getenv("CONN_APS_PORT")};'
    f'DATABASE={os.getenv("CONN_APS_DB")};'
    f'UID={SQL_UID};'
    f'PWD={SQL_PWD};'
    'TrustServerCertificate=yes;'
)

print("🔌 Conectando a la base de datos APS...")

def ejecutar_query(query, conn_str=CONN_APS):
    """Ejecuta una query SQL y retorna un DataFrame"""
    conn = pyodbc.connect(conn_str)
    df = pd.read_sql(query, conn)
    conn.close()
    return df

def main():
    # 1. Extraer las tablas necesarias
    print("📊 Extrayendo tablas desde la base de datos APS...")
    
    # Tabla Empresa
    print("  📋 Extrayendo tabla Empresa...")
    empresa_query = "SELECT * FROM Empresa"
    df_empresa = ejecutar_query(empresa_query)
    print(f"    ✅ Empresa: {len(df_empresa)} registros")
    
    # Tabla Ventas
    print("  📋 Extrayendo tabla Ventas...")
    ventas_query = "SELECT * FROM Ventas"
    df_ventas = ejecutar_query(ventas_query)
    print(f"    ✅ Ventas: {len(df_ventas)} registros")
    
    # Tabla VentasDetalles
    print("  📋 Extrayendo tabla VentasDetalles...")
    ventas_detalles_query = "SELECT * FROM VentasDetalles"
    df_ventas_detalles = ejecutar_query(ventas_detalles_query)
    print(f"    ✅ VentasDetalles: {len(df_ventas_detalles)} registros")
    
    # Tabla Compras
    print("  📋 Extrayendo tabla Compras...")
    compras_query = "SELECT * FROM Compras"
    df_compras = ejecutar_query(compras_query)
    print(f"    ✅ Compras: {len(df_compras)} registros")
    
    # Tabla ComprasDetalles
    print("  📋 Extrayendo tabla ComprasDetalles...")
    compras_detalles_query = "SELECT * FROM ComprasDetalles"
    df_compras_detalles = ejecutar_query(compras_detalles_query)
    print(f"    ✅ ComprasDetalles: {len(df_compras_detalles)} registros")
    
    # Tabla InvArticulos
    print("  📋 Extrayendo tabla InvArticulos...")
    inv_articulos_query = "SELECT * FROM InvArticulos"
    df_inv_articulos = ejecutar_query(inv_articulos_query)
    print(f"    ✅ InvArticulos: {len(df_inv_articulos)} registros")
    
    # Tabla InvArticuloFcia
    print("  📋 Extrayendo tabla InvArticuloFcia...")
    inv_articulo_fcia_query = "SELECT * FROM InvArticuloFcia"
    df_inv_articulo_fcia = ejecutar_query(inv_articulo_fcia_query)
    print(f"    ✅ InvArticuloFcia: {len(df_inv_articulo_fcia)} registros")
    
    # 2. Realizar los joins según las relaciones especificadas
    print("\n🔗 Realizando joins entre las tablas...")
    
    # Primer join: Empresa con Ventas (Empresa.id = Ventas.id)
    print("  🔗 Join Empresa ↔ Ventas...")
    df_ventas_empresa = pd.merge(
        df_empresa, 
        df_ventas, 
        left_on='id', 
        right_on='id',
        suffixes=('_empresa', '_ventas')
    )
    print(f"    ✅ Resultado: {len(df_ventas_empresa)} registros")
    
    # Segundo join: Ventas con VentasDetalles (Ventas.id = VentasDetalles.ventasid)
    print("  🔗 Join VentasEmpresa ↔ VentasDetalles...")
    df_ventas_completo = pd.merge(
        df_ventas_empresa,
        df_ventas_detalles,
        left_on='id',
        right_on='ventasid',
        suffixes=('_ventas', '_detalles')
    )
    print(f"    ✅ Resultado: {len(df_ventas_completo)} registros")
    
    # Tercer join: Empresa con Compras (Empresa.id = Compras.id)
    print("  🔗 Join Empresa ↔ Compras...")
    df_compras_empresa = pd.merge(
        df_empresa,
        df_compras,
        left_on='id',
        right_on='id',
        suffixes=('_empresa_compras', '_compras')
    )
    print(f"    ✅ Resultado: {len(df_compras_empresa)} registros")
    
    # Cuarto join: Compras con ComprasDetalles (Compras.id = ComprasDetalles.comprasid)
    print("  🔗 Join ComprasEmpresa ↔ ComprasDetalles...")
    df_compras_completo = pd.merge(
        df_compras_empresa,
        df_compras_detalles,
        left_on='id',
        right_on='comprasid',
        suffixes=('_compras', '_detalles')
    )
    print(f"    ✅ Resultado: {len(df_compras_completo)} registros")
    
    # Quinto join: InvArticulos con InvArticuloFcia (InvArticulos.id = InvArticuloFcia.InvArticuloid)
    print("  🔗 Join InvArticulos ↔ InvArticuloFcia...")
    df_inventario = pd.merge(
        df_inv_articulos,
        df_inv_articulo_fcia,
        left_on='id',
        right_on='InvArticuloid',
        suffixes=('_articulo', '_fcia')
    )
    print(f"    ✅ Resultado: {len(df_inventario)} registros")
    
    # Sexto join: Empresa con Inventario (Empresa.id = InvArticuloFcia.Empresaid)
    print("  🔗 Join Empresa ↔ Inventario...")
    df_inventario_completo = pd.merge(
        df_empresa,
        df_inventario,
        left_on='id',
        right_on='Empresaid',
        suffixes=('_empresa_inv', '_inventario')
    )
    print(f"    ✅ Resultado: {len(df_inventario_completo)} registros")
    
    # 3. Crear el OBT final uniendo todos los resultados
    print("\n🏗️  Construyendo el OBT final...")
    
    # Usaremos la empresa como tabla base y haremos left joins con las demás
    # Esto nos dará una visión completa de las actividades por empresa
    
    # Primero, hacer merge de ventas con empresa
    df_obt = pd.merge(
        df_empresa,
        df_ventas,
        left_on='id',
        right_on='id',
        how='left',
        suffixes=('_empresa', '_ventas')
    )
    
    # Luego, agregar detalles de ventas
    df_obt = pd.merge(
        df_obt,
        df_ventas_detalles,
        left_on='id',
        right_on='ventasid',
        how='left',
        suffixes=('', '_ventas_det')
    )
    
    # Agregar compras
    df_obt = pd.merge(
        df_obt,
        df_compras,
        left_on='id',
        right_on='id',
        how='left',
        suffixes=('', '_compras')
    )
    
    # Agregar detalles de compras
    df_obt = pd.merge(
        df_obt,
        df_compras_detalles,
        left_on='id',
        right_on='comprasid',
        how='left',
        suffixes=('', '_compras_det')
    )
    
    # Finalmente, agregar información de inventario
    df_obt = pd.merge(
        df_obt,
        df_inventario_completo,
        left_on='id',
        right_on='Empresaid',
        how='left',
        suffixes=('', '_inv')
    )
    
    print(f"✅ OBT final creado con éxito: {len(df_obt)} registros totales")
    
    # 4. Guardar los resultados
    print("\n💾 Guardando resultados...")
    
    # Guardar el OBT completo
    df_obt.to_csv('obt_completo.csv', index=False, encoding='utf-8-sig')
    print(f"  ✅ OBT completo guardado como 'obt_completo.csv'")
    
    # Guardar también los datos separados por módulo
    df_ventas_completo.to_csv('ventas_completo.csv', index=False, encoding='utf-8-sig')
    df_compras_completo.to_csv('compras_completo.csv', index=False, encoding='utf-8-sig')
    df_inventario_completo.to_csv('inventario_completo.csv', index=False, encoding='utf-8-sig')
    
    print(f"  ✅ Módulos separados guardados:")
    print(f"     - 'ventas_completo.csv' ({len(df_ventas_completo)} registros)")
    print(f"     - 'compras_completo.csv' ({len(df_compras_completo)} registros)")
    print(f"     - 'inventario_completo.csv' ({len(df_inventario_completo)} registros)")
    
    # 5. Mostrar resumen estadístico
    print("\n📊 Resumen estadístico del OBT:")
    print(f"   Total de empresas: {len(df_empresa)}")
    print(f"   Total de ventas: {len(df_ventas)}")
    print(f"   Total de detalles de ventas: {len(df_ventas_detalles)}")
    print(f"   Total de compras: {len(df_compras)}")
    print(f"   Total de detalles de compras: {len(df_compras_detalles)}")
    print(f"   Total de artículos en inventario: {len(df_inv_articulos)}")
    print(f"   Total de inventario por fcia: {len(df_inv_articulo_fcia)}")
    
    # Información sobre joins exitosos
    empresas_con_ventas = df_obt['id_ventas'].notna().sum()
    empresas_con_compras = df_obt['id_compras'].notna().sum()
    empresas_con_inventario = df_obt['Empresaid'].notna().sum()
    
    print(f"\n📈 Cobertura por empresa:")
    print(f"   Empresas con ventas: {empresas_con_ventas} ({empresas_con_ventas/len(df_empresa)*100:.1f}%)")
    print(f"   Empresas con compras: {empresas_con_compras} ({empresas_con_compras/len(df_empresa)*100:.1f}%)")
    print(f"   Empresas con inventario: {empresas_con_inventario} ({empresas_con_inventario/len(df_empresa)*100:.1f}%)")
    
    # Columnas disponibles
    print(f"\n📋 Columnas disponibles en el OBT final ({len(df_obt.columns)} columnas):")
    for i, col in enumerate(df_obt.columns[:20], 1):
        print(f"   {i:2}. {col}")
    if len(df_obt.columns) > 20:
        print(f"   ... y {len(df_obt.columns) - 20} columnas más")
    
    print("\n✅ Proceso completado exitosamente!")

if __name__ == "__main__":
    main()