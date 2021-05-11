/*utworzenie bazy danych*/
CREATE DATABASE firma;

/*utworzenie schematu*/
CREATE SCHEMA rozliczenia;

/*utworzenie tabel*/
CREATE TABLE rozliczenia.pracownicy(id_pracownika INT PRIMARY KEY NOT NULL, imie VARCHAR(100) NOT NULL, nazwisko VARCHAR(100) NOT NULL, adres VARCHAR(100) NOT NULL, telefon INT NOT NULL);
CREATE TABLE rozliczenia.godziny(id_godziny INT PRIMARY KEY NOT NULL, data DATE, liczba_godzin INT, id_pracownika INT);
CREATE TABLE rozliczenia.pensje(id_pensji INT PRIMARY KEY NOT NULL, stanowisko VARCHAR(100), kwota INT NOT NULL, id_premii INT);
CREATE TABLE rozliczenia.premie(id_premii INT PRIMARY KEY NOT NULL, rodzaj VARCHAR(100), kwota INT NOT NULL);

/*dodawanie kluczów obcych*/
ALTER TABLE rozliczenia.godziny ADD FOREIGN KEY (id_pracownika) REFERENCES rozliczenia.pracownicy(id_pracownika);
ALTER TABLE rozliczenia.pensje ADD FOREIGN KEY (id_premii) REFERENCES rozliczenia.premie(id_premii);

/*wypełnianie tabel*/
INSERT INTO rozliczenia.pracownicy(id_pracownika, imie, nazwisko, adres, telefon) 
VALUES	(1,'Adam','Koj','al. Mickiewicza 15',519055511),
		(2,'Ewa','Koc','ul. Maki 22/34',767759367),
		(3,'Stefan','Maj','ul. Zwierzyniecka 5',377187183),
		(4,'Mateusz','Kowalski','ul. Dobrzycka 78/1',728831934),
		(5,'Katarzyna','Nowak','ul. Dąbrowskiej 80',671404763),
		(6,'Jan','Adamczyk','al. Słowackiego 59/8',936917975),
		(7,'Weronika','Kula','ul. Prosta 64/45',959306074),
		(8,'Filip','Las','ul. Magnoliowa 1b',115127988),
		(9,'Natalia','Drabek','ul. Zakątek 3/49',209410359),
		(10,'Wojciech','Lis','ul. Krótka 56',983609602);

INSERT INTO rozliczenia.godziny(id_godziny, data, liczba_godzin, id_pracownika)
VALUES	(1,'2021-03-10',10,8),
		(2,'2021-03-10',10,5),
		(3,'2021-03-11',10,7),
		(4,'2021-03-11',6,2),
		(5,'2021-03-11',8,10),
		(6,'2021-03-12',8,4),
		(7,'2021-03-12',10,6),
		(8,'2021-03-13',4,1),
		(9,'2021-03-13',12,3),
		(10,'2021-03-13',8,9);

INSERT INTO rozliczenia.pensje(id_pensji, stanowisko, kwota, id_premii)
VALUES	(1,'Programista junior',6000,9),
		(2,'Programista senior',13000,3),
		(3,'Programista junior',6500,1),
		(4,'Programista junior',4500,6),
		(5,'Programista junior',5000,4),
		(6,'Programista senior',15000,10),
		(7,'Programista junior',5500,2),
		(8,'Programista junior',6000,7),
		(9,'Programista junior',6500,5),
		(10,'Programista senior',14000,8);
		
INSERT INTO rozliczenia.premie(id_premii, rodzaj, kwota)
VALUES	(1,'Miesięczna',1000),
		(2,'Roczna',15000),
		(3,'Tygodniowa',600),
		(4,'Miesięczna',1600),
		(5,'Miesięczna',1900),
		(6,'Miesięczna',2000),
		(7,'Tygodniowa',500),
		(8,'Tygodniowa',400),
		(9,'Miesięczna',1700),
		(10,'Tygodniowa',700);

/*wyświetlenie nazwisk i adresów pracowników*/
SELECT nazwisko, adres FROM rozliczenia.pracownicy;

/*zapytanie konwertujące datę*/
SELECT DATE_PART('day', data) AS dzień, DATE_PART('month', data) AS miesiąc FROM rozliczenia.godziny;


/*utworzenie kwoty brutto oraz netto*/
ALTER TABLE rozliczenia.pensje RENAME COLUMN kwota TO kwota_brutto;
ALTER TABLE rozliczenia.pensje ADD kwota_netto FLOAT(2);
UPDATE rozliczenia.pensje SET kwota_netto = kwota_brutto*0.81;




