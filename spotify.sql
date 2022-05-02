CREATE DATABASE spotify DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

USE spotify;

CREATE TABLE IF NOT EXISTS usuari
(
    id_usuari INT NOT NULL AUTO_INCREMENT,
    email VARCHAR(25) NOT NULL,
    password VARCHAR(10) NOT NULL,
    nom_usuari VARCHAR(15) NOT NULL,
    data_naixement DATE NOT NULL,
    sexe VARCHAR(1) NOT NULL,
    pais VARCHAR(25) NOT NULL,
    codi_postal VARCHAR(9) NOT NULL,
    tipus_usuari ENUM('free','premium') NOT NULL,
    PRIMARY KEY(id_usuari)
);

CREATE TABLE IF NOT EXISTS premium
(
    id_usuari INT NOT NULL,
    data_inici DATE NOT NULL,
    data_renovacio DATE NOT NULL,
    forma_pagament ENUM('targeta','paypal') NOT NULL,
	FOREIGN KEY (id_usuari) REFERENCES usuari(id_usuari)
);

CREATE TABLE IF NOT EXISTS targeta
(
    numero_targeta INT NOT NULL,
    mes INT NOT NULL,
    any INT NOT NULL,
    codi_seguretat INT NOT NULL,
    id_usuari INT NOT NULL,
    FOREIGN KEY (id_usuari) REFERENCES usuari(id_usuari)
);

CREATE TABLE IF NOT EXISTS paypal
(
    nom_usuari_paypal VARCHAR(25) NOT NULL,
    id_usuari INT NOT NULL,
    FOREIGN KEY (id_usuari) REFERENCES usuari(id_usuari)
);

CREATE TABLE IF NOT EXISTS pagament
(
    id_usuari INT NOT NULL,
    data_pagament DATE NOT NULL,
    id_ordre INT NOT NULL AUTO_INCREMENT,
    total FLOAT(2) NOT NULL,
    PRIMARY KEY(id_ordre),
    FOREIGN KEY (id_usuari) REFERENCES usuari(id_usuari)
);


CREATE TABLE IF NOT EXISTS playlist
(
    id_playlist INT NOT NULL AUTO_INCREMENT,
    titol VARCHAR(25) NOT NULL,
    nombre_cancons INT NOT NULL,
    data_creacio DATE NOT NULL,
    id_usuari INT NOT NULL,
    PRIMARY KEY(id_playlist),
    FOREIGN KEY (id_usuari) REFERENCES usuari(id_usuari)
);

CREATE TABLE IF NOT EXISTS playlist_eliminada
(
    id_playlist INT NOT NULL,
    data_eliminacio DATE NOT NULL,
    FOREIGN KEY (id_playlist) REFERENCES playlist(id_playlist)
);

CREATE TABLE IF NOT EXISTS artista
(
    id_artista INT NOT NULL AUTO_INCREMENT,
    nom VARCHAR(25),
    imatge_artista VARCHAR(35),
    PRIMARY KEY(id_artista)
);

CREATE TABLE IF NOT EXISTS album
(
    id_album INT NOT NULL AUTO_INCREMENT,
    titol VARCHAR(35),
    any_publicacio VARCHAR(4),
    imatge_portada VARCHAR(35),
    id_artista INT NOT NULL,
    PRIMARY KEY(id_album),
    FOREIGN KEY (id_artista) REFERENCES artista(id_artista)
);

CREATE TABLE IF NOT EXISTS canco
(
    id_canco INT NOT NULL AUTO_INCREMENT,
    titol VARCHAR(25) NOT NULL,
    durada FLOAT(2) NOT NULL,
    reproduccions INT NOT NULL,
    id_album INT NOT NULL,
    PRIMARY KEY(id_canco),
    FOREIGN KEY (id_album) REFERENCES album(id_album)
);

CREATE TABLE IF NOT EXISTS cancons_playlist
(
    id_playlist INT NOT NULL,
    id_canco INT NOT NULL,
    id_usuari INT NOT NULL,
    data_afegit DATE,
    FOREIGN KEY (id_playlist) REFERENCES playlist(id_playlist),
    FOREIGN KEY (id_canco) REFERENCES canco(id_canco),
    FOREIGN KEY (id_usuari) REFERENCES usuari(id_usuari)
);

CREATE TABLE IF NOT EXISTS seguiment_artistes
(
    id_usuari INT NOT NULL,
    id_artista INT NOT NULL,
    PRIMARY KEY(id_usuari, id_artista),
    FOREIGN KEY (id_usuari) REFERENCES usuari(id_usuari),
    FOREIGN KEY (id_artista) REFERENCES artista(id_artista)
);

CREATE TABLE IF NOT EXISTS relacio_artistes
(
    id_artista INT NOT NULL,
    id_artista_semblant INT  NOT NULL,
    FOREIGN KEY (id_artista_semblant) REFERENCES artista(id_artista),
    FOREIGN KEY (id_artista) REFERENCES artista(id_artista)
);

CREATE TABLE IF NOT EXISTS cancons_favorites
(
    id_canco INT NOT NULL,
    id_usuari INT,
    PRIMARY KEY(id_canco, id_usuari),
    FOREIGN KEY (id_canco) REFERENCES canco(id_canco),
    FOREIGN KEY (id_usuari) REFERENCES usuari(id_usuari)
);

CREATE TABLE IF NOT EXISTS albums_favorits
(
    id_album INT NOT NULL,
    id_usuari INT NOT NULL,
    FOREIGN KEY (id_album) REFERENCES album(id_album),
    FOREIGN KEY (id_usuari) REFERENCES usuari(id_usuari)
);

INSERT INTO usuari(email, password, nom_usuari, data_naixement, sexe, pais, codi_postal, tipus_usuari) VALUES ('rata@hotmail.com','123456','rata','2006-10-2','H','Espanya','08012', 'premium'),
('gos@hotmail.com','123456','gos','2006-10-2','H','Espanya','08016', 'premium'),
('gat@hotmail.com','098765','gat','2006-10-2','D','Espanya','08013', 'premium'),
('ruc@hotmail.com','qwerty','ruc','2006-10-2','D','Espanya','09018', 'free'),
('serp@hotmail.com','dfghjh','serp','2006-10-2','H','Espanya','09021','free');  

INSERT INTO premium(id_usuari, data_inici, data_renovacio, forma_pagament) VALUES (1, '2020-10-2', '2022-9-8', 'targeta'),
(2, '2021-10-2', '2022-10-2', 'paypal'),
(3, '2022-2-4', '2022-10-4', 'targeta');

INSERT INTO targeta (numero_targeta, mes, any, codi_seguretat, id_usuari) VALUE ('242342342','02','22',789, 1),
('52154423','05','26',362, 3);

INSERT INTO paypal(nom_usuari_paypal, id_usuari) VALUE ('gos@hotmail.com', 2);

INSERT INTO pagament(id_usuari, data_pagament, total) VALUE (1, '2021-10-2', 13.95),
(2, '2021-12-4', 15.95),
(3, '2022-03-18', 18.95);

INSERT INTO artista(nom, imatge_artista) value('Prince', 'c:\\sdfadsfas\\dfsdaf.jpg'),
('Antonia Font', 'c:\\qqwwqe\\dfsdaf.jpg'),
('Suu', 'c:\\b,b,m.m\\QEQE.jpg'),
('Zoo', 'c:\\oiñoiit\\dfsEWQEWdaf.jpg'),
('Txarango', 'c:\\ASQ	W\\EQEEQ.jpg');

INSERT INTO album(titol, any_publicacio, imatge_portada, id_artista) value('Natural', '2018', 'c:\rwewqrqewr.jpg', 3),
('Ventura', '2020', 'c:\adsfaewrew.jpg', 3),
('Llepolies', '2021', 'c:\vcncmbm.jpg', 3),
('Omertà', '2018', 'c:\werw.jpg', 3),
('El cap per avall', '2017', 'c:\qweewt.jpg', 4),
('Benvinguts al llarg viatge', '2021', 'c:\qweewt.jpg', 4),
('Som riu', '2014', 'c:\qweewt.jpg', 4),
('Del vent i les ales', '2020', 'c:\qweewt.jpg', 5);

INSERT INTO seguiment_artistes(id_usuari, id_artista) VALUE (1,3), (1,4),(1,5),(2,3),(2,1),(3,4),(3,5);

INSERT INTO relacio_artistes(id_artista, id_artista_semblant) VALUE (3,4),(3,5),(4,5);

INSERT INTO canco(titol, durada, reproduccions, id_album) VALUE('De tot arreu', 4.5, 500, 8),
 ('A la deriva' ,2.5 ,620 , 8),
 ('La foguera' ,3.5 ,211 ,8),
 ('Nous camins',5.03 ,54 , 8),
 ('Esperança',4.03 ,542 , 7),
 ('Compta Amb Mi',5.08,345, 7),
 ('Diuen',2.08,598, 1),
 ('Parlant de tu',4.3,485, 1),
 ('Tant de bo',3.09,521, 2),
 ('Todo lo que canto',2.58,354, 2);
 
INSERT INTO playlist(titol, nombre_cancons, data_creacio, id_usuari) VALUE ('Proves', 0, '2019-9-7', 3),
('Proves2', 2, '2021-9-7', 3),
('Musica catalana', 5, '2021-6-17', 1),
('Pop', 3, '2021-6-24', 2);

INSERT INTO playlist_eliminada(id_playlist, data_eliminacio) VALUE (1, '2022-3-2'),
(2, '2021-8-9');

INSERT INTO cancons_playlist(id_playlist, id_canco, id_usuari, data_afegit) VALUE(2, 1, 3,'2021-9-7'),
(2, 1, 3, '2021-4-7'),
(3, 1, 3, '2022-3-9'),
(3, 2, 4, '2021-2-7'),
(3, 5, 4, '2021-2-7'),
(3, 7, 4, '2021-2-7'),
(3, 8, 3, '2021-2-7'),
(4, 10, 3, '2022-9-17'),
(4, 9, 3, '2022-9-17'),
(4, 6, 2, '2022-9-17');

INSERT INTO cancons_favorites(id_canco, id_usuari) 	value(10,1),
(8,1),
(8,2),
(2,2),
(5,4),
(3,4),
(1,1);

INSERT INTO albums_favorits(id_album, id_usuari) VALUE (7,1), (5,2),(3,3);


