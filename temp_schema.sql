-- DROP SCHEMA dbo;

CREATE SCHEMA dbo;
-- aps.dbo.ArticuloCliente definition

-- Drop table

-- DROP TABLE aps.dbo.ArticuloCliente;

CREATE TABLE aps.dbo.ArticuloCliente ( sociedad int NOT NULL, cliente int NOT NULL, grupo int NOT NULL, codigo int NOT NULL, fechaini datetime NOT NULL, fechafin datetime NOT NULL, CONSTRAINT PK__Articulo__7F5CB6295B12EA79 PRIMARY KEY (sociedad,cliente,grupo,codigo));


-- aps.dbo.Atributo definition

-- Drop table

-- DROP TABLE aps.dbo.Atributo;

CREATE TABLE aps.dbo.Atributo ( id int IDENTITY(1,1) NOT NULL, usuarioAuditor nvarchar(255) COLLATE Modern_Spanish_CI_AS NOT NULL, fechaCreacion datetime2 NOT NULL, fechaActualizacion datetime2 NOT NULL, descripcion varchar(100) COLLATE Modern_Spanish_CI_AS NOT NULL, codigo varchar(10) COLLATE Modern_Spanish_CI_AS NULL, CONSTRAINT PK_20a43cb308ff9176e44db3d0264 PRIMARY KEY (id), CONSTRAINT UQ_3f4c328a8c0cd689ddddbb0754f UNIQUE (codigo));


-- aps.dbo.BanFormasPago definition

-- Drop table

-- DROP TABLE aps.dbo.BanFormasPago;

CREATE TABLE aps.dbo.BanFormasPago ( Id uniqueidentifier NOT NULL, TipoFormaPagoId int NOT NULL, DescripcionFcia nvarchar(50) COLLATE Modern_Spanish_CI_AS NOT NULL, CONSTRAINT PK_BanFormasPago PRIMARY KEY (Id));
 CREATE UNIQUE NONCLUSTERED INDEX IX_BanFormasPago ON aps.dbo.BanFormasPago (  DescripcionFcia ASC  , TipoFormaPagoId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- aps.dbo.BanTiposFormaPago definition

-- Drop table

-- DROP TABLE aps.dbo.BanTiposFormaPago;

CREATE TABLE aps.dbo.BanTiposFormaPago ( Id int NOT NULL, Descripcion nvarchar(50) COLLATE Modern_Spanish_CI_AS NOT NULL, Codigo smallint NULL, CONSTRAINT PK_BanTiposFormaPago PRIMARY KEY (Id));


-- aps.dbo.CENDIS definition

-- Drop table

-- DROP TABLE aps.dbo.CENDIS;

CREATE TABLE aps.dbo.CENDIS ( LEGAL_NAME varchar(50) COLLATE Modern_Spanish_CI_AS NOT NULL, LEGAl_ID varchar(100) COLLATE Modern_Spanish_CI_AS NOT NULL, Email varchar(100) COLLATE Modern_Spanish_CI_AS NOT NULL, Codigo int NOT NULL, CONSTRAINT CENDIS_PK PRIMARY KEY (Codigo));


-- aps.dbo.Categoria definition

-- Drop table

-- DROP TABLE aps.dbo.Categoria;

CREATE TABLE aps.dbo.Categoria ( id int IDENTITY(1,1) NOT NULL, usuarioAuditor nvarchar(255) COLLATE Modern_Spanish_CI_AS NOT NULL, fechaCreacion datetime2 NOT NULL, fechaActualizacion datetime2 NOT NULL, descripcion varchar(100) COLLATE Modern_Spanish_CI_AS NOT NULL, codigo varchar(10) COLLATE Modern_Spanish_CI_AS NULL, CONSTRAINT PK_62148aceba1dbfe1c5caa3493dc PRIMARY KEY (id), CONSTRAINT UQ_3eb6bb1cad2246fb579aaf64c8c UNIQUE (codigo));


-- aps.dbo.Clientes definition

-- Drop table

-- DROP TABLE aps.dbo.Clientes;

CREATE TABLE aps.dbo.Clientes ( codigo int NOT NULL, nombre varchar(512) COLLATE Modern_Spanish_CI_AS NOT NULL, rif varchar(50) COLLATE Modern_Spanish_CI_AS NOT NULL, codigoGrupo int NULL, nombreGrupo varchar(512) COLLATE Modern_Spanish_CI_AS NULL, ramo varchar(50) COLLATE Modern_Spanish_CI_AS NOT NULL, marcaCategoria varchar(512) COLLATE Modern_Spanish_CI_AS NOT NULL, codigoTipoCliente int NOT NULL, tipoCliente varchar(50) COLLATE Modern_Spanish_CI_AS NOT NULL, fechaCreacion date NOT NULL, fechaActualizacion date NULL, latitud decimal(18,15) NULL, longitud decimal(18,15) NULL, brick varchar(50) COLLATE Modern_Spanish_CI_AS NULL, regionIms varchar(256) COLLATE Modern_Spanish_CI_AS NULL, ciudad varchar(256) COLLATE Modern_Spanish_CI_AS NULL, estado varchar(256) COLLATE Modern_Spanish_CI_AS NULL, CONSTRAINT PK_Clientes PRIMARY KEY (codigo));


-- aps.dbo.CodigoBarra definition

-- Drop table

-- DROP TABLE aps.dbo.CodigoBarra;

CREATE TABLE aps.dbo.CodigoBarra ( id int IDENTITY(1,1) NOT NULL, codigoBarra varchar(100) COLLATE Modern_Spanish_CI_AS NOT NULL, tipo varchar(10) COLLATE Modern_Spanish_CI_AS NOT NULL, CONSTRAINT PK_240043cf758ff8e8419edeaac3c PRIMARY KEY (id), CONSTRAINT UQ_13624a50a282beb266ccbb87bb1 UNIQUE (codigoBarra));


-- aps.dbo.CondicionPago definition

-- Drop table

-- DROP TABLE aps.dbo.CondicionPago;

CREATE TABLE aps.dbo.CondicionPago ( id int IDENTITY(1,1) NOT NULL, condicion varchar(256) COLLATE Modern_Spanish_CI_AS NOT NULL, clase varchar(256) COLLATE Modern_Spanish_CI_AS NOT NULL, dia_1 int NOT NULL, porcentaje_1 decimal(18,2) NOT NULL, dia_2 int NOT NULL, porcentaje_2 decimal(18,2) NOT NULL, descripcion varchar(256) COLLATE Modern_Spanish_CI_AS NOT NULL, dia_3 int NOT NULL, CONSTRAINT CondicionPago_pk PRIMARY KEY (id), CONSTRAINT CondicionPago_uk UNIQUE (condicion));


-- aps.dbo.ControlSanitario definition

-- Drop table

-- DROP TABLE aps.dbo.ControlSanitario;

CREATE TABLE aps.dbo.ControlSanitario ( id int IDENTITY(1,1) NOT NULL, usuarioAuditor nvarchar(255) COLLATE Modern_Spanish_CI_AS NOT NULL, fechaCreacion datetime2 NOT NULL, fechaActualizacion datetime2 NOT NULL, descripcion varchar(100) COLLATE Modern_Spanish_CI_AS NOT NULL, codigo varchar(10) COLLATE Modern_Spanish_CI_AS NULL, CONSTRAINT PK_20b271623ff6fc1ea8a68581157 PRIMARY KEY (id), CONSTRAINT UQ_3cd2d552ee3f88d34e352f07d12 UNIQUE (codigo));


-- aps.dbo.DiaFeriado definition

-- Drop table

-- DROP TABLE aps.dbo.DiaFeriado;

CREATE TABLE aps.dbo.DiaFeriado ( Id int NOT NULL, Fecha datetime NOT NULL, FechaCreacion datetime NULL, FechaModificacion datetime NULL, CONSTRAINT DiaFeriado_PK PRIMARY KEY (Id));


-- aps.dbo.Empleados definition

-- Drop table

-- DROP TABLE aps.dbo.Empleados;

CREATE TABLE aps.dbo.Empleados ( id int NOT NULL, numCedula varchar(50) COLLATE Modern_Spanish_CI_AS NOT NULL, nombres varchar(50) COLLATE Modern_Spanish_CI_AS NOT NULL, apellidos varchar(50) COLLATE Modern_Spanish_CI_AS NOT NULL, telefono varchar(50) COLLATE Modern_Spanish_CI_AS NOT NULL, correo varchar(50) COLLATE Modern_Spanish_CI_AS NOT NULL, direccion varchar(100) COLLATE Modern_Spanish_CI_AS NOT NULL, sociedad varchar(50) COLLATE Modern_Spanish_CI_AS NOT NULL, txSociedad varchar(50) COLLATE Modern_Spanish_CI_AS NOT NULL, activo varchar(50) COLLATE Modern_Spanish_CI_AS NOT NULL, limiteCredito numeric(18,2) NOT NULL, rif varchar(50) COLLATE Modern_Spanish_CI_AS NULL, fechaEnvio datetime NOT NULL, CONSTRAINT PK_Empleados PRIMARY KEY (id));


-- aps.dbo.EmpresaCendis definition

-- Drop table

-- DROP TABLE aps.dbo.EmpresaCendis;

CREATE TABLE aps.dbo.EmpresaCendis ( id int IDENTITY(1,1) NOT NULL, codigo int NOT NULL, cendis int NOT NULL, holgura int NOT NULL, limite_usd decimal(18,2) NOT NULL, causa_credito_suspendido varchar(512) COLLATE Modern_Spanish_CI_AS NOT NULL, plazo_especial int NOT NULL, cred_drogueria varchar(256) COLLATE Modern_Spanish_CI_AS NOT NULL, causa_cred_susp_drog varchar(256) COLLATE Modern_Spanish_CI_AS NOT NULL, cred_susp bit NOT NULL, num_cobrador int NOT NULL, nombre_cobrador varchar(256) COLLATE Modern_Spanish_CI_AS NOT NULL, nombre_asesor varchar(256) COLLATE Modern_Spanish_CI_AS NOT NULL, segmentacion_credito varchar(256) COLLATE Modern_Spanish_CI_AS NOT NULL, num_asesor varchar(256) COLLATE Modern_Spanish_CI_AS NOT NULL, condicion_pago varchar(256) COLLATE Modern_Spanish_CI_AS NOT NULL, agente_retencion bit NOT NULL, CONSTRAINT EmpresaCendis_pk PRIMARY KEY (id), CONSTRAINT EmpresaCendis_pk_2 UNIQUE (codigo,cendis));


-- aps.dbo.EmpresaGrupo definition

-- Drop table

-- DROP TABLE aps.dbo.EmpresaGrupo;

CREATE TABLE aps.dbo.EmpresaGrupo ( CodigoGrupoSap int NOT NULL, Nombre nvarchar(50) COLLATE Modern_Spanish_CI_AS NOT NULL, CONSTRAINT PK_EmpresaGrupo_1 PRIMARY KEY (CodigoGrupoSap));


-- aps.dbo.EmpresaGrupoFcia definition

-- Drop table

-- DROP TABLE aps.dbo.EmpresaGrupoFcia;

CREATE TABLE aps.dbo.EmpresaGrupoFcia ( IdEmpresaGrupoFcia int NOT NULL, Descripcion varchar(64) COLLATE Modern_Spanish_CI_AS NOT NULL, Activo bit NULL, CONSTRAINT PK_EmpresaGrupoFcia PRIMARY KEY (IdEmpresaGrupoFcia));


-- aps.dbo.EmpresaSubGrupoFcia definition

-- Drop table

-- DROP TABLE aps.dbo.EmpresaSubGrupoFcia;

CREATE TABLE aps.dbo.EmpresaSubGrupoFcia ( IdEmpresaSubGrupoFcia int IDENTITY(1,1) NOT NULL, Descripcion varchar(64) COLLATE Modern_Spanish_CI_AS NOT NULL, Activo bit NULL, CONSTRAINT PK_EmpresaSubGrupoFcia PRIMARY KEY (IdEmpresaSubGrupoFcia));


-- aps.dbo.InvAtributo definition

-- Drop table

-- DROP TABLE aps.dbo.InvAtributo;

CREATE TABLE aps.dbo.InvAtributo ( Id int IDENTITY(1,1) NOT NULL, Descripcion nvarchar(150) COLLATE Modern_Spanish_CI_AS NOT NULL, Codigo smallint NULL, CONSTRAINT PK_InvAtributo PRIMARY KEY (Id));
 CREATE UNIQUE NONCLUSTERED INDEX IX_InvAtributo_Descripcion ON aps.dbo.InvAtributo (  Descripcion ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- aps.dbo.Marca definition

-- Drop table

-- DROP TABLE aps.dbo.Marca;

CREATE TABLE aps.dbo.Marca ( id int IDENTITY(1,1) NOT NULL, usuarioAuditor nvarchar(255) COLLATE Modern_Spanish_CI_AS NOT NULL, fechaCreacion datetime2 NOT NULL, fechaActualizacion datetime2 NOT NULL, descripcion varchar(100) COLLATE Modern_Spanish_CI_AS NOT NULL, codigo varchar(10) COLLATE Modern_Spanish_CI_AS NULL, CONSTRAINT PK_019cac2ac76d15adccbd2b3b17e PRIMARY KEY (id), CONSTRAINT UQ_28498cf17ae2c0678566d65dca2 UNIQUE (codigo));


-- aps.dbo.MensajeSAP definition

-- Drop table

-- DROP TABLE aps.dbo.MensajeSAP;

CREATE TABLE aps.dbo.MensajeSAP ( Id int IDENTITY(1,1) NOT NULL, Centro int NOT NULL, Fecha datetime NOT NULL, CodMensaje int NOT NULL, Mensaje varchar(MAX) COLLATE Modern_Spanish_CI_AS NOT NULL, CONSTRAINT PK__MensajeS__3214EC07F8E03847 PRIMARY KEY (Id));


-- aps.dbo.Migraciones definition

-- Drop table

-- DROP TABLE aps.dbo.Migraciones;

CREATE TABLE aps.dbo.Migraciones ( id int IDENTITY(1,1) NOT NULL, [timestamp] bigint NOT NULL, name varchar(255) COLLATE Modern_Spanish_CI_AS NOT NULL, CONSTRAINT PK_d9ab1b9ff3959b415a5a4c917dd PRIMARY KEY (id));


-- aps.dbo.PrincipioActivo definition

-- Drop table

-- DROP TABLE aps.dbo.PrincipioActivo;

CREATE TABLE aps.dbo.PrincipioActivo ( id int IDENTITY(1,1) NOT NULL, usuarioAuditor nvarchar(255) COLLATE Modern_Spanish_CI_AS NOT NULL, fechaCreacion datetime2 NOT NULL, fechaActualizacion datetime2 NOT NULL, descripcion varchar(100) COLLATE Modern_Spanish_CI_AS NOT NULL, codigo varchar(10) COLLATE Modern_Spanish_CI_AS NULL, sustanciaControlada bit NULL, CONSTRAINT PK_05ef795b1c91cbdc8b5b8c7aa25 PRIMARY KEY (id), CONSTRAINT UQ_ba335312c117aca6dcf1f004d70 UNIQUE (codigo));


-- aps.dbo.Proveedor definition

-- Drop table

-- DROP TABLE aps.dbo.Proveedor;

CREATE TABLE aps.dbo.Proveedor ( id int IDENTITY(1,1) NOT NULL, usuarioAuditor nvarchar(255) COLLATE Modern_Spanish_CI_AS NOT NULL, fechaCreacion datetime2 NOT NULL, fechaActualizacion datetime2 NOT NULL, nombre varchar(100) COLLATE Modern_Spanish_CI_AS NOT NULL, codigo varchar(20) COLLATE Modern_Spanish_CI_AS NOT NULL, rif varchar(50) COLLATE Modern_Spanish_CI_AS NOT NULL, ultimaActualizacionCatalogo datetime NULL, servidor varchar(200) COLLATE Modern_Spanish_CI_AS NULL, puerto int NULL, CONSTRAINT PK_4d36ff46524e905a788b2114a0d PRIMARY KEY (id), CONSTRAINT UQ_ca3a904f3082e216a01ef8be234 UNIQUE (codigo));


-- aps.dbo.Roles definition

-- Drop table

-- DROP TABLE aps.dbo.Roles;

CREATE TABLE aps.dbo.Roles ( id int IDENTITY(1,1) NOT NULL, usuarioAuditor nvarchar(255) COLLATE Modern_Spanish_CI_AS NOT NULL, fechaCreacion datetime2 NOT NULL, fechaActualizacion datetime2 NOT NULL, descripcion varchar(50) COLLATE Modern_Spanish_CI_AS NOT NULL, activo bit NOT NULL, CONSTRAINT PK_efba48c6a0c7a9b6260f771b165 PRIMARY KEY (id));


-- aps.dbo.TasaDia definition

-- Drop table

-- DROP TABLE aps.dbo.TasaDia;

CREATE TABLE aps.dbo.TasaDia ( Fecha date NOT NULL, MontoTasa decimal(18,2) NULL, CONSTRAINT PK_TasaDia PRIMARY KEY (Fecha));


-- aps.dbo.Tasa_Divisa definition

-- Drop table

-- DROP TABLE aps.dbo.Tasa_Divisa;

CREATE TABLE aps.dbo.Tasa_Divisa ( IdTasaDivisa int IDENTITY(1,1) NOT NULL, NumeroDivisa int NOT NULL, Fecha datetime NOT NULL, TasaCambio decimal(18,2) NOT NULL, CONSTRAINT PK_Tasa_divisa PRIMARY KEY (IdTasaDivisa), CONSTRAINT UQ_Tasa_Divisa_NumeroDivisa_Fecha UNIQUE (NumeroDivisa DESC,Fecha DESC));


-- aps.dbo.TotalFacturaDiaria definition

-- Drop table

-- DROP TABLE aps.dbo.TotalFacturaDiaria;

CREATE TABLE aps.dbo.TotalFacturaDiaria ( Id int IDENTITY(1,1) NOT NULL, EmpresaId int NOT NULL, TotalFactura numeric(38,0) NOT NULL, Fecha date NOT NULL, FechaCreacion datetime2(0) NOT NULL, CONSTRAINT TotalFacturaDiaria_PK PRIMARY KEY (Id), CONSTRAINT TotalFacturaDiaria_fecha_UNIQUE UNIQUE (EmpresaId,Fecha));


-- aps.dbo.UnidadMedida definition

-- Drop table

-- DROP TABLE aps.dbo.UnidadMedida;

CREATE TABLE aps.dbo.UnidadMedida ( id int IDENTITY(1,1) NOT NULL, usuarioAuditor nvarchar(255) COLLATE Modern_Spanish_CI_AS NOT NULL, fechaCreacion datetime2 NOT NULL, fechaActualizacion datetime2 NOT NULL, descripcion varchar(100) COLLATE Modern_Spanish_CI_AS NOT NULL, codigo varchar(10) COLLATE Modern_Spanish_CI_AS NULL, CONSTRAINT PK_52ebdca6ee10f69d95cd8de2701 PRIMARY KEY (id), CONSTRAINT UQ_83218dc7271cdf533a140d242db UNIQUE (codigo));


-- aps.dbo.Usos definition

-- Drop table

-- DROP TABLE aps.dbo.Usos;

CREATE TABLE aps.dbo.Usos ( id int IDENTITY(1,1) NOT NULL, usuarioAuditor nvarchar(255) COLLATE Modern_Spanish_CI_AS NOT NULL, fechaCreacion datetime2 NOT NULL, fechaActualizacion datetime2 NOT NULL, descripcion varchar(100) COLLATE Modern_Spanish_CI_AS NOT NULL, codigo varchar(10) COLLATE Modern_Spanish_CI_AS NULL, CONSTRAINT PK_1ff53bf33c9438722c1af7c4371 PRIMARY KEY (id), CONSTRAINT UQ_1dd6b0c63595505429f34040d17 UNIQUE (codigo));


-- aps.dbo.Usuario definition

-- Drop table

-- DROP TABLE aps.dbo.Usuario;

CREATE TABLE aps.dbo.Usuario ( id int IDENTITY(1,1) NOT NULL, usuarioAuditor nvarchar(255) COLLATE Modern_Spanish_CI_AS NOT NULL, fechaCreacion datetime2 NOT NULL, fechaActualizacion datetime2 NOT NULL, nombre varchar(50) COLLATE Modern_Spanish_CI_AS NOT NULL, apellido varchar(50) COLLATE Modern_Spanish_CI_AS NOT NULL, contraseÃ±a nvarchar(255) COLLATE Modern_Spanish_CI_AS NOT NULL, nombreUsuario varchar(50) COLLATE Modern_Spanish_CI_AS NOT NULL, correo varchar(100) COLLATE Modern_Spanish_CI_AS NOT NULL, telefono varchar(15) COLLATE Modern_Spanish_CI_AS NOT NULL, activo bit NOT NULL, token nvarchar(255) COLLATE Modern_Spanish_CI_AS NULL, AesIV varchar(30) COLLATE Modern_Spanish_CI_AS NOT NULL, CONSTRAINT PK_925c3fc5494373e254405c000eb PRIMARY KEY (id), CONSTRAINT UQ_2242ae6c8b6db1061bd394bc9fd UNIQUE (nombreUsuario), CONSTRAINT UQ_631bf87f4acdcb87c6ff8648c37 UNIQUE (correo));


-- aps.dbo.UsuarioEmpresa definition

-- Drop table

-- DROP TABLE aps.dbo.UsuarioEmpresa;

CREATE TABLE aps.dbo.UsuarioEmpresa ( id int IDENTITY(1,1) NOT NULL, activo bit NOT NULL, nombreUsuario varchar(100) COLLATE Modern_Spanish_CI_AS NOT NULL, planActivoId int NOT NULL, correoElectronico varchar(100) COLLATE Modern_Spanish_CI_AS NOT NULL, telefono varchar(100) COLLATE Modern_Spanish_CI_AS NOT NULL, tipoUsuario int NOT NULL, codigoEmpresa int NOT NULL, fechaInicioSuscripcion datetime2(0) NULL, fechaCaducidadPlanActivo datetime2(0) NOT NULL, contraseÃ±a varchar(100) COLLATE Modern_Spanish_CI_AS NOT NULL, AesIV varchar(30) COLLATE Modern_Spanish_CI_AS NOT NULL, fechaCreacion datetime2 NOT NULL, fechaActualizacion datetime2 NOT NULL, usuarioAuditor nvarchar(255) COLLATE Modern_Spanish_CI_AS NOT NULL, CONSTRAINT UsuarioEmpresa_PK PRIMARY KEY (id), CONSTRAINT UsuarioEmpresa_UNIQUE UNIQUE (nombreUsuario), CONSTRAINT UsuarioEmpresa_correo_UNIQUE UNIQUE (correoElectronico));


-- aps.dbo.UsuarioSR definition

-- Drop table

-- DROP TABLE aps.dbo.UsuarioSR;

CREATE TABLE aps.dbo.UsuarioSR ( id int IDENTITY(1,1) NOT NULL, name varchar(1) COLLATE Modern_Spanish_CI_AS NOT NULL, password varchar(1) COLLATE Modern_Spanish_CI_AS NOT NULL, razon_social varchar(1) COLLATE Modern_Spanish_CI_AS NOT NULL, email varchar(1) COLLATE Modern_Spanish_CI_AS NOT NULL, numero_contacto varchar(1) COLLATE Modern_Spanish_CI_AS NOT NULL, habil int NOT NULL, grupo_p_e int NOT NULL, tipo_master int NOT NULL, id_plan int NOT NULL, tipo_plan int NOT NULL, fecha_inicio date NOT NULL, fecha_fin date NOT NULL, CONSTRAINT UsuarioSR_pk PRIMARY KEY (id));


-- aps.dbo.ZonasFarmacias definition

-- Drop table

-- DROP TABLE aps.dbo.ZonasFarmacias;

CREATE TABLE aps.dbo.ZonasFarmacias ( OgcFid int NOT NULL, [Geometry] varchar(MAX) COLLATE Modern_Spanish_CI_AS NOT NULL, Cod varchar(20) COLLATE Modern_Spanish_CI_AS NOT NULL, CodCob varchar(8) COLLATE Modern_Spanish_CI_AS NOT NULL, NomCob varchar(512) COLLATE Modern_Spanish_CI_AS NULL, Ciudad varchar(60) COLLATE Modern_Spanish_CI_AS NOT NULL, Estado varchar(60) COLLATE Modern_Spanish_CI_AS NOT NULL, Region varchar(20) COLLATE Modern_Spanish_CI_AS NOT NULL, CantFarmacia int NOT NULL, NoRegionCob int NOT NULL, NomRegionCob varchar(256) COLLATE Modern_Spanish_CI_AS NOT NULL, ValorUnidades decimal(18,4) NOT NULL, ValorDolares decimal(18,4) NOT NULL, ValorBolivares decimal(18,4) NOT NULL, CONSTRAINT ZonasFarmacias_pk PRIMARY KEY (OgcFid));


-- aps.dbo.sysdiagrams definition

-- Drop table

-- DROP TABLE aps.dbo.sysdiagrams;

CREATE TABLE aps.dbo.sysdiagrams ( name sysname COLLATE Modern_Spanish_CI_AS NOT NULL, principal_id int NOT NULL, diagram_id int IDENTITY(1,1) NOT NULL, version int NULL, definition varbinary(MAX) NULL, CONSTRAINT PK__sysdiagr__C2B05B610EB76213 PRIMARY KEY (diagram_id), CONSTRAINT UK_principal_name UNIQUE (principal_id,name));


-- aps.dbo.Articulo definition

-- Drop table

-- DROP TABLE aps.dbo.Articulo;

CREATE TABLE aps.dbo.Articulo ( id int IDENTITY(1,1) NOT NULL, usuarioAuditor nvarchar(255) COLLATE Modern_Spanish_CI_AS NOT NULL, fechaCreacion datetime2 NOT NULL, fechaActualizacion datetime2 NOT NULL, descripcion varchar(500) COLLATE Modern_Spanish_CI_AS NULL, cpe varchar(20) COLLATE Modern_Spanish_CI_AS NULL, permisoSanitario varchar(20) COLLATE Modern_Spanish_CI_AS NULL, marcaId int NULL, categoriaId int NULL, controlSanitarioId int NULL, CONSTRAINT PK_7dc3bd36c6a22b82a0896934399 PRIMARY KEY (id), CONSTRAINT FK_8b35f6eba47e6ea0420116dc5bf FOREIGN KEY (categoriaId) REFERENCES aps.dbo.Categoria(id), CONSTRAINT FK_bfed5b9a7a7385a8480f1e6e907 FOREIGN KEY (marcaId) REFERENCES aps.dbo.Marca(id), CONSTRAINT FK_fd4616bf73f76b7a20d8b387cec FOREIGN KEY (controlSanitarioId) REFERENCES aps.dbo.ControlSanitario(id));


-- aps.dbo.Catalogo definition

-- Drop table

-- DROP TABLE aps.dbo.Catalogo;

CREATE TABLE aps.dbo.Catalogo ( codigoArticulo varchar(100) COLLATE Modern_Spanish_CI_AS NOT NULL, codigoBarra varchar(100) COLLATE Modern_Spanish_CI_AS NULL, descripcionArticulo varchar(500) COLLATE Modern_Spanish_CI_AS NULL, existencia decimal(18,2) NOT NULL, precioNeto decimal(18,4) NULL, precioBruto decimal(18,4) NULL, precioOferta decimal(18,4) NULL, cantidadEmpaque int NULL, porcentajeDescuento decimal(10,4) NULL, proveedorId int NOT NULL, articuloId int NULL, usuarioAuditor nvarchar(255) COLLATE Modern_Spanish_CI_AS NOT NULL, fechaCreacion datetime2 NOT NULL, fechaActualizacion datetime2 NOT NULL, CONSTRAINT PK_332449b8de2bdab9e4023e1548c PRIMARY KEY (codigoArticulo,proveedorId), CONSTRAINT FK_36118eaca541979126b9f2d9fbe FOREIGN KEY (articuloId) REFERENCES aps.dbo.Articulo(id), CONSTRAINT FK_afd2a4f9d6c3879dd87f52cc4df FOREIGN KEY (proveedorId) REFERENCES aps.dbo.Proveedor(id));


-- aps.dbo.CatalogoEmpresa definition

-- Drop table

-- DROP TABLE aps.dbo.CatalogoEmpresa;

CREATE TABLE aps.dbo.CatalogoEmpresa ( id int IDENTITY(1,1) NOT NULL, usuarioAuditor nvarchar(255) COLLATE Modern_Spanish_CI_AS NOT NULL, fechaCreacion datetime2 NOT NULL, fechaActualizacion datetime2 NOT NULL, descripcion varchar(100) COLLATE Modern_Spanish_CI_AS NULL, procesado bit NOT NULL, usuarioId int NULL, empresaId int NULL, CONSTRAINT PK_eb7a1edc3ae1de12bd657a84859 PRIMARY KEY (id), CONSTRAINT FK_7d3afa8c4c04a28e5bb8cfb1709 FOREIGN KEY (usuarioId) REFERENCES aps.dbo.Usuario(id));


-- aps.dbo.CatalogoEmpresaDetalles definition

-- Drop table

-- DROP TABLE aps.dbo.CatalogoEmpresaDetalles;

CREATE TABLE aps.dbo.CatalogoEmpresaDetalles ( id int IDENTITY(1,1) NOT NULL, usuarioAuditor nvarchar(255) COLLATE Modern_Spanish_CI_AS NOT NULL, fechaCreacion datetime2 NOT NULL, fechaActualizacion datetime2 NOT NULL, precio decimal(18,4) NOT NULL, cantidad int NULL, codigoArticulo varchar(100) COLLATE Modern_Spanish_CI_AS NULL, descripcionArticulo varchar(500) COLLATE Modern_Spanish_CI_AS NOT NULL, codigoBarra varchar(100) COLLATE Modern_Spanish_CI_AS NULL, empresaCatalogoId int NULL, proveedorId int NULL, articuloId int NULL, CONSTRAINT PK_bd96282bec935d3a13d73910780 PRIMARY KEY (id), CONSTRAINT FK_3ca3be320231f061be3ca8bec9c FOREIGN KEY (proveedorId) REFERENCES aps.dbo.Proveedor(id), CONSTRAINT FK_59087362feaaee22d78a83682b6 FOREIGN KEY (articuloId) REFERENCES aps.dbo.Articulo(id), CONSTRAINT FK_9f6630c55c0a4a5aceb6a46eea0 FOREIGN KEY (empresaCatalogoId) REFERENCES aps.dbo.CatalogoEmpresa(id));


-- aps.dbo.Empresa definition

-- Drop table

-- DROP TABLE aps.dbo.Empresa;

CREATE TABLE aps.dbo.Empresa ( id int IDENTITY(1,1) NOT NULL, codigo varchar(50) COLLATE Modern_Spanish_CI_AS NOT NULL, usuarioAuditor nvarchar(255) COLLATE Modern_Spanish_CI_AS NOT NULL, fechaCreacion datetime2 NOT NULL, fechaActualizacion datetime2 NOT NULL, nombre varchar(150) COLLATE Modern_Spanish_CI_AS NOT NULL, rif varchar(20) COLLATE Modern_Spanish_CI_AS NOT NULL, direccion varchar(500) COLLATE Modern_Spanish_CI_AS NULL, Estado nvarchar(50) COLLATE Modern_Spanish_CI_AS NULL, Municipio nvarchar(50) COLLATE Modern_Spanish_CI_AS NULL, Parroquia varchar(100) COLLATE Modern_Spanish_CI_AS NOT NULL, Telefonos varchar(100) COLLATE Modern_Spanish_CI_AS NOT NULL, ZonaPostal varchar(100) COLLATE Modern_Spanish_CI_AS NOT NULL, HorarioApertura time(0) NOT NULL, HorarioCierre time(0) NOT NULL, Email varchar(100) COLLATE Modern_Spanish_CI_AS NOT NULL, ServiciosPick bit NOT NULL, ServiciosDelivery bit NOT NULL, latitud numeric(18,15) NULL, longitud numeric(18,15) NULL, brick varchar(100) COLLATE Modern_Spanish_CI_AS NOT NULL, regionIms varchar(100) COLLATE Modern_Spanish_CI_AS NOT NULL, ciudad varchar(100) COLLATE Modern_Spanish_CI_AS NOT NULL, tipoCliente varchar(100) COLLATE Modern_Spanish_CI_AS NOT NULL, codigoTipoCliente int NOT NULL, ramo varchar(100) COLLATE Modern_Spanish_CI_AS NOT NULL, marcaCategoria varchar(100) COLLATE Modern_Spanish_CI_AS NOT NULL, codigoGrupo int NOT NULL, nombreGrupo varchar(100) COLLATE Modern_Spanish_CI_AS NOT NULL, smart bit NOT NULL, IdEmpresaGrupoFcia int NOT NULL, reind_deuda bit NOT NULL, lim_plazo_index bit NOT NULL, segmentacio_cliente varchar(8) COLLATE Modern_Spanish_CI_AS NOT NULL, ci_propietario varchar(256) COLLATE Modern_Spanish_CI_AS NOT NULL, nombre_propietario varchar(256) COLLATE Modern_Spanish_CI_AS NOT NULL, CONSTRAINT Empresa_UNIQUE UNIQUE (codigo), CONSTRAINT Empresa_pk UNIQUE (codigo), CONSTRAINT PK_Empresa_1 PRIMARY KEY (id), CONSTRAINT Empresa_EmpresaGrupoFcia_IdEmpresaGrupoFcia_fk FOREIGN KEY (IdEmpresaGrupoFcia) REFERENCES aps.dbo.EmpresaGrupoFcia(IdEmpresaGrupoFcia));
 CREATE NONCLUSTERED INDEX Empresa_codigoGrupo_IDX ON aps.dbo.Empresa (  codigoGrupo ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE UNIQUE NONCLUSTERED INDEX Empresa_codigo_IDX ON aps.dbo.Empresa (  codigo ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX Empresa_rif_IDX ON aps.dbo.Empresa (  rif ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- aps.dbo.EmpresaCredenciales definition

-- Drop table

-- DROP TABLE aps.dbo.EmpresaCredenciales;

CREATE TABLE aps.dbo.EmpresaCredenciales ( id int IDENTITY(1,1) NOT NULL, usuarioAuditor nvarchar(255) COLLATE Modern_Spanish_CI_AS NOT NULL, fechaCreacion datetime2 NOT NULL, fechaActualizacion datetime2 NOT NULL, usuario nvarchar(255) COLLATE Modern_Spanish_CI_AS NOT NULL, contraseÃ±a nvarchar(255) COLLATE Modern_Spanish_CI_AS NOT NULL, empresaId int NULL, proveedorId int NULL, CONSTRAINT PK_01b020ce0e1202560b866cdfe87 PRIMARY KEY (id), CONSTRAINT FK_61b785eb9df199d0405c9190c0a FOREIGN KEY (proveedorId) REFERENCES aps.dbo.Proveedor(id));


-- aps.dbo.InvArticulos definition

-- Drop table

-- DROP TABLE aps.dbo.InvArticulos;

CREATE TABLE aps.dbo.InvArticulos ( Id int IDENTITY(1,1) NOT NULL, Descripcion nvarchar(256) COLLATE Modern_Spanish_CI_AS NOT NULL, DescripcionLarga nvarchar(512) COLLATE Modern_Spanish_CI_AS NULL, CPE nvarchar(256) COLLATE Modern_Spanish_CI_AS NULL, PermisoSanitario nvarchar(256) COLLATE Modern_Spanish_CI_AS NULL, Rotacion smallint NULL, InvCategoriaId int NULL, CodBarraPrincipal nvarchar(256) COLLATE Modern_Spanish_CI_AS NULL, MarcaId int NULL, CodigoArticulo int NOT NULL, TipoMaterial varchar(128) COLLATE Modern_Spanish_CI_AS NOT NULL, GrupoMaterial varchar(128) COLLATE Modern_Spanish_CI_AS NOT NULL, Categoria varchar(256) COLLATE Modern_Spanish_CI_AS NOT NULL, Subcategoria varchar(256) COLLATE Modern_Spanish_CI_AS NOT NULL, Departamento varchar(256) COLLATE Modern_Spanish_CI_AS NOT NULL, CodigoProveedor varchar(128) COLLATE Modern_Spanish_CI_AS NOT NULL, NombreProveedor varchar(512) COLLATE Modern_Spanish_CI_AS NOT NULL, CodigoProveedorInterno varchar(128) COLLATE Modern_Spanish_CI_AS NOT NULL, UnidadesBulto int NOT NULL, UnidadFraccionFarmacia decimal(38,0) NOT NULL, Marca varchar(256) COLLATE Modern_Spanish_CI_AS NOT NULL, Indexacion varchar(256) COLLATE Modern_Spanish_CI_AS NOT NULL, Capacidad varchar(256) COLLATE Modern_Spanish_CI_AS NOT NULL, Concentracion varchar(256) COLLATE Modern_Spanish_CI_AS NOT NULL, Presentacion varchar(256) COLLATE Modern_Spanish_CI_AS NOT NULL, nevera bit NOT NULL, Generico bit NOT NULL, CodigoComponente varchar(128) COLLATE Modern_Spanish_CI_AS NOT NULL, Componente varchar(256) COLLATE Modern_Spanish_CI_AS NOT NULL, CodigoControlSanitario varchar(128) COLLATE Modern_Spanish_CI_AS NOT NULL, ControlSanitario varchar(256) COLLATE Modern_Spanish_CI_AS NOT NULL, CodigoClaseTerapeutica varchar(128) COLLATE Modern_Spanish_CI_AS NOT NULL, ClaseTerapeutica varchar(256) COLLATE Modern_Spanish_CI_AS NOT NULL, MultiploCompra int NOT NULL, Origen varchar(256) COLLATE Modern_Spanish_CI_AS NOT NULL, Paciente varchar(256) COLLATE Modern_Spanish_CI_AS NOT NULL, CodigoTratamiento varchar(128) COLLATE Modern_Spanish_CI_AS NOT NULL, Tratamiento varchar(256) COLLATE Modern_Spanish_CI_AS NOT NULL, Consignacion varchar(10) COLLATE Modern_Spanish_CI_AS NOT NULL, GrupoCompra varchar(10) COLLATE Modern_Spanish_CI_AS NOT NULL, DenominacionGrupoCompra varchar(256) COLLATE Modern_Spanish_CI_AS NOT NULL, FechaCreacion datetime2(0) NOT NULL, FechaModificacion datetime2(0) NOT NULL, ExistenciaPropia int NOT NULL, ExistenciaConsignacion int NOT NULL, Vendedor varchar(256) COLLATE Modern_Spanish_CI_AS NOT NULL, Consignacionmm bit NOT NULL, Subcategoria2 varchar(256) COLLATE Modern_Spanish_CI_AS NOT NULL, CONSTRAINT PK_InvArticulos PRIMARY KEY (Id), CONSTRAINT InvArticulos_Marca_FK FOREIGN KEY (MarcaId) REFERENCES aps.dbo.Marca(id));


-- aps.dbo.InvArticulosAtributo definition

-- Drop table

-- DROP TABLE aps.dbo.InvArticulosAtributo;

CREATE TABLE aps.dbo.InvArticulosAtributo ( InvArticuloId int NOT NULL, InvAtributoId int NOT NULL, CONSTRAINT PK_InvArticulosAtributo PRIMARY KEY (InvArticuloId,InvAtributoId), CONSTRAINT FK_InvArticulosAtributo_InvArticulos FOREIGN KEY (InvArticuloId) REFERENCES aps.dbo.InvArticulos(Id), CONSTRAINT FK_InvArticulosAtributo_InvAtributo FOREIGN KEY (InvAtributoId) REFERENCES aps.dbo.InvAtributo(Id));


-- aps.dbo.InvCodigoBarra definition

-- Drop table

-- DROP TABLE aps.dbo.InvCodigoBarra;

CREATE TABLE aps.dbo.InvCodigoBarra ( CodigoBarra nvarchar(50) COLLATE Modern_Spanish_CI_AS NOT NULL, InvArticuloId int NOT NULL, CONSTRAINT PK_InvCodigoBarra PRIMARY KEY (CodigoBarra,InvArticuloId), CONSTRAINT FK_InvCodigoBarra_InvArticulos FOREIGN KEY (InvArticuloId) REFERENCES aps.dbo.InvArticulos(Id) ON DELETE CASCADE);


-- aps.dbo.InventarioCENDIS definition

-- Drop table

-- DROP TABLE aps.dbo.InventarioCENDIS;

CREATE TABLE aps.dbo.InventarioCENDIS ( Id int IDENTITY(1,1) NOT NULL, InvArticuloId int NOT NULL, CENDIS_CODE int NOT NULL, Existencia_Propia int NOT NULL, Existencia_Consignacion int NOT NULL, CONSTRAINT InventarioCENDIS_PK PRIMARY KEY (Id), CONSTRAINT InventarioCENDIS_CENDIS_FK FOREIGN KEY (CENDIS_CODE) REFERENCES aps.dbo.CENDIS(Codigo));


-- aps.dbo.InventarioFarmacia definition

-- Drop table

-- DROP TABLE aps.dbo.InventarioFarmacia;

CREATE TABLE aps.dbo.InventarioFarmacia ( Id int IDENTITY(1,1) NOT NULL, CodArticulo int NOT NULL, IdFarmacia int NOT NULL, FechaCreacion datetime2(0) NOT NULL, FechaModificacion datetime2(0) NULL, ExistenciaP int NOT NULL, Consignacion bit NOT NULL, ExistenciaC int NOT NULL, CONSTRAINT InventarioFarmacia_PK PRIMARY KEY (Id), CONSTRAINT InventarioFarmacia_code_x_empresa_UNIQUE UNIQUE (CodArticulo,IdFarmacia), CONSTRAINT InventarioFarmacia_Empresa_FK FOREIGN KEY (IdFarmacia) REFERENCES aps.dbo.Empresa(id) ON DELETE CASCADE);
 CREATE NONCLUSTERED INDEX InventarioFarmacia_Id_IDX ON aps.dbo.InventarioFarmacia (  Id ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- aps.dbo.PresupuestoEmpresa definition

-- Drop table

-- DROP TABLE aps.dbo.PresupuestoEmpresa;

CREATE TABLE aps.dbo.PresupuestoEmpresa ( IdEmpresa int NOT NULL, Mes int NOT NULL, Anio int NOT NULL, CodigoFcia varchar(50) COLLATE Modern_Spanish_CI_AS NOT NULL, VentaMedUn decimal(25,2) NULL, VentaVarUn decimal(25,2) NULL, VentaTotalUn decimal(25,2) NULL, VentaMedBs decimal(25,2) NULL, VentaMedUSD decimal(25,2) NULL, VentaVarBs decimal(25,2) NULL, VentaVarUSD decimal(25,2) NULL, VentaTotalBs decimal(25,2) NULL, VentaTotalUSD decimal(25,2) NULL, VentaTotalNoctBs decimal(25,2) NULL, VentaTotalNoctUSD decimal(25,2) NULL, Transacciones decimal(25,2) NULL, CONSTRAINT PK_PresupuestoEmpresa_1 PRIMARY KEY (IdEmpresa,Mes,Anio,CodigoFcia), CONSTRAINT FK_PresupuestoEmpresa_Empresa FOREIGN KEY (IdEmpresa) REFERENCES aps.dbo.Empresa(id));


-- aps.dbo.UsuarioRoles definition

-- Drop table

-- DROP TABLE aps.dbo.UsuarioRoles;

CREATE TABLE aps.dbo.UsuarioRoles ( id int IDENTITY(1,1) NOT NULL, usuarioAuditor nvarchar(255) COLLATE Modern_Spanish_CI_AS NOT NULL, fechaCreacion datetime2 NOT NULL, fechaActualizacion datetime2 NOT NULL, usuarioId int NULL, rolId int NULL, CONSTRAINT PK_d5b5adbd83357f9c58036d6ad93 PRIMARY KEY (id), CONSTRAINT FK_58a49957850b14587211b12f40c FOREIGN KEY (rolId) REFERENCES aps.dbo.Roles(id), CONSTRAINT FK_83a8ff7a3b1a5dd33c7abd373f5 FOREIGN KEY (usuarioId) REFERENCES aps.dbo.Usuario(id));


-- aps.dbo.Ventas definition

-- Drop table

-- DROP TABLE aps.dbo.Ventas;

CREATE TABLE aps.dbo.Ventas ( id int IDENTITY(1,1) NOT NULL, usuarioAuditor nvarchar(255) COLLATE Modern_Spanish_CI_AS NOT NULL, fechaCreacion datetime2 NOT NULL, fechaActualizacion datetime2 NOT NULL, numeroDocumento nvarchar(255) COLLATE Modern_Spanish_CI_AS NOT NULL, nombreCliente varchar(255) COLLATE Modern_Spanish_CI_AS NOT NULL, identificacionCliente varchar(255) COLLATE Modern_Spanish_CI_AS NOT NULL, totalFactura decimal(18,4) NOT NULL, esDevolucion bit NOT NULL, fechaDocumento datetimeoffset NOT NULL, empresaId int NULL, tipo smallint NOT NULL, tasaFactor nvarchar(255) COLLATE Modern_Spanish_CI_AS NULL, consolidar bit NULL, idVenVentaSmartPharma int NULL, totalImpuesto decimal(18,4) NULL, CONSTRAINT PK_ee0008fd84527a72a1ea9e2b39f PRIMARY KEY (id), CONSTRAINT FK_Ventas_Empresa FOREIGN KEY (empresaId) REFERENCES aps.dbo.Empresa(id));
 CREATE NONCLUSTERED INDEX IX_Ventas_Empresa_Fecha ON aps.dbo.Ventas (  empresaId ASC  , fechaDocumento ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 90   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX Ventas_empresaId_IDX ON aps.dbo.Ventas (  empresaId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 90   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX Ventas_idVenVentaSmartPharma_IDX ON aps.dbo.Ventas (  idVenVentaSmartPharma ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 90   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- aps.dbo.VentasDetalles definition

-- Drop table

-- DROP TABLE aps.dbo.VentasDetalles;

CREATE TABLE aps.dbo.VentasDetalles ( id int IDENTITY(1,1) NOT NULL, codigo varchar(50) COLLATE Modern_Spanish_CI_AS NOT NULL, descripcion varchar(255) COLLATE Modern_Spanish_CI_AS NOT NULL, precio decimal(18,4) NOT NULL, cantidad int NOT NULL, codigoBarra varchar(100) COLLATE Modern_Spanish_CI_AS NULL, ventasId int NULL, precioCompra decimal(18,4) NULL, InvArticuloIdFcia int NULL, migrar bit NULL, precioSinIVA decimal(18,4) NULL, loteFabricante varchar(100) COLLATE Modern_Spanish_CI_AS NOT NULL, loteEntrada varchar(100) COLLATE Modern_Spanish_CI_AS NOT NULL, fechaVencimiento datetime2(0) NOT NULL, costo numeric(38,0) NOT NULL, utilidad numeric(38,0) NOT NULL, Marca varchar(100) COLLATE Modern_Spanish_CI_AS NOT NULL, Componentes varchar(255) COLLATE Modern_Spanish_CI_AS NOT NULL, CodBarraTipo varchar(20) COLLATE Modern_Spanish_CI_AS NOT NULL, CodigoProveedor varchar(20) COLLATE Modern_Spanish_CI_AS NOT NULL, Generico bit NOT NULL, Presentacion varchar(100) COLLATE Modern_Spanish_CI_AS NOT NULL, Consignacion bit NOT NULL, CONSTRAINT PK_95e640a55012b28a798edfd0e58 PRIMARY KEY (id), CONSTRAINT FK_VentasDetalles_Ventas FOREIGN KEY (ventasId) REFERENCES aps.dbo.Ventas(id) ON DELETE CASCADE);
 CREATE NONCLUSTERED INDEX IX_VentasDetalles_Codigo ON aps.dbo.VentasDetalles (  codigo ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 90   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX VentasDetalles_codigoBarra_IDX ON aps.dbo.VentasDetalles (  codigoBarra ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 90   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX VentasDetalles_ventasId_CodArt_IDX ON aps.dbo.VentasDetalles (  ventasId ASC  , codigo ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- aps.dbo.VentasUtilidadFarmacia definition

-- Drop table

-- DROP TABLE aps.dbo.VentasUtilidadFarmacia;

CREATE TABLE aps.dbo.VentasUtilidadFarmacia ( id int IDENTITY(1,1) NOT NULL, fecha datetime2 NOT NULL, cantidadAjuste decimal(18,2) NOT NULL, montoAjuste decimal(18,2) NOT NULL, cantidadCompra decimal(18,4) NOT NULL, montoCompra decimal(20,4) NOT NULL, cantidadVenta decimal(18,2) NOT NULL, montoVenta decimal(20,4) NOT NULL, inventarioInicial decimal(18,2) NOT NULL, costoInicial decimal(18,2) NOT NULL, inventarioFinal decimal(18,2) NOT NULL, costoFinal decimal(18,2) NOT NULL, totalCostoVentaContado decimal(20,4) NOT NULL, totalVentasContado decimal(20,4) NOT NULL, porcentajeUtilidadContado decimal(18,2) NOT NULL, montoUtilidadContado decimal(18,2) NOT NULL, totalCostoVentaCredito decimal(20,4) NOT NULL, totalVentasCredito decimal(20,4) NOT NULL, porcentajeUtilidadCredito decimal(18,2) NOT NULL, montoUtilidadCredito decimal(20,4) NOT NULL, totalNotasCredito decimal(20,4) NOT NULL, totalNotasDebito decimal(20,4) NOT NULL, empresaId int NULL, CONSTRAINT PK_1d8fdfd66114d263b54329c9bd2 PRIMARY KEY (id), CONSTRAINT FK_af7f8799385e3067cc615686d72 FOREIGN KEY (empresaId) REFERENCES aps.dbo.Empresa(id));


-- aps.dbo.Ajuste definition

-- Drop table

-- DROP TABLE aps.dbo.Ajuste;

CREATE TABLE aps.dbo.Ajuste ( Id int IDENTITY(1,1) NOT NULL, InvCausaId int NOT NULL, Cantidad int NOT NULL, CostoUnitario numeric(38,0) NULL, FechaMovimiento datetime2(0) NOT NULL, InvArticuloFciaId int NOT NULL, InvLoteId int NULL, InvAlmacenId int NULL, CostoTotal numeric(38,0) NULL, AuditoriaFechaCreacion datetime2(0) NULL, AuditoriaFechaActualizacion datetime2(0) NULL, AuditoriaUsuarioExterno varchar(12) COLLATE Modern_Spanish_CI_AS NOT NULL, OrigenMovimientoT varchar(100) COLLATE Modern_Spanish_CI_AS NULL, TipoMovimientoT varchar(100) COLLATE Modern_Spanish_CI_AS NULL, OrigenMovimiento int NULL, TipoMovimiento int NULL, IdSmart int NULL, EmpresaId int NOT NULL, FechaCreacion datetime2(0) NOT NULL, CodigoArticulo int NOT NULL, DocumentoOrigen varchar(50) COLLATE Modern_Spanish_CI_AS NOT NULL, CONSTRAINT Ajuste_EMPRESA_SMART_ARTICLE_UNIQUE UNIQUE (EmpresaId,IdSmart,InvArticuloFciaId), CONSTRAINT Ajuste_PK PRIMARY KEY (Id), CONSTRAINT Ajuste_Empresa_FK FOREIGN KEY (EmpresaId) REFERENCES aps.dbo.Empresa(id));


-- aps.dbo.ArticuloCategoria definition

-- Drop table

-- DROP TABLE aps.dbo.ArticuloCategoria;

CREATE TABLE aps.dbo.ArticuloCategoria ( Id int IDENTITY(1,1) NOT NULL, EmpresaId int NOT NULL, CodigoArticulo varchar(20) COLLATE Modern_Spanish_CI_AS NOT NULL, CodigoBarra varchar(20) COLLATE Modern_Spanish_CI_AS NULL, Descripcion varchar(100) COLLATE Modern_Spanish_CI_AS NOT NULL, CodigoCategoriaPadre varchar(8) COLLATE Modern_Spanish_CI_AS NULL, DescripcionCategoriaPadre varchar(100) COLLATE Modern_Spanish_CI_AS NULL, CodigoCategoriaHijo varchar(8) COLLATE Modern_Spanish_CI_AS NULL, DescripcionCategoriaHijo varchar(100) COLLATE Modern_Spanish_CI_AS NULL, FechaCreacion datetime2(0) NOT NULL, FechaActualizaciÃ³n datetime2(0) NOT NULL, CONSTRAINT ArticuloCategoria_PK PRIMARY KEY (Id), CONSTRAINT ArticuloCategoria_Empresa_FK FOREIGN KEY (EmpresaId) REFERENCES aps.dbo.Empresa(id));


-- aps.dbo.ArticuloPrincipioActivo definition

-- Drop table

-- DROP TABLE aps.dbo.ArticuloPrincipioActivo;

CREATE TABLE aps.dbo.ArticuloPrincipioActivo ( id int IDENTITY(1,1) NOT NULL, usuarioAuditor nvarchar(255) COLLATE Modern_Spanish_CI_AS NOT NULL, fechaCreacion datetime2 NOT NULL, fechaActualizacion datetime2 NOT NULL, articuloId int NULL, principioActivoId int NULL, CONSTRAINT PK_738b5aef83358f49b772a7bd962 PRIMARY KEY (id), CONSTRAINT ArticuloPrincipioActivo_InvArticulos_FK FOREIGN KEY (articuloId) REFERENCES aps.dbo.InvArticulos(Id), CONSTRAINT FK_12ae1549ea596057589eb881675 FOREIGN KEY (principioActivoId) REFERENCES aps.dbo.PrincipioActivo(id));


-- aps.dbo.ArticuloUso definition

-- Drop table

-- DROP TABLE aps.dbo.ArticuloUso;

CREATE TABLE aps.dbo.ArticuloUso ( id int IDENTITY(1,1) NOT NULL, usuarioAuditor nvarchar(255) COLLATE Modern_Spanish_CI_AS NOT NULL, fechaCreacion datetime2 NOT NULL, fechaActualizacion datetime2 NOT NULL, articuloId int NULL, usosId int NULL, CONSTRAINT PK_28ffd70924f08e9cbb053588eb9 PRIMARY KEY (id), CONSTRAINT ArticuloUso_InvArticulos_FK FOREIGN KEY (articuloId) REFERENCES aps.dbo.InvArticulos(Id), CONSTRAINT FK_19c0ec745916695463330a95e29 FOREIGN KEY (usosId) REFERENCES aps.dbo.Usos(id));


-- aps.dbo.Compras definition

-- Drop table

-- DROP TABLE aps.dbo.Compras;

CREATE TABLE aps.dbo.Compras ( id int IDENTITY(1,1) NOT NULL, usuarioAuditor nvarchar(255) COLLATE Modern_Spanish_CI_AS NOT NULL, fechaCreacion datetime2 NOT NULL, fechaActualizacion datetime2 NOT NULL, rifProveedor nvarchar(255) COLLATE Modern_Spanish_CI_AS NOT NULL, codigoProveedor varchar(255) COLLATE Modern_Spanish_CI_AS NOT NULL, nombreProveedor varchar(255) COLLATE Modern_Spanish_CI_AS NOT NULL, numeroFactura nvarchar(255) COLLATE Modern_Spanish_CI_AS NOT NULL, totalImpuesto decimal(18,4) NOT NULL, subTotal decimal(18,4) NOT NULL, montoTotal decimal(18,4) NOT NULL, fechaDocumento datetime2 NOT NULL, empresaId int NULL, referencia decimal(18,4) NULL, fechaRegistro datetime2 NULL, tasaFactor numeric(18,4) NOT NULL, CONSTRAINT PK_586d3fa114b0fe3d92450bd395d PRIMARY KEY (id), CONSTRAINT FK_Compras_Empresa FOREIGN KEY (empresaId) REFERENCES aps.dbo.Empresa(id));


-- aps.dbo.ComprasDetalles definition

-- Drop table

-- DROP TABLE aps.dbo.ComprasDetalles;

CREATE TABLE aps.dbo.ComprasDetalles ( id int IDENTITY(1,1) NOT NULL, codigoArticulo varchar(255) COLLATE Modern_Spanish_CI_AS NOT NULL, descripcion varchar(255) COLLATE Modern_Spanish_CI_AS NOT NULL, codigoBarra varchar(255) COLLATE Modern_Spanish_CI_AS NULL, cantidadRecibida int NOT NULL, cantidadFacturada int NOT NULL, impuesto decimal(10,2) NOT NULL, total decimal(18,4) NOT NULL, compraId int NULL, totalBruto decimal(18,4) NOT NULL, codigoArticuloFcia varchar(10) COLLATE Modern_Spanish_CI_AS NOT NULL, CONSTRAINT PK_5115a2c518d8bb3e89a55149be3 PRIMARY KEY (id), CONSTRAINT FK_6e58b420db919dd0ce2ea6b5c37 FOREIGN KEY (compraId) REFERENCES aps.dbo.Compras(id));


-- aps.dbo.InvArticuloFcia definition

-- Drop table

-- DROP TABLE aps.dbo.InvArticuloFcia;

CREATE TABLE aps.dbo.InvArticuloFcia ( EmpresaId int NOT NULL, InvArticuloId int NULL, InvArticuloFciaId int NOT NULL, DescripcionCortaFcia varchar(512) COLLATE Modern_Spanish_CI_AS NULL, ArticuloCOBECA bit NOT NULL, Marca varchar(256) COLLATE Modern_Spanish_CI_AS NOT NULL, PrincipiosActivos varchar(512) COLLATE Modern_Spanish_CI_AS NOT NULL, Capacidad varchar(512) COLLATE Modern_Spanish_CI_AS NOT NULL, Atributo varchar(256) COLLATE Modern_Spanish_CI_AS NOT NULL, PermisoSanitario varchar(256) COLLATE Modern_Spanish_CI_AS NOT NULL, ExistenciaP numeric(38,0) NOT NULL, Presentacion varchar(512) COLLATE Modern_Spanish_CI_AS NOT NULL, Rotacion tinyint NOT NULL, CPE varchar(256) COLLATE Modern_Spanish_CI_AS NOT NULL, CodBarra varchar(512) COLLATE Modern_Spanish_CI_AS NOT NULL, CodCategoria int NULL, CodigoArticulo varchar(256) COLLATE Modern_Spanish_CI_AS NOT NULL, CodigoArticuloInt int NOT NULL, Consignacion bit NOT NULL, ExistenciaC numeric(38,0) NOT NULL, FechaActualizacion datetime2(0) NOT NULL, CONSTRAINT InvArticuloFcia_PK PRIMARY KEY (EmpresaId,InvArticuloFciaId), CONSTRAINT FK_InvArticuloFcia_InvArticulos FOREIGN KEY (InvArticuloId) REFERENCES aps.dbo.InvArticulos(Id) ON DELETE SET NULL, CONSTRAINT FK_InvArtiuloFarmacia_Empresa FOREIGN KEY (EmpresaId) REFERENCES aps.dbo.Empresa(id));
 CREATE NONCLUSTERED INDEX IX_InvArticuloFcia_Codigo_Empresa ON aps.dbo.InvArticuloFcia (  CodigoArticulo ASC  , EmpresaId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 90   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
 CREATE NONCLUSTERED INDEX InvArticuloFcia_EmpresaId_IDX ON aps.dbo.InvArticuloFcia (  EmpresaId ASC  , InvArticuloFciaId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 90   ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- aps.dbo.VenVentaFormaPago definition

-- Drop table

-- DROP TABLE aps.dbo.VenVentaFormaPago;

CREATE TABLE aps.dbo.VenVentaFormaPago ( VentaId int NOT NULL, Secuencia int NOT NULL, MontoRecibido decimal(25,2) NOT NULL, BanTipoFormaPagoId int NULL, CONSTRAINT PK_VenVentaFormaPago PRIMARY KEY (VentaId,Secuencia), CONSTRAINT FK_VenVentaFormaPago_BanTiposFormaPago FOREIGN KEY (BanTipoFormaPagoId) REFERENCES aps.dbo.BanTiposFormaPago(Id), CONSTRAINT FK_VenVentaFormaPago_Ventas FOREIGN KEY (VentaId) REFERENCES aps.dbo.Ventas(id));


-- aps.dbo.CodigoBarraArticuloFcia definition

-- Drop table

-- DROP TABLE aps.dbo.CodigoBarraArticuloFcia;

CREATE TABLE aps.dbo.CodigoBarraArticuloFcia ( CodigoBarraId int NOT NULL, EmpresaId int NOT NULL, InvArticuloFciaId int NOT NULL, CONSTRAINT CodigoBarraArticuloFcia_PK PRIMARY KEY (CodigoBarraId,EmpresaId,InvArticuloFciaId), CONSTRAINT CodigoBarraArticuloFcia_CodigoBarra_FK FOREIGN KEY (CodigoBarraId) REFERENCES aps.dbo.CodigoBarra(id), CONSTRAINT CodigoBarraArticuloFcia_Empresa_FK FOREIGN KEY (EmpresaId) REFERENCES aps.dbo.Empresa(id) ON DELETE CASCADE, CONSTRAINT CodigoBarraArticuloFcia_InvArticuloFcia_FK FOREIGN KEY (EmpresaId,InvArticuloFciaId) REFERENCES aps.dbo.InvArticuloFcia(EmpresaId,InvArticuloFciaId) ON DELETE CASCADE);
 CREATE NONCLUSTERED INDEX CodigoBarraArticuloFcia_EmpresaId_IDX ON aps.dbo.CodigoBarraArticuloFcia (  EmpresaId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- dbo.VwArticuloJerarquia source

null;


-- dbo.VwCategoria source

null;


-- dbo.VwCategoryLevel source

null;


-- dbo.VwSubCategoria source

null;
