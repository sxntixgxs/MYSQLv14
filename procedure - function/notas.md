# Procedimientos almacenados

```SQL
CREATE TABLE productos(
    id INT NOT NULL AUTO_INCREMENT,
    producto VARCHAR(40) NOT NULL,
    cantidad INT NOT NULL,
    precio DECIMAL(19,2) NOT NULL,
    marca VARCHAR(20) NOT NULL,
    estado TINYINT,
    PRIMARY KEY(id)
);

DELIMITER $$
DROP PROCEDURE IF EXISTS insertar_producto;
CREATE PROCEDURE insertar_producto(
    IN producto VARCHAR(40),
    IN cantidad INT,
    IN precio DECIMAL(19,2),
    IN marca VARCHAR(20),
    IN estado TINYINT
)BEGIN
    INSERT INTO productos(id,producto,cantidad,precio,marca,estado) VALUES(
        NULL,producto,cantidad,precio,marca,estado
    );
END$$
DELIMITER //
```
Este procedimiento almacenado permite añadir valores a la tabla productos. Temas a destacar
+ DELIMITER $$ se recomienda usarlo siempre
+ DROP PROCEDURE IF EXISTSse verifica si existe el procedimiento y lo elimina
+ ARGUMENTOS **IN** son de entrada, datos que se deben pasar al invocar el procedimiento
+ **BEGIN** inicia la construcción del procedimiento almacenado; aquí se colocan todas las instrucciones que vamos a necesitar
+ Al finalizar se debe poner **DELIMITER ;** para volver a la normalidad

### Ejecutar Procedimiento Almacenado
```SQL
CALL insertar_producto('Monitor LCD',10,250.00,'LG',1);
```

### Creación PROCEDURE para facilitar consulta de un producto por ID
```SQL
DELIMITER $$
    DROP PROCEDURE IF EXISTS buscar_producto;
CREATE PROCEDURE buscar_producto(
    IN id INT
)
BEGIN 
    SELECT id,producto,(cantidad*precio) AS Subtotal FROM productos WHERE ID=id;
END $$
DELIMITER ;

CALL buscar_producto(1);
```
**Este sería un ejemplo de ese resultado al CALL buscar_producto(1);**
```
+------+-------------+----------+
| id   | producto    | Subtotal |
+------+-------------+----------+
|    1 | Monitor LCD |  2500.00 |
+------+-------------+----------+
1 row in set (0,00 sec)

Query OK, 0 rows affected (0,00 sec)
```

### Creación PROCEDURE insertar_producto_verify
+ **DECLARE** como solo lo vamos a llamar desde el SELECT se declara dentro del body del procedure
+ **ROW_COUNT** devuelve el numero de rows afectadas por la última instrucción
+ **SET** sirve para restablecer o asignar 'setear' un valor a una variable previamente creada


### Creación PRODCEDURE eliminar producto
+ **DELETE** para hacer el DELETE en vez de select por ejemplo

### Ejercicio crear PROCEDURE para retornar datos de todos los productos
```SQL

# Retornar todos los datos de todos los productos
DELIMITER $$
CREATE PROCEDURE mostrar_productos()
BEGIN
    SELECT producto FROM productos;
END $$
DELIMITER ;

CALL mostrar_productos();
```
```
+-------------+
| producto    |
+-------------+
| Monitor LCD |
| Alpha plus  |
| Alpha plus  |
| Alpha plus  |
+-------------+
4 rows in set (0,00 sec)

Query OK, 0 rows affected (0,00 sec)
```

## PROCEDURE para actualizar algún producto
```SQL

DELIMITER $$
DROP PROCEDURE IF EXISTS actualizar_producto;
CREATE PROCEDURE actualizar_producto(
    IN producto_id INT,
    IN nuevo_producto VARCHAR(40),
    IN nueva_cantidad INT,
    IN nuevo_precio DECIMAL(19,2),
    IN nueva_marca VARCHAR(20),
    IN nuevo_estado TINYINT
)
BEGIN
    DECLARE mensaje VARCHAR(100);
    UPDATE productos
    SET producto = nuevo_producto, cantidad = nueva_cantidad, precio = nuevo_precio, marca = nueva_marca, estado = nuevo_estado
    WHERE id = producto_id;
    IF ROW_COUNT()>0 THEN
        SET mensaje = 'Producto actualizado';
    ELSE 
        SET mensaje = 'No se encontró ningún producto con el ID proporcionado';
    END IF;
    SELECT mensaje AS 'Mensaje';
    SELECT * FROM productos WHERE id = producto_id;
END $$
DELIMITER ;

CALL actualizar_producto(3,'Iphone 15 Pro Max',20,1000.00,'Iphone',1);
```
```
+----------------------+
| Mensaje              |
+----------------------+
| Producto actualizado |
+----------------------+
1 row in set (0,00 sec)

+----+-------------------+----------+---------+--------+--------+
| id | producto          | cantidad | precio  | marca  | estado |
+----+-------------------+----------+---------+--------+--------+
|  3 | Iphone 15 Pro Max |       20 | 1000.00 | Iphone |      1 |
+----+-------------------+----------+---------+--------+--------+
1 row in set (0,00 sec)

Query OK, 0 rows affected (0,00 sec)
```
### PROCEDURE para mostrar la cantidad disponible de un producto específico
+ se **DECLARA** cantidad_disponible para asegurarnos que vamos a seleccionar al final un valor escalar y no una fila de datos
+ Luego de crear cantidad_disponible hacemos una consulta donde el resultado lo ponemos dentro de esa variable con **INTO**

```SQL
DELIMITER $$
DROP PROCEDURE IF EXISTS cantidad_producto;
CREATE PROCEDURE cantidad_producto(
    IN id_producto INT
)
BEGIN 
    DECLARE cantidad_disponible INT;
    SELECT cantidad INTO cantidad_disponible
    FROM productos 
    WHERE id = id_producto;
    SELECT cantidad_disponible AS 'Cantidad disponible del producto';
END $$
DELIMITER ;
CALL cantidad_producto(3);
```
```
+----------------------------------+
| Cantidad disponible del producto |
+----------------------------------+
|                               20 |
+----------------------------------+
1 row in set (0,00 sec)

Query OK, 0 rows affected (0,00 sec)
```
### PROCEDURE para cantidad de elementos o registros de una determinada marca con TABLA TEMPORAL
+ **VISTAS** tablas de solo lectura
+ **TABLAS TEMPORALES** se puede modificar
+ **INSERT INTO** cuando se insertan los valores no hace falta poner el values porque es una tabla temporal y me permite enviarle una consulta como INSERT INTO SELECT ...
```SQL
DELIMITER $$
CREATE PROCEDURE obtener_total_registros_por_marca_temp()
BEGIN 
-- Crear una tabla temporal para almacenar los resultados
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_resultados(
        marca VARCHAR(20),
        total_registros INT
    );
-- Insertar los resultados en una tabla temporal
    INSERT INTO temp_resultados (marca, total_registros)
    SELECT marca, COUNT(*) AS total_registros
    FROM productos
    GROUP BY marca;
-- Seleccionar los resultados de la tabla temporal
    SELECT * FROM temp_resultados;
END $$
DELIMITER ;
CALL obtener_total_registros_por_marca_temp();
```
```
+--------+-----------------+
| marca  | total_registros |
+--------+-----------------+
| LG     |               1 |
| Biomax |               2 |
| Iphone |               1 |
+--------+-----------------+
3 rows in set (0,00 sec)

Query OK, 0 rows affected (0,00 sec)
```