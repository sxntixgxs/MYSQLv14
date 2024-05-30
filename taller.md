# Taller DBGarden

## Dev by Santiago Sandoval

+ ##  Consultas sobre una tabla

```SQL
-- 1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.

SELECT O.codigo_oficina AS CodOficina, C.nombre AS Ciudad
FROM oficina O
INNER JOIN ciudad C ON O.idCiudad = C.idCiudad;

```
```
+------------+-------------+
| CodOficina | Ciudad      |
+------------+-------------+
| 3301       | Madrid      |
| 3302       | Madrid      |
| 3311       | Madrid      |
| 3401       | Madrid      |
| 3402       | Madrid      |
| 3411       | Madrid      |
| 2401       | Fuenlabrada |
| 2402       | Fuenlabrada |
| 2411       | Fuenlabrada |
| 1401       | New York    |
| 1402       | New York    |
| 1411       | New York    |
+------------+-------------+
12 rows in set (0,00 sec)
```
```SQL
-- 2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.

SELECT C.nombre AS Ciudad, O.telefono As Telefono
FROM oficina O
INNER JOIN ciudad C ON O.idCiudad = C.idCiudad
INNER JOIN pais P ON C.idPais = P.idPais
WHERE P.nombre LIKE 'Esp%';

```
```
+-------------+------------+
| Ciudad      | Telefono   |
+-------------+------------+
| Madrid      | +326603252 |
| Madrid      | +326601252 |
| Madrid      | +326301252 |
| Madrid      | +326603212 |
| Madrid      | +322601252 |
| Madrid      | +326301251 |
| Fuenlabrada | +326603552 |
| Fuenlabrada | +322611152 |
| Fuenlabrada | +326301451 |
+-------------+------------+
9 rows in set (0,00 sec)
```
```SQL
-- 3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo
-- jefe tiene un código de jefe igual a 7.

SELECT CONCAT(E.nombre,E.apellido1) AS Empleado, E.email AS Email
FROM empleado AS E
WHERE E.codigo_jefe = 7;

```
```
+---------------+-------------------+
| Empleado      | Email             |
+---------------+-------------------+
| SamuelRamirez | keyly@ramirez.com |
| KeylyKox      | keyly@kox.com     |
+---------------+-------------------+
2 rows in set (0,00 sec)

```

```SQL
-- 4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la
-- empresa.

SELECT CONCAT(nombre,apellido1) AS Nombre, email AS Email 
FROM empleado
WHERE codigo_jefe IS NULL;


```
```
+-----------+----------------+
| Nombre    | Email          |
+-----------+----------------+
| JoneJones | jone@jones.com |
+-----------+----------------+
1 row in set (0,00 sec)
```
```SQL
-- 5. Devuelve un listado con el nombre, apellidos y puesto de aquellos
-- empleados que no sean representantes de ventas.

SELECT CONCAT(E.nombre,E.apellido1) AS Nombre, P.nombre
FROM puesto P
JOIN empleado E ON P.id = E.idPuesto
WHERE P.nombre NOT LIKE 'Repre%';
```
```
+---------------+---------------------+
| Nombre        | nombre              |
+---------------+---------------------+
| PabloMotos    | Jefe de Ventas      |
| PabloAzcarate | Jefe Administrativo |
| JuanAzcarate  | Jefe Administrativo |
| JoneJones     | Gerente general     |
+---------------+---------------------+
4 rows in set (0,00 sec)
```
```SQL
-- 6. Devuelve un listado con el nombre de los todos los clientes españoles.

SELECT C.nombre_cliente
FROM ciudad CD
INNER JOIN pais P ON CD.idPais = P.idPais
INNER JOIN cliente C ON CD.idCiudad = C.idCiudad
WHERE P.nombre LIKE 'Esp%';
```
```
+-------------------+
| nombre_cliente    |
+-------------------+
| Carlos Fernández  |
| Lucía García      |
| José Rodríguez    |
| Carmen Ruiz       |
| Marta Jiménez     |
| Luis Martínez     |
| Ana Martínez      |
| Manuel Torres     |
| Elena Gómez       |
+-------------------+
9 rows in set (0,00 sec)
```
```SQL

-- 7. Devuelve un listado con los distintos estados por los que puede pasar un
-- pedido.

SELECT nombre
FROM estado;
```
```
+-----------+
| nombre    |
+-----------+
| Entregado |
| Rechazado |
| En camino |
+-----------+
3 rows in set (0,00 sec)
```
```SQL

-- 8. Devuelve un listado con el código de cliente de aquellos clientes que
-- realizaron algún pago en 2008. Tenga en cuenta que deberá eliminar
-- aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta:

SELECT codigo_cliente 
FROM pago
WHERE fecha_pago LIKE '2008%' -- sin ninguna funcion
GROUP BY codigo_cliente;
```
```
+----------------+
| codigo_cliente |
+----------------+
|              1 |
|              5 |
|             10 |
|             11 |
+----------------+
4 rows in set (0,01 sec)
```
```SQL
-- usando year

SELECT codigo_cliente 
FROM pago
WHERE YEAR(fecha_pago) = '2008'
GROUP BY codigo_cliente;
```
```
+----------------+
| codigo_cliente |
+----------------+
|              1 |
|              5 |
|             10 |
|             11 |
+----------------+
4 rows in set (0,00 sec)
```
```SQL
-- usando date_format

SELECT codigo_cliente 
FROM pago
WHERE DATE_FORMAT(fecha_pago,'%Y') = '2008'
GROUP BY codigo_cliente;
```
```
+----------------+
| codigo_cliente |
+----------------+
|              1 |
|              5 |
|             10 |
|             11 |
+----------------+
4 rows in set (0,00 sec)
```
```SQL
-- 9. Devuelve un listado con el código de pedido, código de cliente, fecha
-- esperada y fecha de entrega de los pedidos que no han sido entregados a
-- tiempo.

SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
FROM pedido
WHERE DATEDIFF(fecha_entrega,fecha_esperada)>1;
```
```
+---------------+----------------+----------------+---------------+
| codigo_pedido | codigo_cliente | fecha_esperada | fecha_entrega |
+---------------+----------------+----------------+---------------+
|             1 |              1 | 2009-05-05     | 2009-05-22    |
|             6 |             11 | 2010-02-22     | 2010-02-25    |
|             9 |             11 | 2010-02-22     | 2010-02-25    |
+---------------+----------------+----------------+---------------+
3 rows in set (0,00 sec)
```
```SQL
-- 10. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos cuya fecha de entrega ha sido al menos dos días antes de la fecha esperada.

SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
FROM pedido
WHERE DATEDIFF(fecha_esperada,fecha_entrega)>=2;--forma 1

SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
FROM pedido
WHERE ADDDATE(fecha_entrega, INTERVAL 2 DAY) <= fecha_esperada;--forma2
```
```
+---------------+----------------+----------------+---------------+
| codigo_pedido | codigo_cliente | fecha_esperada | fecha_entrega |
+---------------+----------------+----------------+---------------+
|             2 |              1 | 2009-05-07     | 2009-05-05    |
|             3 |              2 | 2008-05-10     | 2008-05-06    |
+---------------+----------------+----------------+---------------+
2 rows in set (0,00 sec)
```
```SQL
-- 11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.

SELECT P.codigo_pedido AS PedidosRechazados
FROM estado E
INNER JOIN pedido P ON E.id = P.idEstado
WHERE E.nombre = "Rechazado" AND fecha_pedido LIKE '2009%';
```
```
+-------------------+
| PedidosRechazados |
+-------------------+
|                 4 |
|                 5 |
+-------------------+
2 rows in set (0,00 sec)
```
```SQL
-- 12. Devuelve un listado de todos los pedidos que han sido entregados en el
-- mes de enero de cualquier año.

SELECT P.codigo_pedido AS IDPedidosEntregados
FROM estado E
INNER JOIN pedido P ON E.id = P.idEstado
WHERE E.nombre = "Entregado" AND MONTH(P.fecha_entrega)='01';
```
```
+---------------------+
| IDPedidosEntregados |
+---------------------+
|                  10 |
+---------------------+
1 row in set (0,00 sec)
```
```SQL
-- 13. Devuelve un listado con todos los pagos que se realizaron en el
-- año 2008 mediante Paypal. Ordene el resultado de mayor a menor.

SELECT P.id_transaccion AS PagosPaypal, P.total AS Total
FROM forma_pago FP
INNER JOIN pago P ON FP.id = P.idFormaPago
WHERE FP.nombre = "Paypal" AND P.fecha_pago LIKE '2008%'
ORDER BY P.total DESC;
```
```
+-------------+--------+
| PagosPaypal | Total  |
+-------------+--------+
| 1           | 235.00 |
| 3           | 115.00 |
+-------------+--------+
2 rows in set (0,00 sec)
```
```SQL
-- 14. Devuelve un listado con todas las formas de pago que aparecen en la
-- tabla pago. Tenga en cuenta que no deben aparecer formas de pago
-- repetidas.

SELECT nombre 
FROM forma_pago;
```
```
+-----------------+
| nombre          |
+-----------------+
| PayPal          |
| Tarjeta Credito |
| Efectivo        |
+-----------------+
3 rows in set (0,00 sec)
```
```SQL
-- 15. Devuelve un listado con todos los productos que pertenecen a la
-- gama Ornamentales y que tienen más de 100 unidades en stock. El listado
-- deberá estar ordenado por su precio de venta, mostrando en primer lugar
-- los de mayor precio.

SELECT P.nombre AS ProductoOrnamental
FROM gama_producto AS GP
INNER JOIN producto AS P ON GP.gama = P.gama
WHERE P.cantidad_en_stock > 100 AND GP.gama = "Ornamentales"
ORDER BY P.precio_venta DESC;
```
```
+--------------------+
| ProductoOrnamental |
+--------------------+
| Maceta Ornamental  |
+--------------------+
1 row in set (0,00 sec)
```
```SQL
-- 16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y
-- cuyo representante de ventas tenga el código de empleado 11 o 30.

SELECT C.nombre_cliente AS ClienteMadrid
FROM empleado AS E
INNER JOIN cliente AS C ON E.codigo_empleado = C.codigo_empleado_rep_ventas
INNER JOIN ciudad AS CD ON C.idCiudad = CD.idCiudad
WHERE (E.codigo_empleado = 11 OR E.codigo_empleado = 30) AND CD.nombre = 'Madrid';
```
```
+-------------------+
| ClienteMadrid     |
+-------------------+
| Carlos Fernández  |
+-------------------+
1 row in set (0,00 sec)
```
+ ## Consultas Multitabla

```SQL
-- 1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su
-- representante de ventas.

SELECT C.nombre_cliente AS Cliente, CONCAT(E.nombre," ",E.apellido1) AS RepVentas
FROM empleado AS E
INNER JOIN cliente AS C ON E.codigo_empleado = C.codigo_empleado_rep_ventas;

```
```
+-------------------+------------------+
| Cliente           | RepVentas        |
+-------------------+------------------+
| Ana Martínez      | Samuel Ramirez   |
| Francisco Díaz    | Samuel Ramirez   |
| Carmen Ruiz       | Samuel Ramirez   |
| Marta Jiménez     | Samuel Ramirez   |
| Manuel Torres     | Keyly Kox        |
| María Sánchez     | Keyly Kox        |
| José Rodríguez    | Keyly Kox        |
| Carlos Fernández  | Keyly Valenzuela |
+-------------------+------------------+
8 rows in set (0,00 sec)
```
```SQL
-- 2. Muestra el nombre de los clientes que hayan realizado pagos junto con el
-- nombre de sus representantes de ventas.

SELECT C.nombre_cliente AS Cliente, CONCAT(E.nombre," ",E.apellido1) AS RepVentas
FROM empleado AS E
INNER JOIN cliente AS C ON E.codigo_empleado = C.codigo_empleado_rep_ventas
INNER JOIN pago AS P ON C.codigo_cliente = P.codigo_cliente;
```
```
+-------------------+------------------+
| Cliente           | RepVentas        |
+-------------------+------------------+
| Carlos Fernández  | Keyly Valenzuela |
| Ana Martínez      | Samuel Ramirez   |
| Manuel Torres     | Keyly Kox        |
| Carmen Ruiz       | Samuel Ramirez   |
| Marta Jiménez     | Samuel Ramirez   |
+-------------------+------------------+
5 rows in set (0,00 sec)
```
```SQL
-- 3. Muestra el nombre de los clientes que no hayan realizado pagos junto con
-- el nombre de sus representantes de ventas.   


SELECT C.nombre_cliente AS Cliente, CONCAT(E.nombre,' ',E.apellido1) AS RepVentas
FROM empleado AS E
INNER JOIN cliente AS C ON E.codigo_empleado = C.codigo_empleado_rep_ventas
WHERE C.codigo_cliente NOT IN (SELECT codigo_cliente FROM pago);
```
```
+------------------+----------------+
| Cliente          | RepVentas      |
+------------------+----------------+
| Francisco Díaz   | Samuel Ramirez |
| María Sánchez    | Keyly Kox      |
| José Rodríguez   | Keyly Kox      |
+------------------+----------------+
3 rows in set (0,00 sec)
```
```SQL
-- 4. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus
-- representantes junto con la ciudad de la oficina a la que pertenece el
-- representante.
SELECT C.nombre_cliente AS Cliente, CONCAT(E.nombre,' ',E.apellido1) AS RepVentas, CD.nombre 
FROM empleado AS E
INNER JOIN cliente AS C ON E.codigo_empleado = C.codigo_empleado_rep_ventas
INNER JOIN pago AS P ON C.codigo_cliente = P.codigo_cliente
INNER JOIN oficina AS O ON E.codigo_oficina = O.codigo_oficina
INNER JOIN ciudad AS CD ON O.idCiudad = CD.idCiudad;
```
```
+-------------------+------------------+-------------+
| Cliente           | RepVentas        | nombre      |
+-------------------+------------------+-------------+
| Carlos Fernández  | Keyly Valenzuela | Fuenlabrada |
| Ana Martínez      | Samuel Ramirez   | Madrid      |
| Manuel Torres     | Keyly Kox        | Madrid      |
| Carmen Ruiz       | Samuel Ramirez   | Madrid      |
| Marta Jiménez     | Samuel Ramirez   | Madrid      |
+-------------------+------------------+-------------+
5 rows in set (0,00 sec)
```
```SQL
-- 5. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre
-- de sus representantes junto con la ciudad de la oficina a la que pertenece el
-- representante.

SELECT C.nombre_cliente AS Cliente, CONCAT(E.nombre,' ',E.apellido1) AS RepVentas, CD.nombre 
FROM empleado AS E
INNER JOIN cliente AS C ON E.codigo_empleado = C.codigo_empleado_rep_ventas
INNER JOIN oficina AS O ON E.codigo_oficina = O.codigo_oficina
INNER JOIN ciudad AS CD ON O.idCiudad = CD.idCiudad
WHERE C.codigo_cliente NOT IN (SELECT codigo_cliente FROM pago);
```
```
+------------------+----------------+--------+
| Cliente          | RepVentas      | nombre |
+------------------+----------------+--------+
| Francisco Díaz   | Samuel Ramirez | Madrid |
| María Sánchez    | Keyly Kox      | Madrid |
| José Rodríguez   | Keyly Kox      | Madrid |
+------------------+----------------+--------+
3 rows in set (0,01 sec)
```
```SQL

-- 6. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.

SELECT O.linea_direccion1 AS OficinasConClientesFuenlabrada
FROM cliente AS C
INNER JOIN empleado AS E ON C.codigo_empleado_rep_ventas = E.codigo_empleado
INNER JOIN oficina AS O ON E.codigo_oficina = O.codigo_oficina
INNER JOIN ciudad AS CD ON O.idCiudad = CD.idCiudad
WHERE CD.nombre = 'Fuenlabrada';
```
```
+--------------------------------+
| OficinasConClientesFuenlabrada |
+--------------------------------+
| Calle de Leganes 13            |
+--------------------------------+
1 row in set (0,00 sec)
```
```SQL

-- 7. Devuelve el nombre de los clientes y el nombre de sus representantes junto
-- con la ciudad de la oficina a la que pertenece el representante.


SELECT C.nombre_cliente AS Cliente, CONCAT(E.nombre,' ',E.apellido1) AS RepVentas, CD.nombre 
FROM empleado AS E
INNER JOIN cliente AS C ON E.codigo_empleado = C.codigo_empleado_rep_ventas
INNER JOIN oficina AS O ON E.codigo_oficina = O.codigo_oficina
INNER JOIN ciudad AS CD ON O.idCiudad = CD.idCiudad;
```
```
+-------------------+------------------+-------------+
| Cliente           | RepVentas        | nombre      |
+-------------------+------------------+-------------+
| Ana Martínez      | Samuel Ramirez   | Madrid      |
| Francisco Díaz    | Samuel Ramirez   | Madrid      |
| Carmen Ruiz       | Samuel Ramirez   | Madrid      |
| Marta Jiménez     | Samuel Ramirez   | Madrid      |
| Manuel Torres     | Keyly Kox        | Madrid      |
| María Sánchez     | Keyly Kox        | Madrid      |
| José Rodríguez    | Keyly Kox        | Madrid      |
| Carlos Fernández  | Keyly Valenzuela | Fuenlabrada |
+-------------------+------------------+-------------+
8 rows in set (0,00 sec)
```
```SQL

-- 8. Devuelve un listado con el nombre de los empleados junto con el nombre
-- de sus jefes.

SELECT CONCAT(E.nombre,' ',E.apellido1) AS Empleado, CONCAT(J.nombre,' ',J.apellido1) AS Jefe
FROM empleado AS E
INNER JOIN empleado AS J ON E.codigo_jefe = J.codigo_empleado;
```
```
+------------------+-------------+
| Empleado         | Jefe        |
+------------------+-------------+
| Pablo Azcarate   | Jone Jones  |
| Juan Azcarate    | Jone Jones  |
| Samuel Ramirez   | Pablo Motos |
| Keyly Kox        | Pablo Motos |
| Jacobo Kox       | Keyly Kox   |
| Pablo Motos      | Jone Jones  |
| Keyly Valenzuela | Pablo Motos |
+------------------+-------------+
7 rows in set (0,01 sec)
```
```SQL

-- 9. Devuelve un listado que muestre el nombre de cada empleados, el nombre
-- de su jefe y el nombre del jefe de sus jefe.

SELECT CONCAT(E.nombre,' ',E.apellido1) AS Empleado, CONCAT(J.nombre,' ',J.apellido1) AS Jefe, CONCAT(JJ.nombre,' ',JJ.apellido1) AS JefeDeJefes
FROM empleado AS E
INNER JOIN empleado AS J ON E.codigo_jefe = J.codigo_empleado
INNER JOIN empleado AS JJ ON J.codigo_jefe = JJ.codigo_empleado;
```
```
+------------------+-------------+-------------+
| Empleado         | Jefe        | JefeDeJefes |
+------------------+-------------+-------------+
| Samuel Ramirez   | Pablo Motos | Jone Jones  |
| Keyly Kox        | Pablo Motos | Jone Jones  |
| Jacobo Kox       | Keyly Kox   | Pablo Motos |
| Keyly Valenzuela | Pablo Motos | Jone Jones  |
+------------------+-------------+-------------+
4 rows in set (0,00 sec)
```
```SQL

-- 10. Devuelve el nombre de los clientes a los que no se les ha entregado a
-- tiempo un pedido.

SELECT C.nombre_cliente AS ClientePedidoTarde
FROM pedido AS P
INNER JOIN cliente AS C ON P.codigo_cliente = C.codigo_cliente
WHERE DATEDIFF(fecha_entrega,fecha_esperada)>1;
```
```
+--------------------+
| ClientePedidoTarde |
+--------------------+
| Carlos Fernández   |
| Marta Jiménez      |
| Marta Jiménez      |
+--------------------+
3 rows in set (0,00 sec)
```
```SQL

-- 11. Devuelve un listado de las diferentes gamas de producto que ha comprado
-- cada cliente.

SELECT PR.gama AS GamasProductoComprado
FROM pedido AS P
INNER JOIN detalle_pedido AS DP ON P.codigo_pedido = DP.codigo_pedido
INNER JOIN producto AS PR ON DP.codigo_producto = PR.codigo_producto
GROUP BY PR.gama;
```
```
+-----------------------+
| GamasProductoComprado |
+-----------------------+
| Frutales              |
| Ornamentales          |
+-----------------------+
2 rows in set (0,00 sec)
```
+ ## Consultas multitabla (Composición externa)

```SQL

-- 1. Devuelve un listado que muestre solamente los clientes que no han
-- realizado ningún pago.

SELECT C.nombre_cliente
FROM cliente AS C
WHERE C.codigo_cliente NOT IN(SELECT codigo_cliente FROM pago);
```
```
+------------------+
| nombre_cliente   |
+------------------+
| Pedro López      |
| Lucía García     |
| María Sánchez    |
| José Rodríguez   |
| Elena Gómez      |
| Francisco Díaz   |
| Luis Martínez    |
+------------------+
7 rows in set (0,00 sec)
```
```SQL

-- 2. Devuelve un listado que muestre solamente los clientes que no han
-- realizado ningún pedido.

SELECT C.nombre_cliente
FROM cliente AS C
WHERE C.codigo_cliente NOT IN(SELECT codigo_cliente FROM pedido);
```
```
+------------------+
| nombre_cliente   |
+------------------+
| Pedro López      |
| Lucía García     |
| María Sánchez    |
| José Rodríguez   |
| Elena Gómez      |
| Francisco Díaz   |
| Carmen Ruiz      |
| Luis Martínez    |
+------------------+
8 rows in set (0,00 sec)
```
```SQL
-- 3. Devuelve un listado que muestre los clientes que no han realizado ningún
-- pago y los que no han realizado ningún pedido.

SELECT C.nombre_cliente
FROM cliente AS C
WHERE C.codigo_cliente IS NOT (SELECT codigo_cliente FROM pago)
UNION
SELECT C.nombre_cliente
FROM cliente AS C
WHERE C.codigo_cliente IS NOT (SELECT codigo_cliente FROM pedido);
```
```

```