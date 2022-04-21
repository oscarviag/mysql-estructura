CREATE DATABASE optica DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

USE optica;

CREATE TABLE client(
id_client INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
nom_client VARCHAR(20) NOT NULL,
carrer VARCHAR(20) NOT NULL,
numero_carrer VARCHAR(5) NOT NULL,
pis VARCHAR(20) NOT NULL,
porta VARCHAR(20) NOT NULL,
ciutat VARCHAR(20) NOT NULL,
codi_postal VARCHAR(20) NOT NULL,
pais VARCHAR(20) NOT NULL,
telefon VARCHAR(20) NOT NULL,
email VARCHAR(20) NOT NULL,
data_registre TIMESTAMP default NOW() ,
id_client_recomana INTEGER
)ENGINE=InnoDB;

CREATE TABLE proveidor(
id_proveidor INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
nom_proveidor VARCHAR(20) NOT NULL,
carrer VARCHAR(20) NOT NULL,
numero_carrer VARCHAR(5) NOT NULL,
pis VARCHAR(20) NOT NULL,
porta VARCHAR(20) NOT NULL,
ciutat VARCHAR(20) NOT NULL,
codi_postal VARCHAR(20) NOT NULL,
pais VARCHAR(20) NOT NULL,
telefon VARCHAR(20) NOT NULL,
fax VARCHAR(20) NOT NULL,
nif VARCHAR(20) NOT NULL
)ENGINE=InnoDB;

CREATE TABLE venedor(
id_venedor INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
nom_venedor VARCHAR(20)
)ENGINE=InnoDB;

CREATE TABLE marca(
id_marca INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
id_proveidor INTEGER NOT NULL ,
nom_marca VARCHAR(20),
FOREIGN KEY (id_proveidor) REFERENCES proveidor(id_proveidor)
)ENGINE=InnoDB;

CREATE TABLE ullera(
id_ullera INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
id_marca INTEGER NOT NULL,
preu FLOAT NOT NULL,
FOREIGN KEY (id_marca) REFERENCES marca(id_marca)
)ENGINE=InnoDB;

CREATE TABLE venda(
id_factura INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
id_client INTEGER NOT NULL,
id_venedor INTEGER NOT NULL,
id_ullera INTEGER NOT NULL,
data_venda DATE,
graduacio_esq FLOAT(2),
graduacio_dret FLOAT(2), 
tipus_montura enum('flotant','pasta','metal.lica'),
color_montura VARCHAR(20) NOT NULL,
color_vidre_esq VARCHAR(20) NOT NULL,
color_vidre_dret VARCHAR(20) NOT NULL,
pvp FLOAT(2),
FOREIGN KEY (id_client) REFERENCES client(id_client),
FOREIGN KEY (id_venedor) REFERENCES venedor(id_venedor),
FOREIGN KEY (id_ullera) REFERENCES ullera(id_ullera)
)ENGINE=InnoDB;

INSERT INTO client (nom_client, carrer, numero_carrer, pis, porta, ciutat, codi_postal, pais, telefon, email, id_client_recomana) VALUES ('Oscar', 'Mallorca', '89', '1', '5', 'Barcelona', '08013','Espanya','4434836','oscar@gmail.com', null),
('Ramon', 'Corsega', '8', '2', '2', 'Barcelona', '08013','Espanya','89358399','ramon@gmail.com', null),
('Elisenda', 'Sardenya', '126', '7', '1A', 'Barcelona', '08012','Espanya','637829765','eli@hotmail.com', 1),
('Marta', 'Compte Borrell', '34', '11', '7', 'Barcelona', '08016','Espanya','45378292','marta@yahoo.com', 3),
('Sonia', 'Diputacio', '321', '3', '2', 'Barcelona', '08014','Espanya','52382924','sonia@hotmail.com', null),
('Ruben', 'Lepant', '9', 'PB', '1', 'Barcelona', '08013','Espanya','65839348','ruben@gmail.com', 5);

INSERT INTO proveidor(nom_proveidor, carrer, numero_carrer, pis, porta, ciutat, codi_postal, pais, telefon, fax, nif) VALUES ('Gafas Guai', 'Corsega', '8', '2', '2', 'Barcelona', '08013','Espanya','89358399','89358399', '89358399D'),
('Ulleres Pro', 'Corsega', '8', '2', '2', 'Barcelona', '08013','Espanya','89358399','89358399','2358399F'),
('Distri Optics', 'Sardenya', '126', '7', '1A', 'Barcelona', '08012','Espanya','637829765','637829765','829765G'),
('Optiques Associades', 'Compte Borrell', '34', '11', '7', 'Barcelona', '08016','Espanya','45378292','45378292','378292S'),
('Proveidors Serveis', 'Diputacio', '321', '3', '2', 'Barcelona', '08014','Espanya','52382924','52382924','82924Q'),
('Ulleres Pro', 'Lepant', '9', 'PB', '1', 'Barcelona', '08013','Espanya','65839348','65839348','39348F');

INSERT INTO venedor(nom_venedor) VALUES ('Ramon'),
('Llluis'),
('Ricard'),
('Natalia'),
('Alicia');

INSERT INTO marca(id_proveidor, nom_marca) VALUES (1, 'Rayban'),
(3, 'Oakley'),
(5, 'Afflelou'),
(2, 'Rayban'),
(1, 'Carrera');

INSERT INTO ullera(id_marca, preu) VALUES (3, 139.77),
(3, 54.99),
(1, 149.95),
(2, 89.95),
(5, 49.95);

INSERT INTO venda(id_client, id_venedor, id_ullera, data_venda, graduacio_esq, graduacio_dret, tipus_montura, color_montura, color_vidre_esq, color_vidre_dret, pvp) VALUES (1, 1, 1, '2019-06-25', 2.5 ,1.3 , 'pasta' , 'verd', 'transparent', 'transparent', 139.95),
(2, 1, 3, '2019-08-2', 2.5 ,1.3 , 'pasta' , 'negre', 'transparent', 'transparent', 139.95),
(1, 2, 2, '2019-07-25', 2.5 ,1.3 , 'pasta' , 'blau', 'groc', 'groc', 19.95),
(3, 1, 3, '2020-02-2', 1.5 ,0.3 , 'metal.lica' , 'groc', 'negre', 'negre', 49.95),
(4, 2, 1, '2021-03-3', 2.0 ,1.4 , 'pasta' , 'crom', 'transparent', 'transparent', 79.95),
(2, 3, 4, '2021-07-30', 2.4 ,2.5 , 'pasta' , 'negre', 'groc', 'groc', 199.95),
(1, 1, 3, '2022-06-17', 1.5 ,0.7 , 'pasta' , 'daurat', 'transparent', 'transparent', 149.95);

SELECT COUNT(id_factura)  FROM venda, client WHERE venda.id_client=client.id_client AND client.nom_client='Oscar' AND  (data_venda BETWEEN "2019-01-01" AND "2020-12-01");
SELECT ullera.id_ullera AS 'Model Ullera'  FROM ullera, venda, venedor WHERE ullera.id_ullera=venda.id_ullera AND venda.id_venedor=venedor.id_venedor AND venedor.nom_venedor='Ramon' AND  (data_venda BETWEEN "2019-01-01" AND "2019-12-31");
SELECT DISTINCT proveidor.nom_proveidor FROM proveidor, marca, ullera, venda WHERE proveidor.id_proveidor=marca.id_proveidor AND marca.id_marca=ullera.id_marca AND ullera.id_ullera=venda.id_ullera;
