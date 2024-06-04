### PROCEDIMIENTOS ALMACENADOS

DROP SCHEMA prodAlm;
CREATE SCHEMA prodAlm;
USE prodAlm;
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
END $$
DELIMITER ;

CALL insertar_producto('Monitor LCD',10,250.00,'LG',1);



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

DELIMITER $$
DROP PROCEDURE IF EXISTS insertar_producto_verify;
CREATE PROCEDURE insertar_producto_verify(
    IN producto VARCHAR(40),
    IN cantidad INT,
    IN precio DECIMAL(19,2),
    IN marca VARCHAR(20),
    IN estado TINYINT
)
BEGIN
    DECLARE mensaje VARCHAR(100);
    INSERT INTO productos(id,producto,cantidad,precio,marca,estado)
    VALUES(NULL,producto,cantidad,precio,marca,estado);
    IF ROW_COUNT() > 0 THEN
        SET mensaje = 'El registro se ha creado correctamente';
    ELSE 
        SET mensaje = 'Error al crear el registro';
    END IF;
    SELECT mensaje AS 'Mensaje';
END $$
DELIMITER ;
CALL insertar_producto_verify('Alpha plus',30,480.00,'Biomax',1);


DELIMITER $$
CREATE PROCEDURE eliminar_producto(
    IN producto_id INT
)
BEGIN 
    DECLARE mensaje VARCHAR(100);
    DELETE FROM prodcutos WHERE id=producto_id;
    IF ROW_COUNT()>0 THEN
        SET mensaje = CONCAT('El producto con ID', producto_id,' ha sido eliminado exitosamente');
    ELSE 
        SET mensaje = 'No se encontró ningún producto con el ID proporcionado';
    END IF;
    SELECT mensaje AS 'Mensaje';
END $$
DELIMITER ;


# Retornar todos los datos de todos los productos
DELIMITER $$
CREATE PROCEDURE mostrar_productos()
BEGIN
    SELECT producto FROM productos;
END $$
DELIMITER ;

CALL mostrar_productos();


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


DELIMITER  $$
DROP PROCEDURE IF EXISTS obtener_cantidad_productos_por_marca;
CREATE PROCEDURE obtener_cantidad_productos_por_marca(
    IN marca_buscada VARCHAR(20)
)
BEGIN
    DECLARE cantidad_productos INT;
    SELECT COUNT(*) INTO cantidad_productos_productos
    FROM productos
    WHERE marca = marca_buscada;
    SELECT cantidad_productos AS 'Cantidad de productos';
END $$
DELIMITER ;

## Crear procedure que permita mostrar cantidad disponible de un producto

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