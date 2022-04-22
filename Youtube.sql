CREATE DATABASE youtube DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

USE youtube;

CREATE TABLE IF NOT EXISTS usuari
(
    id_usuari INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    email_usuari VARCHAR(25),
    password VARCHAR(10),
    nom_usuari VARCHAR(15),
    data_naixement DATE,
    sexe VARCHAR(1),
    pais VARCHAR(15),
    codi_postal VARCHAR(9)
);

CREATE TABLE IF NOT EXISTS video
(
    id_video INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    titol VARCHAR(15),
    descripcio VARCHAR(50),
    grandaria FLOAT(2),
    nom_arxiu VARCHAR(35),
    durada FLOAT(2),
    thumbnail VARCHAR(35),
    nombre_reproduccions INT,
    estat_video ENUM('public','ocult','privat')
);

CREATE TABLE IF NOT EXISTS etiquetes
(
    id_etiqueta INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_video INT NOT NULL,
    id_usuari INT NOT NULL,
    nom_etiqueta VARCHAR(15),
    FOREIGN KEY (id_video) REFERENCES video(id_video),
    FOREIGN KEY (id_usuari) REFERENCES usuari(id_usuari)
);

CREATE TABLE IF NOT EXISTS canal
(
    id_usuari INT NOT NULL,
    id_canal INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nom_canal VARCHAR(25),
    descripcio_canal VARCHAR(50),
    data_creacio DATE,
    FOREIGN KEY (id_usuari) REFERENCES usuari(id_usuari)
);

CREATE TABLE IF NOT EXISTS subscripcions
(
    id_usuari INT NOT NULL,
    id_canal INT NOT NULL,
    FOREIGN KEY (id_usuari) REFERENCES usuari(id_usuari),
    FOREIGN KEY (id_canal) REFERENCES canal(id_canal)
);

CREATE TABLE IF NOT EXISTS comentaris
(
    id_comentari INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_video INT NOT NULL,
	id_usuari INT NOT NULL,
    comentari VARCHAR(50),
    data_comentari TIMESTAMP default NOW(),   
    FOREIGN KEY (id_usuari) REFERENCES usuari(id_usuari),
    FOREIGN KEY (id_video) REFERENCES video(id_video)
);

CREATE TABLE IF NOT EXISTS recompte_Likes_Comentaris
(
    id_comentari INT NOT NULL,
    id_usuari INT NOT NULL,
    like_dislike BOOLEAN,
    data_like TIMESTAMP default NOW() ,
	FOREIGN KEY (id_usuari) REFERENCES usuari(id_usuari),
    FOREIGN KEY (id_comentari) REFERENCES comentaris(id_comentari)
);

CREATE TABLE IF NOT EXISTS playlist
(
    id_playlist INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_usuari INT NOT NULL,
    nom_playlist VARCHAR(35),
    data_creacio DATE,
    playlist_publica BOOLEAN,
    FOREIGN KEY (id_usuari) REFERENCES usuari(id_usuari)
);

CREATE TABLE IF NOT EXISTS publicacio
(
    id_usuari INT NOT NULL,
    id_video INT NOT NULL,
	data_publicacio TIMESTAMP default NOW(),
    PRIMARY KEY(id_usuari, id_video),
    FOREIGN KEY (id_usuari) REFERENCES usuari(id_usuari),
    FOREIGN KEY (id_video) REFERENCES video(id_video)
);

CREATE TABLE IF NOT EXISTS likes_Videos
(
    id_usuari INT NOT NULL,
    id_video INT NOT NULL,
    like_dislike BOOLEAN,
    data_like TIMESTAMP default NOW(),
    PRIMARY KEY(id_usuari, id_video),
	FOREIGN KEY (id_usuari) REFERENCES usuari(id_usuari),
    FOREIGN KEY (id_video) REFERENCES video(id_video)
);

CREATE TABLE IF NOT EXISTS contingut_playlist
(
    id_playlist INT NOT NULL,
    id_video INT NOT NULL,
    FOREIGN KEY (id_playlist) REFERENCES playlist(id_playlist),
    FOREIGN KEY (id_video) REFERENCES video(id_video)
);

INSERT INTO usuari(email_usuari, password, nom_usuari, data_naixement, sexe, pais, codi_postal) VALUES ('rata@hotmail.com','123456','rata','2006-10-2','H','Espanya','08012'),
('gos@hotmail.com','123456','gos','2006-10-2','H','Espanya','08016'),
('gat@hotmail.com','098765','gat','2006-10-2','D','Espanya','08013'),
('ruc@hotmail.com','qwerty','ruc','2006-10-2','D','Espanya','09018'),
('serp@hotmail.com','dfghjh','serp','2006-10-2','H','Espanya','09021');

INSERT INTO video(titol, descripcio, grandaria, nom_arxiu, durada, thumbnail, nombre_reproduccions, estat_video) VALUES ('Gat miolant', 'Es un gat que miola', 567, 'c:\dsfdsfsd.avi', 5.6, 'c:\dfadsfdas.jpg',31,'public'),
('Gos bordant','Es un gos que borda',256, 'c:\ere.avi',3.2,'c:\eqewqw.jpg',50,'ocult'),
('Nen plorant','Es un nen que plora', 879, 'c:\dewrdsfsd.avi',1.2,'c:\nv,bn,vbn.jpg',200,'public'),
('Broma','Ensurt',3435, 'c:\dfdsa.avi',30.6,'c:\dftrrhhj.jpg',34,'privat'),
('Gameplay','Demostracio d\'un joc', 13423, 'c:\dsfdsfuiiusd.avi',45.30,'c:\wqewqew.jpg',104,'public'),
('Unboxing','Mostra un producte',3234, 'c:\bnctet.avi',67.5,'c:\ddfad.jpg',200,'public');
    
INSERT INTO etiquetes(id_video, id_usuari, nom_etiqueta) VALUES (2,1,'Etiqueta 1'),
(2,1,'Etiqueta 2'),
(2,1,'Etiqueta 3'),
(2,1,'Etiqueta 4'),
(2,1,'Etiqueta 5'),
(2,1,'Etiqueta 6');

INSERT INTO canal( id_usuari, nom_canal, descripcio_canal, data_creacio) VALUES (1, 'El canal de la rata', 'Els meus videos', '2022-10-21'),
(2, 'El canal del gos', 'Videos casolans', '2021-7-1');

INSERT INTO subscripcions( id_usuari, id_canal) VALUES (2,1),(3,1),(4,1),(1,2),(3,2);

INSERT INTO comentaris( id_video, id_usuari, comentari) VALUES (1, 4, 'Que maco'),
(2, 4, 'M\'agrada'),
(3, 5, 'Molt interessant'),
(1, 5, 'Útil'),
(4, 3, 'Refrescant');

INSERT INTO recompte_Likes_Comentaris(id_comentari, id_usuari, like_dislike) VALUES(1,2,true), (2,1,false),(3,5,true);

INSERT INTO playlist(id_usuari, nom_playlist, data_creacio, playlist_publica) VALUES(4, 'Recull videos', '2021-9-11',false), (5, 'Videos interessants', '2021-10-1',true);
    
INSERT INTO publicacio(id_usuari, id_video) VALUES(1,1),(1,2),(1,3),(2,4),(2,5);
    
INSERT INTO likes_Videos(id_usuari, id_video, like_dislike) VALUES(4,2,true), (5,1,false),(3,2,true);
    
INSERT INTO contingut_playlist(id_playlist, id_video) VALUES(1,1),(1,2),(1,3),(2,4),(2,5);

-- llistar numeros de likes total dels videos publicats per un usuari concret
SELECT COUNT(likes_videos.like_dislike) FROM likes_videos,usuari, publicacio WHERE usuari.id_usuari=publicacio.id_usuari AND publicacio.id_video=likes_videos.id_video AND likes_videos.like_dislike=true AND usuari.nom_usuari='rata';
SELECT COUNT(likes_videos.like_dislike) FROM likes_videos,usuari, publicacio WHERE usuari.id_usuari=publicacio.id_usuari AND publicacio.id_video=likes_videos.id_video AND likes_videos.like_dislike=false AND usuari.nom_usuari='rata';
SELECT COUNT(likes_videos.like_dislike) FROM likes_videos,usuari, publicacio WHERE usuari.id_usuari=publicacio.id_usuari AND publicacio.id_video=likes_videos.id_video AND likes_videos.like_dislike=true AND usuari.nom_usuari='gos';
