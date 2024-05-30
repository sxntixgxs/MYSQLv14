# Taller DBGarden

## Dev by Santiago Sandoval

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