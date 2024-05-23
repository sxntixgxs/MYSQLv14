# Escenario del proyecto:

Usted es una pequeña empresa de consultoría especializada en el desarrollo de bases de datos. Le acaban de adjudicar un contrato para desarrollar un modelo de datos para un sistema de aplicaciones de bases de datos de una pequeña tienda denominada Oracle Baseball League (OBL).

La tienda ofrece servicios de venta de conjuntos de béisbol para toda la comunidad. OBL tiene dos tipos de cliente; hay personas que no pueden adquirir artículos como pelotas, zapatillas, guantes, camisas, camisetas serigrafiadas y pantalones. Además, los clientes pueden representar a un equipo cuando adquieren uniformes y equipación conjunta.

Los equipos y los clientes individuales son libres de comprar cualquier artículo de la lista de inventario, pero los equipos obtienen un descuento en el precio de lista según el número de jugadores. Cuando un cliente realiza un pedido, registramos los artículos de ese pedido en nuestra base de datos.

El equipo de OBL cuenta con tres representantes de ventas que oficialmente solo atienden a equipos, pero se sabe que gestionan las quejas de los clientes individuales.

## Modelo conceptual

    + equipo   
    + pedido 
    + cliente
    + articulo
    + representante

## Modelo lógico

+ ERD tablas, relaciones y cardinalidad
## Normalización
+ **1FN** Unico valor
+ **2FN** atributos dependen únicamente de de su PK, sino va en otra tabla
+ **3FN** tablas intermedias y llevar las FK

## Consultas
+ Es recomendado no usar * en un query porque consume mucho más caché que poner los nombres de las columnas



