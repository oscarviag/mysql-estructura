CREATE DATABASE pizzeria DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

USE pizzeria;

CREATE TABLE provincia(
id_provincia INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
nom_provincia VARCHAR(20) NOT NULL
)ENGINE=InnoDB;

CREATE TABLE localitat(
id_localitat INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
nom_localitat VARCHAR(30) NOT NULL,
id_provincia INTEGER NOT NULL,
FOREIGN KEY (id_provincia) REFERENCES provincia(id_provincia)
)ENGINE=InnoDB;

CREATE TABLE client(
id_client INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
nom_client VARCHAR(20) NOT NULL,
adreca VARCHAR(50) NOT NULL,
codi_postal VARCHAR(9) NOT NULL,
id_localitat INTEGER NOT NULL,
telefon_client VARCHAR(9) NOT NULL,
FOREIGN KEY (id_localitat) REFERENCES localitat(id_localitat)
)ENGINE=InnoDB;

CREATE TABLE botiga(
id_botiga INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
id_localitat INTEGER NOT NULL,
adreca VARCHAR(20) NOT NULL,
codi_postal VARCHAR(9) NOT NULL
)ENGINE=InnoDB;

CREATE TABLE comanda(
id_comanda INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
id_client INTEGER NOT NULL,
data_comanda TIMESTAMP default NOW() ,
tipus_comanda ENUM('repartiment a domicili','recollir a botiga'),
q_pizzes INTEGER,
q_hamburgueses INTEGER,
q_begudes INTEGER,
preu_total FLOAT(2),
id_botiga INTEGER NOT NULL,
FOREIGN KEY (id_client) REFERENCES client(id_client),
FOREIGN KEY (id_botiga) REFERENCES botiga(id_botiga)
)ENGINE=InnoDB;

CREATE TABLE empleat(
id_empleat INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
nom_empleat VARCHAR(20) NOT NULL,
cognoms_empleat VARCHAR(20) NOT NULL,
nif_empleat VARCHAR(9) NOT NULL,
telefon_empleat VARCHAR(9) NOT NULL,
feina_empleat ENUM('cuiner','repartidor'),
id_botiga INTEGER NOT NULL,
FOREIGN KEY (id_botiga) REFERENCES botiga(id_botiga)
)ENGINE=InnoDB;

CREATE TABLE lliurament(
id_empleat INTEGER NOT NULL,
id_comanda INTEGER NOT NULL,
data_entrega DATETIME,
PRIMARY KEY (id_empleat, id_comanda),
FOREIGN KEY (id_comanda) REFERENCES comanda(id_comanda),
FOREIGN KEY (id_empleat) REFERENCES empleat(id_empleat)
)ENGINE=InnoDB;

CREATE TABLE categoria(
id_categoria INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
nom_categoria VARCHAR(20) NOT NULL
)ENGINE=InnoDB;

CREATE TABLE producte(
id_producte INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
nom_producte VARCHAR(40) NOT NULL,
descripcio_producte VARCHAR(50) NOT NULL,
imatge VARCHAR(50) NOT NULL,
preu FLOAT(2),
tipus_producte ENUM('pizza','hamburguesa', 'beguda')
)ENGINE=InnoDB;

CREATE TABLE productes_comanda(
id_comanda INTEGER NOT NULL,
id_producte INTEGER NOT NULL,
quantitat_producte INTEGER NOT NULL,
PRIMARY KEY (id_comanda, id_producte),
FOREIGN KEY (id_comanda) REFERENCES comanda(id_comanda),
FOREIGN KEY (id_producte) REFERENCES producte(id_producte)
)ENGINE=InnoDB;

CREATE TABLE pizza_categoria(
id_producte INTEGER NOT NULL,
id_categoria INTEGER NOT NULL,
PRIMARY KEY (id_categoria, id_producte),
FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria),
FOREIGN KEY (id_producte) REFERENCES producte(id_producte)
)ENGINE=InnoDB;

INSERT INTO provincia(nom_provincia) VALUES ('Barcelona'),
('Tarragona'),
('Lleida'),
('Girona');

INSERT INTO localitat(id_provincia, nom_localitat) VALUES (1,'Barcelona'),
(2, 'Tarragona'),
(3, 'Lleida'),
(4, 'Girona'),
(1, 'L\'Hospitalet de Llobregat'),
(1, 'Cornellà'),
(1, 'Badalona'),
(3, 'Mollerussa'),
(3, 'Guissona');

INSERT INTO client(nom_client, adreca, codi_postal, id_localitat, telefon_client) VALUES ('Oscar', 'Carrer Mallorca 55', '08013', 1, '537272'),
('Ramon', 'Carrer Girona 32', '08013', 1, '4535245'),
('Jordi', 'Carrer Valencia 67', '08012', 1, '87876'),
('Ariadna', 'Carrer Castillejos 23', '08014', 1, '234124'),
('Miquel', 'Carrer Roc i boronat 245', '08016', 1, '567956'),
('Guillem', 'Carrer del Call 25', '08516', 4, '9236334');

INSERT INTO botiga(id_localitat, adreca, codi_postal) VALUES (1,'Carrer Padilla 55', '08013'),
(1,'Carrer Corsega 155', '08014'),
(1,'Carrer Sardenya 34', '08016'),
(1,'Carrer Aragó 145', '08013'),
(4,'Carrer Fonadors 12', '08315'),
(4,'Carrer del Call 7', '08021');

INSERT INTO empleat(nom_empleat, cognoms_empleat, nif_empleat, telefon_empleat, feina_empleat, id_botiga) VALUES ('Ruben', 'Romero', '42524F', '5236272', 'repartidor', 1),
('Marta', 'Garcia', '32423G', '4523564', 'repartidor', 1),
('Elisenda', 'Lopez', '8754233K', '678969', 'cuiner', 1),
('Carles', 'Rodriguez', '234234C', '56785567', 'cuiner', 1),
('Pere', 'Gonzalez', '4555534V', '768568', 'repartidor', 5),
('David', 'Trias', '2352422S', '578576', 'cuiner', 5);

INSERT INTO categoria(nom_categoria) VALUES ('Vegetariana'),
('Picant'),
('D\'estiu'),
('Tot carn'),
('Sense Gluten');

INSERT INTO producte(nom_producte, descripcio_producte, imatge, preu, tipus_producte) VALUES ('Pizza vegetal', 'Perfecte pels vegetarians','c:\dasdas\adadsas.jpg',7.95,'pizza'),
('Pizza Quatre Estacions', 'Pizza molt gustosa','c:\dasdas\erewwe.jpg',7.95,'pizza'),
('Pizza Barbacoa', 'Pizza amb massa gruixuda','c:\dasdas\tuiui.jpg',7.95,'pizza'),
('Pizza Quatre formatges', 'Pizza aroma intens','c:\dasdas\uipp.jpg',7.95,'pizza'),
('Hamburguesa bacon i formatge', 'Carn de primera qualitat','c:\dasdas\qweqrw.jpg',7.95,'hamburguesa'),
('Hamburguesa complerta', 'Porta ou ferrat, becon, formatge, enciam, ceba','c:\dasdas\xzxzxz.jpg',7.95,'hamburguesa'),
('Vi', 'Vi de la casa','c:\dasdas\rioh.jpg',7.95,'beguda'),
('Aigua', 'Aigua del Pirineu','c:\dasdas\xchllui.jpg',0.95,'beguda'),
('Refresc', 'Refresc a triar','c:\dasdas\fwewew.jpg',1.95,'beguda');

INSERT INTO pizza_categoria(id_producte, id_categoria) VALUES (1,1), (2,3), (3,4), (4,5);

INSERT INTO comanda( id_client, tipus_comanda, q_pizzes, q_hamburgueses, q_begudes, preu_total, id_botiga) VALUES (1, 'repartiment a domicili',2,0,2,35.95,1),
(2,'recollir a botiga',0,2,2,15.95,2),
(1,'recollir a botiga',3,1,0,45.95,1),
(3,'repartiment a domicili',4,0,3,34.95,3),
(4,'recollir a botiga',3,2,5,57.90,4),
(1,'repartiment a domicili',1,1,2,19.90,1);

INSERT INTO productes_comanda(id_comanda, id_producte, quantitat_producte) VALUES (1,1,1),(1,2,1),(1,9,2),(2,4,2),(2,8,2),(3,3,3),(3,5,1),
(4,1,1),(4,2,2),(4,3,1),(4,8,2),(4,9,1),(5,1,1),(5,2,2),(5,6,2),(5,7,1),(5,8,2),(5,9,2),(6,2,1),(6,5,1),(6,8,1),(6,9,1);

INSERT INTO lliurament(id_empleat, id_comanda, data_entrega) VALUES (1,1,'2020-07-10 14:50:23'),(1,4,'2020-06-9 19:50:23'),(2,6,'2021-07-23 20:50:23');

SELECT SUM(productes_comanda.quantitat_producte) FROM producte, productes_comanda, comanda, botiga, localitat  WHERE producte.id_producte=productes_comanda.id_producte AND productes_comanda.id_comanda=comanda.id_comanda AND comanda.id_botiga=botiga.id_botiga AND botiga.id_localitat=localitat.id_localitat AND localitat.nom_localitat='Barcelona' AND producte.tipus_producte='beguda';
SELECT SUM(comanda.q_begudes) FROM comanda, botiga, localitat  WHERE comanda.id_botiga=botiga.id_botiga AND botiga.id_localitat=localitat.id_localitat AND localitat.nom_localitat='Barcelona';

SELECT COUNT(lliurament.id_empleat) FROM empleat, lliurament WHERE lliurament.id_empleat=empleat.id_empleat AND empleat.nom_empleat='Ruben' AND empleat.cognoms_empleat='Romero';