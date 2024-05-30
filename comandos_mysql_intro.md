# Intro DB MySQL

+ Componentes
    + Servidor - Puerto default 3306
    + Cliente
        + admin, dump, check
+ Motores
    + MyISAM - archivos indexados
        + .frm, .MYD, .MYI archivos que se crean por tabla(?)
    + InnoDB - DB transaccionales - operaciones que se tratan como CRUD

+ MySQL está configurado no como una app sino como un servicio
# Cómo acceder y usar MYSQL desde su terminal
1. Verificar que esté en ejecución desde servicios del sistema
1. **mysql -p -u root** y de esta forma pide la contraseña con -p. Sin embargo, en campus en vez de acceder con -u root accede con -u campus2023 y la -p también es campus2023

+ Es recomendado tener un bloc de notas abierto para poder "equivocarse" al enviar bastante info, por ejemplo en la creación de tablas ya que en la consola no es muy facil editar la información

## Mostrar DB
```
mysql> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| ejemplo            |
| ejercicio          |
| garden_DB          |
| information_schema |
| mysql              |
| nuevaEps           |
| performance_schema |
| sakilacampus       |
| sys                |
| taller             |
| universidad_DB     |
+--------------------+
11 rows in set (0,00 sec)
```

## Create DB
```
mysql> CREATE SCHEMA inventario
    -> ;
Query OK, 1 row affected (0,01 sec)
```
```SQL
CREATE TABLE pais(
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50),
    -- es recomendable usar constraint 
    CONSTRAINT PK_pais_id PRIMARY KEY (id)
);
CREATE TABLE region(
    id INT AUTO_INCREMENT,
    nombre VARCHAR(50),
    idpais INT(11), -- Es recomendable poner la longitud del INT 11
    CONSTRAINT PK_region_id PRIMARY KEY(id),
    CONSTRAINT FK_pais_region_id FOREIGN KEY (idpais) REFERENCES pais(id)-- equivale a FOREIGN KEY (idpais) REFERENCES pais(id)
);
CREATE TABLE ciudad(
    id INT AUTO_INCREMENT,
    nombre VARCHAR(50),
    idregion INT(11),
    CONSTRAINT PK_ciudad_id PRIMARY KEY (id),
    CONSTRAINT FK_region_ciudad_id FOREIGN KEY (idregion) REFERENCES region(id)
);

-- Para ver la estructura de una tabla se usa DESCRIBE nombretabla;
DESCRIBE ciudad;

INSERT INTO pais (nombre) VALUES
("United States of America"),
("England"),
("France");

INSERT INTO region (nombre,idpais) VALUES
("West",4),
("South",4),
('Northeast',4),
('North East',5),
('Yorkshire and the Humber',5),
('London',5),
('Aquitaine',6),
('Brittany',6),
('Lorraine',6);

INSERT INTO ciudad(nombre,idregion) VALUES
('San Francisco',1),
('Los Angeles',1),
('Salt Lake City',1),
('Atlanta',2),
('New Orlans',2),
('Memphis',2),
('New York',3),
('Chicago',3),
('Detroit',3),
('Newcastle Upon Tyne',4),
('Sunderland',4),
('Middlesbrough',4),
('York',5),
('Leeds',5),
('Sheffield',5),
('London City',6),
('Greenwich',6),
('Chelsea',6),
('Bordeaux',7),
('Limoges',7),
('Pau',7),
('Saint-Malo',8),
('Lorient',8),
('Rennes',8),
('Nancy',9),
('Metz',9),
('Rodemack',9);
```

## Methods (?)
+ UPDATE
```SQL
UPDATE nombretabla
SET campo = "nuevoValor"
WHERE condicion
```
+ DELETE 
```SQL
DELETE FROM nombretabla WHERE condicion
```

## Regiones de Francia que inician con A
```SQL
SELECT R.nombre
FROM pais P 
INNER JOIN region R ON P.id = R.idpais
WHERE R.nombre LIKE 'A%';
```