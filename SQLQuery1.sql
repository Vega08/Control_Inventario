---Codigo de Creacion de tabla
create table Clientes(
id int primary key identity (1,1),
 nombre varchar (60),
 primerApellido varchar (50),
 telefono varchar(60),
 correo varchar(60),
 ciudad varchar(60),
);
---Insercion de Registros---
USE [Control de Clientes]
GO
SET IDENTITY_INSERT [dbo].[Clientes] ON 

INSERT [dbo].[Clientes] ([id],[nombre],[primerApellido],[telefono],[correo],[ciudad])  VALUES (1, N'Julio','bartolo',  N'7621453289',N'ing.julio.b@gmail.com',N'Oaxaca')
INSERT [dbo].[Clientes] ([id],[nombre],[primerApellido],[telefono],[correo],[ciudad] ) VALUES (2, N'Melissa',N'Nava',  N'7621254533',N'Enf.melissa.n@gmail.com',N'Guerrero')
INSERT [dbo].[Clientes] ([id],[nombre],[primerApellido],[telefono],[correo],[ciudad] ) VALUES (3, N'Andres',N'Vega',  N'7621203361',N'ing.carlos.v@gmail.com',N'CDMX')
INSERT [dbo].[Clientes] ([id],[nombre],[primerApellido],[telefono],[correo],[ciudad] ) VALUES (4, N'Juan', N'Gutierrez',N'7621180623',N'ing.juan.g@gmail.com',N'Guerrero')
SET IDENTITY_INSERT [dbo].[Clientes] OFF

select * from Clientes

-----Codigo de creacion de tabla---------
create table Productos(
id int primary key identity (1,1),
 nombrepro varchar (60),
 cantidad  int,
 descripcion varchar(60),
 precio decimal(9,2),
);
---Insercion de Registros---
USE [Control de Clientes]
GO
SET IDENTITY_INSERT [dbo].[Productos] ON 

INSERT [dbo].[Productos] ([id],[nombrepro],[cantidad],[descripcion],[precio] ) VALUES (1, N'Great Value',N'20',  N'Cereal de trigo',CAST(58.00 AS Decimal(9, 2)))
INSERT [dbo].[Productos] ([id],[nombrepro],[cantidad],[descripcion],[precio] ) VALUES (2, N'La fina',N'12',  N'Sal de la fina',CAST(15.00 AS Decimal(9, 2)))
INSERT [dbo].[Productos] ([id],[nombrepro],[cantidad],[descripcion],[precio] ) VALUES (3, N'1-2-3',N'30',  N'Aceite de la marca 1-2-3',CAST(48.00 AS Decimal(9, 2)))
INSERT [dbo].[Productos] ([id],[nombrepro],[cantidad],[descripcion],[precio] ) VALUES (4, N'Axe', N'15',N'Desodorante Tipo Aerosol',CAST(60.00 AS Decimal(9, 2)))
SET IDENTITY_INSERT [dbo].[Productos] OFF
select * from Productos

---Codigo de Creacion de tabla
create table Ordenes(
 id int primary key identity (1,1),
 Cliente varchar(60),
 fecha date,
 Total decimal(9,2),
);
---Insercion de Registros---
USE [Control de Clientes]
GO
SET IDENTITY_INSERT [dbo].[Ordenes] ON 

INSERT [dbo].[Ordenes] ([id],[Cliente],[fecha],[total]) VALUES (1, N'Melissa',CAST(N'2022-10-25' AS Date),CAST(120.00 AS Decimal(9, 2)))
INSERT [dbo].[Ordenes] ([id],[Cliente],[fecha],[Total]) VALUES (2, N'Andres',CAST(N'2022-11-26' AS Date),CAST(144.00 AS Decimal(9, 2)))
INSERT [dbo].[Ordenes] ([id],[Cliente],[fecha],[Total]) VALUES (3, N'Juan',  CAST(N'2022-09-05'   AS Date),CAST(116.00 AS Decimal(9, 2)))
INSERT [dbo].[Ordenes] ([id],[Cliente],[fecha],[Total]) VALUES (4, N'Julio', CAST(N'2022-10-20'  AS Date),CAST(240.00 AS Decimal(9, 2)))

SET IDENTITY_INSERT [dbo].[Ordenes] OFF

select * from Ordenes 
---Codigo de Creacion de tabla
create table DetalleOrden(
id int primary key identity(1,1),
idOrden int,
idCliente int,
idProducto int,
precio decimal(9,2),
cantidad int
);
---Insercion de Registros---
USE [Control de Clientes]
GO
SET IDENTITY_INSERT [dbo].[DetalleOrden] ON 

INSERT [dbo].[DetalleOrden] ([id],[idOrden],[idProducto],[idCliente],[precio],[cantidad]) VALUES (1,1,4,2,CAST(60.00 AS Decimal(9, 2)),2)
INSERT [dbo].[DetalleOrden] ([id],[idOrden],[idProducto],[idCliente],[precio],[cantidad]) VALUES (2,2,3,3,CAST(48.00 AS Decimal(9, 2)),3)
INSERT [dbo].[DetalleOrden] ([id],[idOrden],[idProducto],[idCliente],[precio],[cantidad]) VALUES (3,3,1,4,CAST(48.00 AS Decimal(9, 2)),2)
INSERT [dbo].[DetalleOrden] ([id],[idOrden],[idProducto],[idCliente],[precio],[cantidad]) VALUES (4,4,4,4,CAST(60.00 AS Decimal(9, 2)),4)

SET IDENTITY_INSERT [dbo].[DetalleOrden] OFF
select * from Clientes
select * from Productos
select * from Ordenes
select * from DetalleOrden
/* Realizar el procedimiento almacenado consultarProductos el cual obtendrá la 
siguiente consulta, recibiendo como parámetro el id del registro que se 
requiere consultar de la tabla Productos. En caso de que el valor sea -1 (menos 
uno) deberá regresar todos los registros de dicha tabla.*/
create or alter procedure consultarProductos
as
   select id,nombrepro,cantidad,descripcion,precio
        from Productos
				 exec consultarProductos;/*Realizar el procediemiento almacenado guardarProductopara registrar un nuevo producto*/create or alter procedure guardarProducto(@nombrepro varchar(60),@cantidad int,@descripcion varchar(60),@precio decimal(9,2))asbegin  insert into Productos(nombrepro,cantidad,	descripcion,precio)  values(@nombrepro,@cantidad,@descripcion,@precio)endexec guardarProducto Cocacola,1,Refreco_Hecho_con_azucar,35.00;/*Realizar el procediemiento almacenado actualizarProductopara actualizar un nuevo producto*/create or alter procedure actualizarProducto  @id              int,
  @nombrepro          varchar(60),
  @cantidad int,  @descripcion varchar(60),  @precio decimal(9,2)as
IF NOT EXISTS (SELECT * FROM Productos WHERE id=@id)
BEGIN
	   SET IDENTITY_INSERT [dbo].[Productos] ON 
       INSERT [dbo].[Productos] ([id],[nombrepro],[cantidad],[descripcion],[precio])
       VALUES (@Id,@nombrepro,@cantidad,@descripcion,@precio)
	   SET IDENTITY_INSERT [dbo].[Alumnos] OFF 
END
ELSE
BEGIN
       UPDATE Productos SET 
	   nombrepro = @nombrepro, cantidad = @cantidad, descripcion=@descripcion,precio=@precio
       WHERE id = @Id
END

Execute actualizarProducto 5,'Pepsi',2,'Refresco con azucar',30.00

/*Realizar el procediemiento Eliminar eliminarProductopara eliminar producto*/create or alter procedure eliminarProducto(@id int)asbegin  delete from Productos where id=@idendexec eliminarProducto select * from Productos