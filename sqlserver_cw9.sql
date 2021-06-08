CREATE DATABASE tabela_geochronologiczna;
USE tabela_geochronologiczna;


--tworzenie tabel
CREATE TABLE GeoEon (
	id_eon INT PRIMARY KEY,
	nazwa_eon VARCHAR(50) NOT NULL
);

CREATE TABLE GeoEra (
	id_era INT PRIMARY KEY,
	id_eon INT,
	nazwa_era VARCHAR(50) NOT NULL
);

CREATE TABLE GeoOkres (
	id_okres INT PRIMARY KEY,
	id_era INT,
	nazwa_okres VARCHAR(50) NOT NULL
);

CREATE TABLE GeoEpoka (
	id_epoka INT PRIMARY KEY,
	id_okres INT,
	nazwa_epoka VARCHAR(50) NOT NULL
);

CREATE TABLE GeoPietro (
	id_pietro INT PRIMARY KEY,
	id_epoka INT,
	nazwa_pietro VARCHAR(50) NOT NULL
);
DROP TABLE GeoEon, GeoEpoka, GeoEra, GeoOkres, GeoPietro;

--klucze obce
ALTER TABLE GeoEra 
	ADD FOREIGN KEY (id_eon) REFERENCES GeoEon(id_eon);

ALTER TABLE GeoOkres 
	ADD FOREIGN KEY (id_era) REFERENCES GeoEra(id_era);


ALTER TABLE GeoEpoka 
	ADD FOREIGN KEY (id_okres) REFERENCES GeoOkres(id_okres);


ALTER TABLE GeoPietro 
	ADD FOREIGN KEY (id_epoka) REFERENCES GeoEpoka(id_epoka);


--uzupe�nianie tabel
INSERT INTO GeoEon VALUES
	(1,'Fanerozoik');

INSERT INTO GeoEra VALUES 
	(1,1,'Kenozoik'),
	(2,1,'Mezozoik'),
	(3,1,'Paleozoik');

INSERT INTO GeoOkres VALUES
	(1,1,'Czwartorz�d'),
	(2,1,'Neogen'),
	(3,1,'Paleogen'),
	(4,2,'Kreda'),
	(5,2,'Jura'),
	(6,2,'Tria'),
	(7,3,'Perm'),
	(8,3,'Karbon'),
	(9,3,'Dewon');

INSERT INTO GeoEpoka VALUES
	(1,1,'Halocen'),
	(2,1,'Plejstocen'),
	(3,2,'Pliocen'),
	(4,2,'Miocen'),
	(5,3,'Oligocen'),
	(6,3,'Eocen'),
	(7,3,'Paleocen'),
	(8,4,'G�rna'),
	(9,4,'Dolna'),
	(10,5,'G�rna'),
	(11,5,'�rodkowa'),
	(12,5,'Dolna'),
	(13,6,'G�rny'),
	(14,6,'�rodkowy'),
	(15,6,'Dolny'),
	(16,7,'G�rny'),
	(17,7,'Dolny'),
	(18,8,'G�rny'),
	(19,8,'Dolny'),
	(20,9,'G�rny'),
	(21,9,'�rodkowy'),
	(22,9,'Dolny');

INSERT INTO GeoPietro VALUES
	(1,1,'megalaj'),
	(2,1,'northgrip'),
	(3,1,'grenland'),
	(4,2,'p�ny[b]'),
	(5,2,'chiban'),
	(6,2,'kalabr'),
	(7,2,'gelas'),
	(8,3,'piacent'),
	(9,3,'zankl'),
	(10,4,'messyn'),
	(11,4,'torton'),
	(12,4,'serrawal'),
	(13,4,'lang'),
	(14,4,'burdyga�'),
	(15,4,'akwitan'),
	(16,5,'szat'),
	(17,5,'rupel'),
	(18,6,'priabon'),
	(19,6,'barton'),
	(20,6,'lutet'),
	(21,6,'iprez'),
	(22,7,'tanet'),
	(23,7,'zeland'),
	(24,7,'dan'),
	(25,8,'mastrycht'),
	(26,8,'kampan'),
	(27,8,'santon'),
	(28,8,'koniak'),
	(29,8,'turon'),
	(30,8,'cenoman'),
	(31,9,'alb'),
	(32,9,'apt'),
	(33,9,'barrem'),
	(34,9,'hoteryw'),
	(35,9,'walan�yn'),
	(36,9,'berrias'),
	(37,10,'tyton'),
	(38,10,'kimeryd'),
	(39,10,'oksford'),
	(40,11,'kelowej'),
	(41,11,'baton'),
	(42,11,'bajos'),
	(43,11,'aalen'),
	(44,12,'toark'),
	(45,12,'pliensbach'),
	(46,12,'synemur'),
	(47,12,'hettang'),
	(48,13,'retyk'),
	(49,13,'noryk'),
	(50,13,'karnik'),
	(51,14,'ladyn'),
	(52,14,'anizyk'),
	(53,15,'olenek'),
	(54,15,'ind'),
	(55,16,'czangsing'),
	(56,16,'wucziaping'),
	(57,16,'kapitan'),
	(58,16,'word'),
	(59,16,'road'),
	(60,17,'kungur'),
	(61,17,'artinsk'),
	(62,17,'sakmar'),
	(63,17,'assel'),
	(64,18,'g�el'),
	(65,18,'kasimow'),
	(66,18,'moskow'),
	(67,18,'baszkir'),
	(68,19,'serpuchow'),
	(69,19,'wizen'),
	(70,19,'turnej'),
	(71,20,'famen'),
	(72,20,'fran'),
	(73,21,'�ywet'),
	(74,21,'eifel'),
	(75,22,'ems'),
	(76,22,'prag'),
	(77,22,'lochkow');

	--tabela znormalizowana
	SELECT GeoPietro.id_pietro, GeoPietro.nazwa_pietro, GeoEpoka.id_epoka, GeoEpoka.nazwa_epoka,
	GeoOkres.id_okres, GeoOkres.nazwa_okres, GeoEra.id_era, GeoEra.nazwa_era, GeoEon.id_eon, GeoEon.nazwa_eon
	INTO GeoTabela 
	FROM GeoPietro JOIN GeoEpoka ON GeoPietro.id_epoka = GeoEpoka.id_epoka
					JOIN GeoOkres ON GeoOkres.id_okres = GeoEpoka.id_okres
					JOIN GeoEra ON GeoEra.id_era = GeoOkres.id_era
					JOIN GeoEon ON GeoEon.id_eon = GeoEra.id_eon;

	ALTER TABLE GeoTabela
		ADD PRIMARY KEY (id_pietro);

	--tabele dziesiec i milion
	CREATE TABLE Dziesiec(cyfra INT, bit INT);
	INSERT INTO Dziesiec VALUES
		(0,1),(1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(8,1),(9,1);


	CREATE TABLE Milion(liczba int,cyfra int, bit int);
	INSERT INTO Milion SELECT a1.cyfra +10* a2.cyfra +100*a3.cyfra + 1000*a4.cyfra + 10000*a5.cyfra + 100000*a6.cyfra AS liczba, a1.cyfra AS cyfra, a1.bit AS bit
	FROM Dziesiec a1, Dziesiec a2, Dziesiec a3, Dziesiec a4, Dziesiec a5, Dziesiec a6;

	--tworzenie indeks�w
	create index index_eon on GeoEon(id_eon);
	create index index_era on GeoEra(id_era, id_eon);
	create index index_okres on GeoOkres(id_okres, id_era);
	create index index_epoka on GeoEpoka(id_epoka, id_okres);
	create index index_pietro on GeoPietro(id_pietro, id_epoka);
	create index index_liczba on Milion(liczba);
	create index index_GeoTabela on GeoTabela(id_pietro, id_epoka, id_era, id_okres,id_eon);


	--1ZL
	SELECT COUNT(*) FROM Milion INNER JOIN GeoTabela ON Milion.liczba%68 = GeoTabela.id_pietro;


	--2ZL
	SELECT COUNT(*) FROM Milion INNER JOIN GeoPietro ON (Milion.liczba%68 = GeoPietro.id_pietro)
								INNER JOIN GeoEpoka ON GeoPietro.id_epoka = GeoEpoka.id_epoka
								INNER JOIN GeoOkres ON GeoEpoka.id_okres = GeoOkres.id_okres
								INNER JOIN GeoEra ON GeoEra.id_era = GeoOkres.id_era
								INNER JOIN GeoEon ON GeoEon.id_eon = GeoEra.id_eon;


	--3ZG
	SELECT COUNT(*) FROM Milion WHERE Milion.liczba%68 = (SELECT id_pietro FROM GeoTabela WHERE Milion.liczba%68 = id_pietro);


	--4ZG
	SELECT COUNT(*) FROM Milion WHERE Milion.liczba%68 IN (SELECT GeoPietro.id_pietro FROM GeoPietro 
															INNER JOIN GeoEpoka ON GeoPietro.id_epoka = GeoEpoka.id_epoka
															INNER JOIN GeoOkres ON GeoEpoka.id_okres = GeoOkres.id_okres
															INNER JOIN GeoEra ON GeoEra.id_era = GeoOkres.id_era
															INNER JOIN GeoEon ON GeoEon.id_eon = GeoEra.id_eon);


