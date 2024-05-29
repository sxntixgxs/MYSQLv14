-- Consultas sobre una tabla

-- 1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.

SELECT O.codigo_oficina AS CodOficina, C.nombre AS Ciudad
FROM oficina O
INNER JOIN codigo_postal CP ON C.idCiudad = CP.zip_code
INNER JOIN ciudad C ON CP.idCiudad = C.id;

-- Devuelve un listado con la ciudad y el teléfono de las oficinas de España.

SELECT C.nombre AS Ciudad, O.telefono As Telefono
FROM oficina O
INNER JOIN codigo_postal CP ON C.idCiudad = CP.zip_code
INNER JOIN ciudad C ON CP.idCiudad = C.id
INNER JOIN pais P ON C.idPais = P.idPais
WHERE P.nombre LIKE 'Esp%';

-- Devuelve un listado con el nombre, apellidos y email de los empleados cuyo
-- jefe tiene un código de jefe igual a 7.

SELECT CONCAT(E.nombre,E.apellido1) AS Empleado, E.email AS Email
FROM empleado AS E
WHERE E.codigo_jefe = 7;

-- Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la
-- empresa.

SELECT CONCAT(nombre,apellido1) AS Nombre, email AS Email 
FROM empleado
WHERE codigo_jefe = NULL;

-- 5. Devuelve un listado con el nombre, apellidos y puesto de aquellos
-- empleados que no sean representantes de ventas.

SELECT CONCAT(E.nombre,E.apellido1) AS Nombre, P.nombre
FROM puesto P
JOIN empleado E ON P.id = E.idPuesto
WHERE P.nombre NOT LIKE 'Repre%';

-- 6. Devuelve un listado con el nombre de los todos los clientes españoles.

SELECT C.nombre_cliente
FROM ciudad CD
INNER JOIN pais P ON CD.idPais = P.idPais
INNER JOIN cliente C ON CD.idCiudad = C.idCiudad
WHERE P.nombre LIKE 'Esp%';

-- 7. Devuelve un listado con los distintos estados por los que puede pasar un
-- pedido.

SELECT nombre
FROM estado;

-- 8. Devuelve un listado con el código de cliente de aquellos clientes que
-- realizaron algún pago en 2008. Tenga en cuenta que deberá eliminar
-- aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta:

SELECT codigo_cliente 
FROM pago
WHERE fecha_pago LIKE '2008%' -- sin ninguna funcion
GROUP BY codigo_cliente;

-- usando year

SELECT codigo_cliente 
FROM pago
WHERE YEAR(fecha_pago) = '2008'
GROUP BY codigo_cliente;

-- usando date_format

SELECT codigo_cliente 
FROM pago
WHERE DATE_FORMAT(fecha_pago,'%Y') = '2008'
GROUP BY codigo_cliente;

-- 9. Devuelve un listado con el código de pedido, código de cliente, fecha
-- esperada y fecha de entrega de los pedidos que no han sido entregados a
-- tiempo.

SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
FROM pedido
WHERE DATEDIFF(fecha_entrega_,fecha_esperada)>1;

-- 10. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos cuya fecha de entrega ha sido al menos dos días antes de la fecha esperada.

SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
FROM pedido
WHERE DATEDIFF(fecha_esperada,fecha_entrega)>=2;

SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
FROM pedido
WHERE ADDDATE(fecha_entrega, INTERVAL 2 DAY) <= fecha_esperada;

-- 11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.

SELECT P.codigo_pedido AS PedidosRechazados
FROM estado E
INNER JOIN pedido P ON E.id = P.idEstado
WHERE E.nombre = "Rechazado" AND fecha_pedido LIKE '2009%';

-- 12. Devuelve un listado de todos los pedidos que han sido entregados en el
-- mes de enero de cualquier año.

SELECT P.codigo_pedido AS PedidosEntregados
FROM estado E
INNER JOIN pedido P ON E.id = P.idEstado
WHERE E.nombre = "Entregado";

-- 13. Devuelve un listado con todos los pagos que se realizaron en el
-- año 2008 mediante Paypal. Ordene el resultado de mayor a menor.

SELECT P.id_transaccion AS PagosPaypal
FROM forma_pago FP
INNER JOIN pago P ON FP.id = P.idFormaPago
WHERE FP.nombre = "Paypal" AND P.fecha_pago LIKE '2008%'
ORDER BY P.total DESC;

-- 14. Devuelve un listado con todas las formas de pago que aparecen en la
-- tabla pago. Tenga en cuenta que no deben aparecer formas de pago
-- repetidas.

SELECT nombre 
FROM forma_pago;

-- 15. Devuelve un listado con todos los productos que pertenecen a la
-- gama Ornamentales y que tienen más de 100 unidades en stock. El listado
-- deberá estar ordenado por su precio de venta, mostrando en primer lugar
-- los de mayor precio.

SELECT P.nombre AS ProductoOrnamental
FROM gama_producto AS GP
INNER JOIN producto AS P ON GP.gama = P.gama
WHERE P.cantidad_en_stock > 100 AND GP.nombre = "Ornamentales"
ORDER BY P.precio_venta DESC;

-- 16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y
-- cuyo representante de ventas tenga el código de empleado 11 o 30.

SELECT C.nombre_cliente AS ClienteMadrid
FROM empleado AS E
INNER JOIN cliente AS C ON E.codigo_empleado = C.codigo_empleado_rep_ventas
INNER JOIN ciudad AS CD ON C.idCiudad = CD.idCiudad
WHERE (E.codigo_empleado = 11 OR E.codigo_empleado = 30) AND CD.nombre = 'Madrid';

-- # Consultas Multitabla #


-- 1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su
-- representante de ventas.

SELECT C.nombre_cliente AS Cliente, CONCAT(E.nombre,E.apellido1) AS RepVentas
FROM empleado AS E
INNER JOIN cliente AS C ON E.codigo_empleado = C.codigo_empleado_rep_ventas;

-- 2. Muestra el nombre de los clientes que hayan realizado pagos junto con el
-- nombre de sus representantes de ventas.

SELECT C.nombre_cliente AS Cliente, CONCAT(E.nombre,E.apellido1) AS RepVentas
FROM empleado AS E
INNER JOIN cliente AS C ON E.codigo_empleado = C.codigo_empleado_rep_ventas
INNER JOIN pago AS P ON C.codigo_cliente = P.codigo_cliente;

-- 3. Muestra el nombre de los clientes que no hayan realizado pagos junto con
-- el nombre de sus representantes de ventas.


SELECT C.nombre_cliente AS Cliente, CONCAT(E.nombre,E.apellido1) AS RepVentas
FROM empleado AS E
INNER JOIN cliente AS C ON E.codigo_empleado = C.codigo_empleado_rep_ventas
WHERE C.codigo_cliente NOT IN (SELECT codigo_cliente FROM pago);

-- 4. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus
-- representantes junto con la ciudad de la oficina a la que pertenece el
-- representante.
SELECT C.nombre_cliente AS Cliente, CONCAT(E.nombre,E.apellido1) AS RepVentas, CD.nombre 
FROM empleado AS E
INNER JOIN cliente AS C ON E.codigo_empleado = C.codigo_empleado_rep_ventas
INNER JOIN pago AS P ON C.codigo_cliente = P.codigo_cliente
INNER JOIN oficina AS O ON E.codigo_oficina = O.codigo_oficina
INNER JOIN ciudad AS CD ON O.idCiudad = CD.idCiudad;

-- 5. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre
-- de sus representantes junto con la ciudad de la oficina a la que pertenece el
-- representante.

SELECT C.nombre_cliente AS Cliente, CONCAT(E.nombre,E.apellido1) AS RepVentas, CD.nombre 
FROM empleado AS E
INNER JOIN cliente AS C ON E.codigo_empleado = C.codigo_empleado_rep_ventas
INNER JOIN oficina AS O ON E.codigo_oficina = O.codigo_oficina
INNER JOIN ciudad AS CD ON O.idCiudad = CD.idCiudad
WHERE C.codigo_cliente NOT IN (SELECT codigo_cliente FROM pago);

-- 6. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.

SELECT O.linea_direccion1 AS OficinasConClientesFuenlabrada
FROM cliente AS C
INNER JOIN empleado AS E ON C.codigo_empleado_rep_ventas = E.codigo_empleado
INNER JOIN oficina AS O ON E.codigo_oficina = O.codigo_oficina
INNER JOIN ciudad AS CD ON O.idCiudad = CD.idCiudad
WHERE CD.nombre = 'Fuenlabrada';

-- 7. Devuelve el nombre de los clientes y el nombre de sus representantes junto
-- con la ciudad de la oficina a la que pertenece el representante.


SELECT C.nombre_cliente AS Cliente, CONCAT(E.nombre,E.apellido1) AS RepVentas, CD.nombre 
FROM empleado AS E
INNER JOIN cliente AS C ON E.codigo_empleado = C.codigo_empleado_rep_ventas
INNER JOIN oficina AS O ON E.codigo_oficina = O.codigo_oficina
INNER JOIN ciudad AS CD ON O.idCiudad = CD.idCiudad;

-- 8. Devuelve un listado con el nombre de los empleados junto con el nombre
-- de sus jefes.

SELECT CONCAT(E.nombre,E.apellido1) AS Empleado, CONCAT(J.nombre,J.apellido1) AS Jefe
FROM empleado AS E
INNER JOIN empleado AS J ON E.codigo_jefe = J.codigo_empleado;

-- 9. Devuelve un listado que muestre el nombre de cada empleados, el nombre
-- de su jefe y el nombre del jefe de sus jefe.

SELECT CONCAT(E.nombre,E.apellido1) AS Empleado, CONCAT(J.nombre,J.apellido1) AS Jefe, CONCAT(JJ.nombre,J.apellido1) AS JefeDeJefes
FROM empleado AS E
INNER JOIN empleado AS J ON E.codigo_jefe = J.codigo_empleado
INNER JOIN empleado AS JJ ON J.codigo_jefe = JJ.codigo_empleado;

-- 10. Devuelve el nombre de los clientes a los que no se les ha entregado a
-- tiempo un pedido.

SELECT C.nombre AS ClientePedidoTarde
FROM pedido AS P
INNER JOIN cliente AS C ON P.codigo_cliente = C.codigo_cliente
WHERE DATEDIFF(fecha_entrega,fecha_esperada)>1;

-- 11. Devuelve un listado de las diferentes gamas de producto que ha comprado
-- cada cliente.

SELECT P.gama AS GamasProductoComprado
FROM pedido AS P
INNER JOIN detalle_pedido AS DP ON P.codigo_pedido = DP.codigo_pedido
INNER JOIN producto AS P ON DP.codigo_producto = P.codigo_producto;

-- ## Consultas multitabla (Composición externa) ##

-- 1. Devuelve un listado que muestre solamente los clientes que no han
-- realizado ningún pago.

SELECT C.nombre_cliente
FROM cliente AS C
WHERE C.codigo_cliente IS NOT (SELECT codigo_cliente FROM pago)
-- 2. Devuelve un listado que muestre solamente los clientes que no han
-- realizado ningún pedido.

SELECT C.nombre_cliente
FROM cliente AS C
WHERE C.codigo_cliente IS NOT (SELECT codigo_cliente FROM pedido)

-- 3. Devuelve un listado que muestre los clientes que no han realizado ningún
-- pago y los que no han realizado ningún pedido.

SELECT C.nombre_cliente
FROM cliente AS C
WHERE C.codigo_cliente IS NOT (SELECT codigo_cliente FROM pago)
UNION
SELECT C.nombre_cliente
FROM cliente AS C
WHERE C.codigo_cliente IS NOT (SELECT codigo_cliente FROM pedido)

-- 4. Devuelve un listado que muestre solamente los empleados que no tienen
-- una oficina asociada.

--Todos los empleados tienen que tener una oficina asociada pero la consulta sería así

SELECT nombre, apellido1
FROM empleado
WHERE codigo_oficina IS NULL;

-- 5. Devuelve un listado que muestre solamente los empleados que no tienen un
-- cliente asociado.

SELECT CONCAT(E.nombre,E.apellido1) AS EmpleadoSinCliente
FROM empleado AS E
WHERE E.codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas FROM cliente);


-- 6. Devuelve un listado que muestre solamente los empleados que no tienen un
-- cliente asociado junto con los datos de la oficina donde trabajan.

SELECT CONCAT(E.nombre,E.apellido1) AS EmpleadoSinCliente, C.nombre AS CiudadEmpleado
FROM empleado AS E
INNER JOIN oficina AS O ON E.codigo_oficina = O.codigo_oficina
INNER JOIN ciudad AS C ON O.idCiudad = C.idCiudad
WHERE E.codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas FROM cliente);


-- 7. Devuelve un listado que muestre los empleados que no tienen una oficina
-- asociada y los que no tienen un cliente asociado.

SELECT nombre, apellido1
FROM empleado
WHERE codigo_oficina IS NULL
UNION
SELECT CONCAT(E.nombre,E.apellido1) AS EmpleadoSinCliente
FROM empleado AS E
WHERE E.codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas FROM cliente);


-- 8. Devuelve un listado de los productos que nunca han aparecido en un
-- pedido.

SELECT nombre AS ProductosSinPedidos
FROM producto
WHERE codigo_producto NOT IN (SELECT codigo_producto FROM detalle_pedido);


-- 9. Devuelve un listado de los productos que nunca han aparecido en un
-- pedido. El resultado debe mostrar el nombre, la descripción y la imagen del
-- producto.

SELECT P.nombre AS ProductosSinPedidos, GP.imagen, P.descripcion
FROM producto AS P
INNER JOIN gama_producto AS GP ON P.gama = GP.gama
WHERE P.codigo_producto NOT IN (SELECT codigo_producto FROM detalle_pedido);


-- 10. Devuelve las oficinas donde no trabajan ninguno de los empleados que
-- hayan sido los representantes de ventas de algún cliente que haya realizado
-- la compra de algún producto de la gama Frutales.

SELECT E.codigo_empleado
FROM pedido P
INNER JOIN 


-- 11. Devuelve un listado con los clientes que han realizado algún pedido pero no
-- han realizado ningún pago.
-- 12. Devuelve un listado con los datos de los empleados que no tienen clientes
-- asociados y el nombre de su jefe asociado.