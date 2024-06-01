-- Consultas sobre una tabla

-- 1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.

SELECT O.codigo_oficina AS CodOficina, C.nombre AS Ciudad
FROM oficina O
INNER JOIN ciudad C ON O.idCiudad = C.idCiudad;

-- Devuelve un listado con la ciudad y el teléfono de las oficinas de España.

SELECT C.nombre AS Ciudad, O.telefono As Telefono
FROM oficina O
INNER JOIN ciudad C ON O.idCiudad = C.idCiudad
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
WHERE codigo_jefe IS NULL;

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
WHERE DATEDIFF(fecha_entrega,fecha_esperada)>1;

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

SELECT P.codigo_pedido AS IDPedidosEntregados
FROM estado E
INNER JOIN pedido P ON E.id = P.idEstado
WHERE E.nombre = "Entregado" AND MONTH(P.fecha_entrega)='01';

-- 13. Devuelve un listado con todos los pagos que se realizaron en el
-- año 2008 mediante Paypal. Ordene el resultado de mayor a menor.

SELECT P.id_transaccion AS PagosPaypal, P.total AS Total
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
WHERE P.cantidad_en_stock > 100 AND GP.gama = "Ornamentales"
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
SELECT C.nombre_cliente AS Cliente, CONCAT(E.nombre," ",E.apellido1) AS RepVentas
FROM empleado AS E
INNER JOIN cliente AS C ON E.codigo_empleado = C.codigo_empleado_rep_ventas;

-- 2. Muestra el nombre de los clientes que hayan realizado pagos junto con el
-- nombre de sus representantes de ventas.

SELECT C.nombre_cliente AS Cliente, CONCAT(E.nombre," ",E.apellido1) AS RepVentas
FROM empleado AS E
INNER JOIN cliente AS C ON E.codigo_empleado = C.codigo_empleado_rep_ventas
INNER JOIN pago AS P ON C.codigo_cliente = P.codigo_cliente;

-- 3. Muestra el nombre de los clientes que no hayan realizado pagos junto con
-- el nombre de sus representantes de ventas.   


SELECT C.nombre_cliente AS Cliente, CONCAT(E.nombre,' ',E.apellido1) AS RepVentas
FROM empleado AS E
INNER JOIN cliente AS C ON E.codigo_empleado = C.codigo_empleado_rep_ventas
WHERE C.codigo_cliente NOT IN (SELECT codigo_cliente FROM pago);

-- 4. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus
-- representantes junto con la ciudad de la oficina a la que pertenece el
-- representante.
SELECT C.nombre_cliente AS Cliente, CONCAT(E.nombre,' ',E.apellido1) AS RepVentas, CD.nombre 
FROM empleado AS E
INNER JOIN cliente AS C ON E.codigo_empleado = C.codigo_empleado_rep_ventas
INNER JOIN pago AS P ON C.codigo_cliente = P.codigo_cliente
INNER JOIN oficina AS O ON E.codigo_oficina = O.codigo_oficina
INNER JOIN ciudad AS CD ON O.idCiudad = CD.idCiudad;

-- 5. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre
-- de sus representantes junto con la ciudad de la oficina a la que pertenece el
-- representante.


SELECT C.nombre_cliente AS Cliente, CONCAT(E.nombre,' ',E.apellido1) AS RepVentas, CD.nombre 
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

SELECT CONCAT(E.nombre,' ',E.apellido1) AS Empleado, CONCAT(J.nombre,' ',J.apellido1) AS Jefe, CONCAT(JJ.nombre,' ',JJ.apellido1) AS JefeDeJefes
FROM empleado AS E
INNER JOIN empleado AS J ON E.codigo_jefe = J.codigo_empleado
INNER JOIN empleado AS JJ ON J.codigo_jefe = JJ.codigo_empleado;

-- 10. Devuelve el nombre de los clientes a los que no se les ha entregado a
-- tiempo un pedido.

SELECT C.nombre_cliente AS ClientePedidoTarde
FROM pedido AS P
INNER JOIN cliente AS C ON P.codigo_cliente = C.codigo_cliente
WHERE DATEDIFF(fecha_entrega,fecha_esperada)>1;

-- 11. Devuelve un listado de las diferentes gamas de producto que ha comprado
-- cada cliente.

SELECT PR.gama AS GamasProductoComprado
FROM pedido AS P
INNER JOIN detalle_pedido AS DP ON P.codigo_pedido = DP.codigo_pedido
INNER JOIN producto AS PR ON DP.codigo_producto = PR.codigo_producto
GROUP BY PR.gama;

-- ## Consultas multitabla (Composición externa) ##
-- 1. Devuelve un listado que muestre solamente los clientes que no han
-- realizado ningún pago.

SELECT C.nombre_cliente
FROM cliente AS C
WHERE C.codigo_cliente NOT IN(SELECT codigo_cliente FROM pago);
-- 2. Devuelve un listado que muestre solamente los clientes que no han
-- realizado ningún pedido.

SELECT C.nombre_cliente
FROM cliente AS C
WHERE C.codigo_cliente IS NOT (SELECT codigo_cliente FROM pedido);

-- 3. Devuelve un listado que muestre los clientes que no han realizado ningún
-- pago y los que no han realizado ningún pedido.

SELECT C.nombre_cliente
FROM cliente AS C
WHERE C.codigo_cliente NOT IN (SELECT codigo_cliente FROM pago)
UNION
SELECT C.nombre_cliente
FROM cliente AS C
WHERE C.codigo_cliente NOT IN (SELECT codigo_cliente FROM pedido);

-- 4. Devuelve un listado que muestre solamente los empleados que no tienen
-- una oficina asociada.

--Todos los empleados tienen que tener una oficina asociada pero la consulta sería así

SELECT nombre, apellido1
FROM empleado
WHERE codigo_oficina IS NULL;

-- 5. Devuelve un listado que muestre solamente los empleados que no tienen un
-- cliente asociado.

SELECT codigo_empleado
FROM empleado
WHERE codigo_empleado NOT IN(SELECT E.codigo_empleado
FROM cliente C 
INNER JOIN empleado E ON C.codigo_empleado_rep_ventas = E.codigo_empleado
GROUP BY E.codigo_empleado);


-- 6. Devuelve un listado que muestre solamente los empleados que no tienen un
-- cliente asociado junto con los datos de la oficina donde trabajan.

SELECT CONCAT(E.nombre,' ',E.apellido1) AS Empleado, C.nombre AS OficinaCiudad, O.linea_direccion1 AS DireccionOficina
FROM empleado AS E
INNER JOIN oficina AS O ON E.codigo_oficina = O.codigo_oficina
INNER JOIN ciudad AS C ON O.idCiudad = C.idCiudad
WHERE codigo_empleado NOT IN(SELECT E.codigo_empleado
FROM cliente C 
INNER JOIN empleado E ON C.codigo_empleado_rep_ventas = E.codigo_empleado
GROUP BY E.codigo_empleado);


-- 7. Devuelve un listado que muestre los empleados que no tienen una oficina
-- asociada y los que no tienen un cliente asociado.
SELECT CONCAT(nombre,' ',apellido1)
FROM empleado
WHERE codigo_empleado NOT IN(SELECT E.codigo_empleado
FROM cliente C 
INNER JOIN empleado E ON C.codigo_empleado_rep_ventas = E.codigo_empleado
GROUP BY E.codigo_empleado)
UNION 
SELECT CONCAT(nombre,' ',apellido1)
FROM empleado
WHERE codigo_oficina IS NULL ;


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

SELECT O.linea_direccion1
FROM empleado AS E
INNER JOIN oficina AS O ON E.codigo_oficina = O.codigo_oficina
WHERE E.codigo_empleado NOT IN 
(SELECT CL.codigo_empleado_rep_ventas
FROM detalle_pedido AS DP
INNER JOIN pedido AS P ON DP.codigo_pedido = P.codigo_pedido
INNER JOIN producto AS PR ON DP.codigo_producto = PR.codigo_producto
INNER JOIN cliente AS CL ON P.codigo_cliente = CL.codigo_cliente
WHERE PR.gama = 'Frutales')
GROUP BY O.codigo_oficina;

-- 11. Devuelve un listado con los clientes que han realizado algún pedido pero no
-- han realizado ningún pago.

SELECT C.nombre_cliente
FROM pedido AS P
INNER JOIN cliente AS C ON P.codigo_cliente = C.codigo_cliente
WHERE C.codigo_cliente NOT IN (SELECT codigo_cliente FROM pago);
 

-- 12. Devuelve un listado con los datos de los empleados que no tienen clientes
-- asociados y el nombre de su jefe asociado.

SELECT CONCAT(E.nombre,' ',E.apellido1) AS EmpleadoSinCliente, CONCAT(J.nombre,' ',J.apellido1)
FROM empleado AS E
INNER JOIN empleado AS J ON E.codigo_jefe = J.codigo_empleado
WHERE E.codigo_empleado NOT IN
(SELECT E1.codigo_empleado
        FROM cliente C 
            INNER JOIN empleado E1 ON C.codigo_empleado_rep_ventas = E1.codigo_empleado
            GROUP BY E1.codigo_empleado);

-- ##Consultas resumen##

-- 1. ¿Cuántos empleados hay en la compañía?
SELECT COUNT(codigo_empleado) AS Empleados
FROM empleado;

-- 2. ¿Cuántos clientes tiene cada país?

SELECT COUNT(C.codigo_cliente) AS NumClientes, P.nombre AS Pais
FROM pais P 
INNER JOIN ciudad CD ON P.idPais = CD.idPais
INNER JOIN cliente C ON CD.idCiudad = C.idCiudad
GROUP BY P.idPais;

-- 3. ¿Cuál fue el pago medio en 2009?

SELECT AVG(total) AS MediaPago
FROM pago WHERE fecha_pago LIKE '2009%';

-- 4. ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma
-- descendente por el número de pedidos.

SELECT COUNT(P.codigo_pedido) AS CantidadPedido, E.nombre
FROM estado E 
INNER JOIN pedido P ON E.id = P.idEstado
GROUP BY E.id
ORDER BY COUNT(P.codigo_pedido) DESC;
-- 5. Calcula el precio de venta del producto más caro y más barato en una
-- misma consulta.
SELECT MIN(precio_venta) AS Barato, MAX(precio_venta) AS Caro
FROM producto;
-- 6. Calcula el número de clientes que tiene la empresa.

SELECT COUNT(codigo_cliente) AS NumClientes FROM cliente;


-- 7. ¿Cuántos clientes existen con domicilio en la ciudad de Madrid?

SELECT COUNT(C.codigo_cliente) AS NumClientes FROM cliente C
INNER JOIN ciudad AS CD ON C.idCiudad = CD.idCiudad
WHERE CD.nombre = "Madrid";

-- 8. ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan
-- por M?
SELECT COUNT(C.codigo_cliente) AS NumClientes, CD.nombre
FROM cliente C
INNER JOIN ciudad AS CD ON C.idCiudad = CD.idCiudad
WHERE CD.nombre LIKE "M%"
GROUP BY CD.idCiudad;

-- 9. Devuelve el nombre de los representantes de ventas y el número de clientes
-- al que atiende cada uno.

SELECT CONCAT(E.nombre,' ',E.apellido1) AS RepVenta, COUNT(C.codigo_cliente) AS NumClientes
FROM cliente C
INNER JOIN empleado AS E ON C.codigo_empleado_rep_ventas = E.codigo_empleado
GROUP BY E.codigo_empleado;

-- 10. Calcula el número de clientes que no tiene asignado representante de
-- ventas.
SELECT COUNT(codigo_cliente) AS NumClSinRep
FROM cliente
WHERE codigo_empleado_rep_ventas IS NULL;

-- 11. Calcula la fecha del primer y último pago realizado por cada uno de los
-- clientes. El listado deberá mostrar el nombre y los apellidos de cada cliente.
SELECT MIN(P.fecha_pago) AS PrimerPago, MAX(P.fecha_pago) AS UltimoPago, C.nombre_cliente
FROM pago P
INNER JOIN cliente C ON P.codigo_cliente = C.codigo_cliente
GROUP BY C.codigo_cliente
;
-- 12. Calcula el número de productos diferentes que hay en cada uno de los
-- pedidos.

SELECT COUNT(DISTINCT PR.codigo_producto) AS DifProductos, P.codigo_pedido
FROM producto AS PR
INNER JOIN detalle_pedido P ON PR.codigo_producto = P.codigo_producto
GROUP BY P.codigo_pedido;

-- 13. Calcula la suma de la cantidad total de todos los productos que aparecen en
-- cada uno de los pedidos.

SELECT SUM(cantidad) AS TotalProductosPeiddos
FROM detalle_pedido;

-- 14. Devuelve un listado de los 20 productos más vendidos y el número total de
-- unidades que se han vendido de cada uno. El listado deberá estar ordenado
-- por el número total de unidades vendidas.
SELECT P.nombre, SUM(DP.cantidad) AS UnitVendidas
FROM detalle_pedido DP
INNER JOIN producto P ON DP.codigo_producto = P.codigo_producto
GROUP BY P.codigo_producto
ORDER BY UnitVendidas LIMIT 20
;
-- 15. La facturación que ha tenido la empresa en toda la historia, indicando la
-- base imponible, el IVA y el total facturado. La base imponible se calcula
-- sumando el coste del producto por el número de unidades vendidas de la
-- tabla detalle_pedido. El IVA es el 21 % de la base imponible, y el total la
-- suma de los dos campos anteriores.
SELECT
ROUND(SUM(DP.cantidad * DP.precio_unidad), 2) AS BaseImponibleHistorico,
ROUND(SUM(DP.cantidad * DP.precio_unidad) * 21 / 100, 2) AS IVAHistorico,
ROUND(SUM(DP.cantidad * DP.precio_unidad) + SUM(DP.cantidad * DP.precio_unidad) * 21 / 100,2) AS TOTALHistorico
FROM detalle_pedido DP
;


-- 16. La misma información que en la pregunta anterior, pero agrupada por
-- código de producto.

SELECT
P.codigo_producto AS Producto,
ROUND(SUM(DP.cantidad * DP.precio_unidad), 2) AS BaseImponibleHistorico,
ROUND(SUM(DP.cantidad * DP.precio_unidad) * 21 / 100, 2) AS IVAHistorico,
ROUND(SUM(DP.cantidad * DP.precio_unidad) + SUM(DP.cantidad * DP.precio_unidad) * 21 / 100,2) AS TOTALHistorico
FROM detalle_pedido DP
INNER JOIN producto P ON DP.codigo_producto  = P.codigo_producto
GROUP BY P.codigo_producto;

-- 17. La misma información que en la pregunta anterior, pero agrupada por
-- código de producto filtrada por los códigos que empiecen por OR.

SELECT
P.codigo_producto AS Producto,
ROUND(SUM(DP.cantidad * DP.precio_unidad), 2) AS BaseImponibleHistorico,
ROUND(SUM(DP.cantidad * DP.precio_unidad) * 21 / 100, 2) AS IVAHistorico,
ROUND(SUM(DP.cantidad * DP.precio_unidad) + SUM(DP.cantidad * DP.precio_unidad) * 21 / 100,2) AS TOTALHistorico
FROM detalle_pedido DP
INNER JOIN producto P ON DP.codigo_producto  = P.codigo_producto
GROUP BY P.codigo_producto
HAVING P.codigo_producto LIKE 'Or%'; -- mis codigos de producto arrancan con P0, sin embargo esta es la estructura
-- para obtener resultados lo podemos adaptar a que inicie con P0
SELECT
P.codigo_producto AS Producto,
ROUND(SUM(DP.cantidad * DP.precio_unidad), 2) AS BaseImponibleHistorico,
ROUND(SUM(DP.cantidad * DP.precio_unidad) * 21 / 100, 2) AS IVAHistorico,
ROUND(SUM(DP.cantidad * DP.precio_unidad) + SUM(DP.cantidad * DP.precio_unidad) * 21 / 100,2) AS TOTALHistorico
FROM detalle_pedido DP
INNER JOIN producto P ON DP.codigo_producto  = P.codigo_producto
GROUP BY P.codigo_producto
HAVING P.codigo_producto LIKE 'P0%';

-- 18. Lista las ventas totales de los productos que hayan facturado más de 3000
-- euros. Se mostrará el nombre, unidades vendidas, total facturado y total
-- facturado con impuestos (21% IVA).

SELECT
P.codigo_producto AS Producto,
ROUND(SUM(DP.cantidad * DP.precio_unidad), 2) AS BaseImponibleHistorico,
ROUND(SUM(DP.cantidad * DP.precio_unidad) * 21 / 100, 2) AS IVAHistorico,
ROUND(SUM(DP.cantidad * DP.precio_unidad) + SUM(DP.cantidad * DP.precio_unidad) * 21 / 100,2) AS TOTALHistorico
FROM detalle_pedido DP
INNER JOIN producto P ON DP.codigo_producto  = P.codigo_producto
GROUP BY P.codigo_producto
HAVING ROUND(SUM(DP.cantidad * DP.precio_unidad) + SUM(DP.cantidad * DP.precio_unidad) * 21 / 100,2) > 3000; -- en mis datos, ningun producto vendió más de 3K. Si cambiamos el numero a 300, para adaptarlo a la base de datos, este seria el resultado

SELECT
P.codigo_producto AS Producto,
ROUND(SUM(DP.cantidad * DP.precio_unidad), 2) AS BaseImponibleHistorico,
ROUND(SUM(DP.cantidad * DP.precio_unidad) * 21 / 100, 2) AS IVAHistorico,
ROUND(SUM(DP.cantidad * DP.precio_unidad) + SUM(DP.cantidad * DP.precio_unidad) * 21 / 100,2) AS TOTALHistorico
FROM detalle_pedido DP
INNER JOIN producto P ON DP.codigo_producto  = P.codigo_producto
GROUP BY P.codigo_producto
HAVING ROUND(SUM(DP.cantidad * DP.precio_unidad) + SUM(DP.cantidad * DP.precio_unidad) * 21 / 100,2) > 300; 


-- 19. Muestre la suma total de todos los pagos que se realizaron para cada uno
-- de los años que aparecen en la tabla pagos.


SELECT ROUND(SUM(total),2) AS TotalPagosxAño, YEAR(fecha_pago) AS Año
FROM pago
GROUP BY YEAR(fecha_pago);
-- ## Subconsultas
-- 1. Devuelve el nombre del cliente con mayor límite de crédito.

SELECT C.nombre_cliente
FROM cliente C
WHERE C.limite_credito =
(SELECT MAX(limite_credito) FROM cliente); -- mis clientes no tienen limite de credito, por lo que no arroja resultados
-- 2. Devuelve el nombre del producto que tenga el precio de venta más caro.

SELECT P.nombre
FROM producto P
WHERE P.precio_venta =
(SELECT MAX(precio_venta) FROM producto); -- mis clientes no tienen limite de credito, por lo que no arroja resultados

--3. Devuelve el nombre del producto del que se han vendido más unidades.
--(Tenga en cuenta que tendrá que calcular cuál es el número total de
-- unidades que se han vendido de cada producto a partir de los datos de la
-- tabla detalle_pedido)

SELECT P.nombre AS nombre_producto
FROM producto P 
INNER JOIN (
    SELECT codigo_producto, SUM(cantidad) AS total_unidades_vendidas
    FROM detalle_pedido
    GROUP BY codigo_producto
) AS UnitsVendidas ON UnitsVendidas.codigo_producto = P.codigo_producto
WHERE UnitsVendidas.total_unidades_vendidas = (
    SELECT MAX(total_unidades_vendidas)
    FROM (
        SELECT SUM(cantidad) AS total_unidades_vendidas
        FROM detalle_pedido
        GROUP BY codigo_producto
    ) AS totales_unidades_vendidas
);

--4. Los clientes cuyo límite de crédito sea mayor que los pagos que haya
-- realizado. (Sin utilizar INNER JOIN).

SELECT nombre_cliente
FROM cliente
WHERE limite_credito >
(SELECT S.TT
FROM (SELECT SUM(total) AS TT
FROM pago
GROUP BY codigo_cliente) AS S
)
GROUP BY codigo_cliente;


--5. Devuelve el producto que más unidades tiene en stock.

SELECT nombre
FROM producto
WHERE cantidad_en_stock = (
    SELECT MAX(cantidad_en_stock)
    FROM producto
);

