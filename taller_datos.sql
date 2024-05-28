INSERT INTO gama_producto(gama,descripcion_texto,descripcion_html,imagen) VALUES
('Ornamentales','Los ornamentos son aquellos adornos o atavíos que permiten decorar una cosa y hacerla más vistosa.','',''),
('Frutales','Los productos frutales son los frutos que se obtienen de plantas y árboles frutales. Estos productos son una parte fundamental de la alimentación humana debido a su contenido nutricional, que incluye vitaminas, minerales, fibra y antioxidantes.','','');

INSERT INTO proveedor(idProveedor,nombre) VALUES
(1,"UnitedFruit Company"),
(2,"Ornamented Products");

INSERT INTO pais(idPais,nombre) VALUES
(1,"United States"),
(2,"España");

INSERT INTO region(idRegion,nombre,idPais) VALUES 
(1,'Comunidad de Madrid',2),
(2,'Northeastern',1),

INSERT INTO ciudad(idCiudad, nombre, idPais, idRegion) VALUES
(1,"Madrid",2,1),
(2,'Fuenlabrada',2,1),
(3,'New York',1,2);

INSERT INTO codigo_postal(zip_code,idCiudad) VALUES 
('28001',1),
('28002',1),
('28936',2),
('28940',2),
('10001',3),
('10002',3);

INSERT INTO oficina(codigo_oficina,zip_code,telefono,linea_direccion1) VALUES
('3302','28001','+326601252','Calle Doctores 23'),
('3301','28001','+326603252','Calle Doctores 25'),
('3311','28001','+326301252','Calle Doctores 24'),
('3402','28002','+322601252','Calle de Alcala 3'),
('3401','28002','+326603212','Calle de Alcala 34'),
('3411','28002','+326301251','Calle de Alcala 6'),
('2402','28936','+322611152','Calle de Leganes 13'),
('2401','28936','+326603552','Calle de Leganes 21'),
('2411','28936','+326301451','Calle de Leganes 4'),
('1402','10001','+122611152','299 Park Ave'),
('1401','10001','+124603552','190 Park Ave'),
('1411','10001','+136301451','159 Park Ave'),

