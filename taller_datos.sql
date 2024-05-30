INSERT INTO gama_producto(gama,descripcion_texto,descripcion_html,imagen) VALUES
('Ornamentales','Los ornamentos son aquellos adornos o atavíos que permiten decorar una cosa y hacerla más vistosa.','',''),
('Frutales','Los productos frutales son los frutos que se obtienen de plantas y árboles frutales. Estos productos son una parte fundamental de la alimentación humana debido a su contenido nutricional, que incluye vitaminas, minerales, fibra y antioxidantes.','','');
-- proveedor
INSERT INTO proveedor(idProveedor,nombre) VALUES
(1,"UnitedFruit Company"),
(2,"Ornamented Products");
-- pais
INSERT INTO pais(idPais,nombre) VALUES
(1,"United States"),
(2,"España");
-- region
INSERT INTO region(idRegion,nombre,idPais) VALUES 
(1,'Comunidad de Madrid',2),
(2,'Northeastern',1);
-- ciudad
INSERT INTO ciudad(idCiudad, nombre, idPais, idRegion) VALUES
(1,"Madrid",2,1),
(2,'Fuenlabrada',2,1),
(3,'New York',1,2);
-- zc
INSERT INTO codigo_postal(zip_code,idCiudad) VALUES 
('28001',1),
('28002',1),
('28936',2),
('28940',2),
('10001',3),
('10002',3);
-- oficina
INSERT INTO oficina(codigo_oficina,idCiudad,telefono,linea_direccion1) VALUES
('3302',1,'+326601252','Calle Doctores 23'),
('3301',1,'+326603252','Calle Doctores 25'),
('3311',1,'+326301252','Calle Doctores 24'),
('3402',1,'+322601252','Calle de Alcala 3'),
('3401',1,'+326603212','Calle de Alcala 34'),
('3411',1,'+326301251','Calle de Alcala 6'),
('2402',2,'+322611152','Calle de Leganes 13'),
('2401',2,'+326603552','Calle de Leganes 21'),
('2411',2,'+326301451','Calle de Leganes 4'),
('1402',3,'+122611152','299 Park Ave'),
('1401',3,'+124603552','190 Park Ave'),
('1411',3,'+136301451','159 Park Ave');
-- puesto
INSERT INTO puesto(id,nombre) VALUES
(1,'Representante de ventas'),
(2,'Jefe de Ventas'),
(3,'Administrador'),
(4,'Jefe Administrativo'),
(5,'Gerente general');
-- empleado
INSERT INTO empleado(codigo_empleado,nombre,apellido1,extensio,email,codigo_oficina,codigo_jefe,idPuesto) VALUES 
(666,'Jone','Jones','99','jone@jones.com','1402',NULL,5),
(1,'Pablo','Azcarate','32','pablo@azcarate.com','3302',666,4),
(2,'Juan','Azcarate','232','juan@azcarate.com','3301',666,4),
(7,'Pablo','Motos','12','pablo@motos.com','3302',666,2),
(5,'Keyly','Kox','25','keyly@kox.com','3302',7,1),
(4,'Samuel','Ramirez','15','keyly@ramirez.com','3302',7,1),
(6,'Jacobo','Kox','155','jacobo@kox.com','1401',5,NULL);

-- cliente
INSERT INTO cliente(codigo_cliente, nombre_cliente, telefono, fax, linea_direccion1, idCiudad, codigo_empleado_rep_ventas) VALUES

(1, 'Carlos Fernández', '555-5678', '555-5678', 'Calle de Alcala 3', 1, 5),
(2, 'Ana Martínez', '555-8765', '555-8765', 'Calle de Leganes 13', 2, 4),
(3, 'Pedro López', '555-4321', '555-4321', '299 Park Ave', 3, NULL),
(4, 'Lucía García', '555-1235', '555-1235', 'Calle de Alcala 34', 1, NULL),
(5, 'Manuel Torres', '555-5679', '555-5679', 'Calle de Leganes 21', 2, 5),
(6, 'María Sánchez', '555-8766', '555-8766', '190 Park Ave', 3, 5),
(7, 'José Rodríguez', '555-4322', '555-4322', 'Calle Doctores 23', 1, 5),
(8, 'Elena Gómez', '555-1236', '555-1236', 'Calle de Leganes 4', 2, NULL),
(9, 'Francisco Díaz', '555-5680', '555-5680', '159 Park Ave', 3, 4),
(10, 'Carmen Ruiz', '555-8767', '555-8767', 'Calle Doctores 24', 1, 4),
(11, 'Marta Jiménez', '555-4323', '555-4323', 'Calle Doctores 25', 1, 4),
(12, 'Luis Martínez', '555-1237', '555-1237', 'Calle de Alcala 6', 1, NULL);


-- producto
INSERT INTO producto(codigo_producto, nombre, gama, dimensiones, idProveedor, descripcion, cantidad_en_stock, precio_venta, precio_proveedor) VALUES
('P001', 'Maceta Ornamental', 'Ornamentales', '30x30', 2, 'Maceta decorativa para jardín', 100, 15.00, 10.00),
('P002', 'Manzana', 'Frutales', '8x10', 1, 'Manzana roja fresca', 200, 0.50, 0.30),
('P003', 'Naranja', 'Frutales', NULL, 1, 'Naranja jugosa', 150, 0.70, 0.40);

-- forma_pago
INSERT INTO forma_pago(id,nombre) VALUES
(1,'PayPal'),
(2,'Tarjeta Credito'),
(3,'Efectivo');

-- pago

INSERT INTO pago(codigo_cliente,idFormaPago,id_transaccion,fecha_pago,total) VALUES
(1,1,1,'2008-01-01',235),
(2,2,2,'2009-01-01',125),
(5,1,3,'2008-01-01',115),
(10,2,4,'2008-01-01',235),
(11,3,5,'2008-01-01',15);


-- estado
INSERT INTO estado(id,nombre) VALUES
(1,'Entregado'),
(2,'Rechazado'),
(3,'En camino');


-- pedido
INSERT INTO pedido(codigo_pedido, fecha_pedido, fecha_esperada,fecha_entrega, idEstado, codigo_cliente) VALUES
(1, '2009-05-01','2009-05-05','2009-05-22',1,1),
(2, '2009-05-02','2009-05-07','2009-05-05',1,1),
(3, '2008-05-05','2008-05-10','2008-05-06',1,2),
(4, '2009-01-02','2009-01-07',NULL,2,5),
(5, '2009-02-12','2009-02-15',NULL,2,5),
(6, '2009-02-20','2010-02-22','2010-02-25',1,11),
(7, '2010-01-02','2010-01-07',NULL,2,11),
(8, '2010-02-12','2010-02-15',NULL,2,11),
(9, '2010-02-20','2010-02-22','2010-02-25',1,11);
-- detalle_pedido
INSERT INTO detalle_pedido(codigo_pedido, codigo_producto, cantidad, precio_unidad,numero_linea) VALUES
(1, 'P001', 2, 30.00,6),
(1, 'P002', 5, 2.50,5),
(2, 'P001', 2, 30.00,6),
(2, 'P002', 5, 2.50,5),
(2, 'P003', 10, 7.00,4),
(3, 'P001', 2, 30.00,6),
(3, 'P002', 5, 2.50,5),
(3, 'P003', 10, 7.00,4),
(4, 'P001', 2, 30.00,6),
(4, 'P002', 5, 2.50,5),
(4, 'P003', 10, 7.00,4),
(5, 'P001', 2, 30.00,6),
(5, 'P002', 5, 2.50,5),
(5, 'P003', 10, 7.00,4),
(6, 'P001', 2, 30.00,6),
(6, 'P002', 5, 2.50,5),
(6, 'P003', 10, 7.00,4),
(7, 'P001', 2, 30.00,6),
(7, 'P002', 5, 2.50,5),
(7, 'P003', 10, 7.00,4),
(8, 'P001', 2, 30.00,6),
(8, 'P002', 5, 2.50,5),
(8, 'P003', 10, 7.00,4),
(9, 'P001', 2, 30.00,6),
(9, 'P002', 5, 2.50,5),
(9, 'P003', 10, 7.00,4);