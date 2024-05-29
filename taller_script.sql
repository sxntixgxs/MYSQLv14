    DROP SCHEMA taller;
    CREATE SCHEMA taller;

    USE taller;

    CREATE TABLE IF NOT EXISTS gama_producto(
        gama VARCHAR(50) PRIMARY KEY,
        descripcion_texto TEXT,
        descripcion_html TEXT,
        imagen VARCHAR(255)
    );

    CREATE TABLE IF NOT EXISTS proveedor(
        idProveedor INT PRIMARY KEY,
        nombre VARCHAR(50)
    );

    CREATE TABLE IF NOT EXISTS pais(
        idPais INT PRIMARY KEY,
        nombre VARCHAR(50)
    );

    CREATE TABLE IF NOT EXISTS region(
        idRegion INT PRIMARY KEY,
        nombre VARCHAR(50),
        idPais INT,
        FOREIGN KEY (idPais) REFERENCES pais(idPais)
    );

    CREATE TABLE IF NOT EXISTS ciudad(
        idCiudad INT PRIMARY KEY,
        nombre VARCHAR(50),
        idPais INT NOT NULL,
        idRegion INT,
        FOREIGN KEY (idPais) REFERENCES pais(idPais),
        FOREIGN KEY (idRegion) REFERENCES region(idRegion)
    );

    CREATE TABLE IF NOT EXISTS codigo_postal(
        zip_code VARCHAR(10) PRIMARY KEY,
        idCiudad INT NOT NULL,
        FOREIGN KEY (idCiudad) REFERENCES ciudad(idCiudad)
    );

    CREATE TABLE IF NOT EXISTS oficina(
        codigo_oficina VARCHAR(10) PRIMARY KEY,
        zip_code VARCHAR(10) NOT NULL,
        idCiudad INT NOT NULL,
        telefono VARCHAR(20) NOT NULL,
        linea_direccion1 VARCHAR(50) NOT NULL,
        linea_direccion2 VARCHAR(50),
        FOREIGN KEY (zip_code) REFERENCES codigo_postal(zip_code),
        FOREIGN KEY (idCiudad) REFERENCES ciudad(idCiudad)
    );

    CREATE TABLE IF NOT EXISTS puesto(
        id INT PRIMARY KEY,
        nombre VARCHAR(50)
    );

    CREATE TABLE IF NOT EXISTS empleado(
        codigo_empleado INT PRIMARY KEY,
        nombre VARCHAR(50) NOT NULL,
        apellido1 VARCHAR(50) NOT NULL,
        apellido2 VARCHAR(50),
        extension VARCHAR(10) NOT NULL,
        email VARCHAR(100) NOT NULL,
        codigo_oficina VARCHAR(10) NOT NULL,
        codigo_jefe INT,
        idPuesto INT,
        FOREIGN KEY (codigo_oficina) REFERENCES oficina(codigo_oficina),
        FOREIGN KEY (codigo_jefe) REFERENCES empleado(codigo_empleado),
        FOREIGN KEY (idPuesto) REFERENCES puesto(id)
    );

    CREATE TABLE IF NOT EXISTS producto(
        codigo_producto VARCHAR(15) PRIMARY KEY,
        nombre VARCHAR(70) NOT NULL,
        gama VARCHAR(50) NOT NULL,
        dimensiones VARCHAR(25),
        idProveedor INT,
        descripcion TEXT,
        cantidad_en_stock SMALLINT(6) NOT NULL,
        precio_venta DECIMAL(15,2) NOT NULL,
        precio_proveedor DECIMAL(15,2),
        FOREIGN KEY (gama) REFERENCES gama_producto(gama),
        FOREIGN KEY (idProveedor) REFERENCES proveedor(idProveedor)
    );


    CREATE TABLE IF NOT EXISTS cliente(
        codigo_cliente INT PRIMARY KEY,
        nombre_cliente VARCHAR(50) NOT NULL,
        nombre_contacto VARCHAR(30),
        apellido_contacto VARCHAR(30),
        telefono VARCHAR(15) NOT NULL,
        fax VARCHAR(15) NOT NULL,
        linea_direccion1 VARCHAR(50) NOT NULL,
        linea_direccion2 VARCHAR(50),
        idCiudad INT NOT NULL,
        zip_code VARCHAR(10),
        codigo_empleado_rep_ventas INT,
        limite_credito DECIMAL(15,2),
        FOREIGN KEY (idCiudad) REFERENCES ciudad(idCiudad),
        FOREIGN KEY (zip_code) REFERENCES codigo_postal(zip_code),
        FOREIGN KEY (codigo_empleado_rep_ventas) REFERENCES empleado(codigo_empleado)
    );

    CREATE TABLE IF NOT EXISTS forma_pago(
        id INT PRIMARY KEY,
        nombre VARCHAR(40)
    );

    CREATE TABLE IF NOT EXISTS pago(
        codigo_cliente INT NOT NULL,
        idFormaPago INT NOT NULL,
        id_transaccion VARCHAR(50) PRIMARY KEY,
        fecha_pago DATE NOT NULL,
        total DECIMAL(15,2) NOT NULL,
        FOREIGN KEY (idFormaPago) REFERENCES forma_pago(id)
    );

    CREATE TABLE IF NOT EXISTS estado(
        id INT PRIMARY KEY,
        nombre VARCHAR(15)
    );

    CREATE TABLE IF NOT EXISTS pedido(
        codigo_pedido INT PRIMARY KEY,
        fecha_pedido DATE NOT NULL,
        fecha_esperada DATE NOT NULL,
        fecha_entrega DATE,
        idEstado INT NOT NULL,
        comentarios TEXT,
        codigo_cliente INT,
        FOREIGN KEY (idEstado) REFERENCES estado(id),
        FOREIGN KEY (codigo_cliente) REFERENCES cliente(codigo_cliente)
    );

    CREATE TABLE IF NOT EXISTS detalle_pedido(
        codigo_pedido INT NOT NULL,
        codigo_producto VARCHAR(15) NOT NULL,
        cantidad INT NOT NULL,
        precio_unidad DECIMAL(15,2),
        numero_linea SMALLINT(6) NOT NULL,
        PRIMARY KEY (codigo_pedido,codigo_producto),
        FOREIGN KEY (codigo_pedido) REFERENCES pedido(codigo_pedido),
        FOREIGN KEY (codigo_producto) REFERENCES producto(codigo_producto)
    );