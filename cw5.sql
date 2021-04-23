/*utworzenie bazy danych*/
CREATE DATABASE firma;

/*utworzenie schematu*/
CREATE SCHEMA ksiegowosc;

/*utworzenie tabel*/
CREATE TABLE ksiegowosc.pracownicy(id_pracownika INT PRIMARY KEY NOT NULL, imie VARCHAR(100) NOT NULL, nazwisko VARCHAR(100) NOT NULL, adres VARCHAR(100) NOT NULL, telefon INT NOT NULL);
CREATE TABLE ksiegowosc.godziny(id_godziny INT PRIMARY KEY NOT NULL, data DATE, liczba_godzin INT, id_pracownika INT);
CREATE TABLE ksiegowosc.pensja(id_pensji INT PRIMARY KEY NOT NULL, stanowisko VARCHAR(100), kwota INT NOT NULL);
CREATE TABLE ksiegowosc.premia(id_premii INT PRIMARY KEY NOT NULL, rodzaj VARCHAR(100), kwota INT NOT NULL);
CREATE TABLE ksiegowosc.wynagrodzenie(id_wynagrodzenia INT PRIMARY KEY NOT NULL, data DATE, id_pracownika INT, id_godziny INT, id_pensji INT, id_premii INT);

/*dodawanie kluczów obcych*/
ALTER TABLE ksiegowosc.godziny ADD FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika);
ALTER TABLE ksiegowosc.pensja ADD FOREIGN KEY (id_premii) REFERENCES ksiegowosc.premia(id_premii);
ALTER TABLE ksiegowosc.wynagrodzenie ADD FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika),
									ADD FOREIGN KEY (id_godziny) REFERENCES ksiegowosc.godziny(id_godziny),
									ADD FOREIGN KEY (id_pensji) REFERENCES ksiegowosc.pensja(id_pensji),
									ADD FOREIGN KEY (id_premii) REFERENCES ksiegowosc.premia(id_premii);

/*opisy tabel*/
COMMENT ON TABLE ksiegowosc.pracownicy IS 'Tabela zawierająca listę pracowników firmy.';
COMMENT ON TABLE ksiegowosc.godziny IS 'Tabela zawierająca rozpiskę godzinową.';
COMMENT ON TABLE ksiegowosc.pensja IS 'Tabela zawierająca listę pensji pracowników.';
COMMENT ON TABLE ksiegowosc.premia IS 'Tabela zawierająca listę premii pracowników.';
COMMENT ON TABLE ksiegowosc.wynagrodzenie IS 'Tabela zawierająca listę wynagrodzeń uzyskanych przez pracowników.';

/*wypełnianie tabel*/
INSERT INTO ksiegowosc.pracownicy(id_pracownika, imie, nazwisko, adres, telefon) 
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

INSERT INTO ksiegowosc.godziny(id_godziny, data, liczba_godzin, id_pracownika)
VALUES	(1,'2021-03-01',160,8),
		(2,'2021-03-01',170,5),
		(3,'2021-03-01',100,7),
		(4,'2021-03-01',150,2),
		(5,'2021-03-01',200,10),
		(6,'2021-03-01',80,4),
		(7,'2021-03-01',100,6),
		(8,'2021-03-01',140,1),
		(9,'2021-03-01',170,3),
		(10,'2021-03-01',180,9);

INSERT INTO ksiegowosc.premia(id_premii, rodzaj, kwota)
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

INSERT INTO ksiegowosc.pensja(id_pensji, stanowisko, kwota)
VALUES	(1,'Programista junior',1700),
		(2,'Programista senior',13000),
		(3,'Programista junior',500),
		(4,'Programista junior',1600),
		(5,'Programista junior',5000),
		(6,'Programista senior',15000),
		(7,'Programista junior',2500),
		(8,'Programista junior',4000),
		(9,'Programista junior',900),
		(10,'Programista senior',14000);
		
INSERT INTO ksiegowosc.wynagrodzenie(id_wynagrodzenia, data, id_pracownika, id_godziny, id_pensji, id_premii)
VALUES	(1,'2021-04-01',1,8,1,9),
		(2,'2021-04-05',2,4,2,NULL),
		(3,'2021-04-02',3,9,3,1),
		(4,'2021-04-01',4,6,4,6),
		(5,'2021-04-04',5,2,5,NULL),
		(6,'2021-04-03',6,7,6,NULL),
		(7,'2021-04-01',7,3,7,2),
		(8,'2021-04-01',8,1,8,7),
		(9,'2021-04-05',9,10,9,NULL),
		(10,'2021-04-02',10,5,10,3);

/*zad 6_a*/
SELECT id_pracownika, nazwisko FROM ksiegowosc.pracownicy;

/*zad 6_b*/
SELECT pracownicy.id_pracownika, pensja.kwota 
FROM ksiegowosc.pracownicy INNER JOIN (ksiegowosc.pensja INNER JOIN ksiegowosc.wynagrodzenie ON pensja.id_pensji = wynagrodzenie.id_pensji) ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
WHERE kwota > 1000;

/*zad 6_c*/
SELECT pracownicy.id_pracownika, pensja.kwota, wynagrodzenie.id_premii
FROM ksiegowosc.pracownicy INNER JOIN (ksiegowosc.pensja INNER JOIN ksiegowosc.wynagrodzenie ON pensja.id_pensji = wynagrodzenie.id_pensji) ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
WHERE wynagrodzenie.id_premii IS NULL AND pensja.kwota > 2000;

/*zad 6_d*/
SELECT id_pracownika, imie, nazwisko FROM ksiegowosc.pracownicy WHERE imie LIKE 'J%'; 

/*zad 6_e*/
SELECT id_pracownika, imie, nazwisko FROM ksiegowosc.pracownicy WHERE nazwisko LIKE '%n%' OR nazwisko LIKE 'N%' OR nazwisko LIKE '%n' AND imie LIKE '%a';

/*zad 6_f*/
SELECT pracownicy.imie, pracownicy.nazwisko, godziny.liczba_godzin-160 AS nadgodziny
FROM ksiegowosc.pracownicy INNER JOIN(ksiegowosc.godziny INNER JOIN ksiegowosc.wynagrodzenie ON godziny.id_godziny = wynagrodzenie.id_godziny) ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
WHERE godziny.liczba_godzin > 160;

/*zad 6_g*/
/*zwykłe*/
SELECT pracownicy.imie, pracownicy.nazwisko, pensja.kwota
FROM ksiegowosc.pracownicy INNER JOIN (ksiegowosc.pensja INNER JOIN ksiegowosc.wynagrodzenie ON pensja.id_pensji = wynagrodzenie.id_pensji) ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
WHERE pensja.kwota > 1500 AND pensja.kwota < 3000;
/*z between*/
SELECT pracownicy.imie, pracownicy.nazwisko, pensja.kwota
FROM ksiegowosc.pracownicy INNER JOIN (ksiegowosc.pensja INNER JOIN ksiegowosc.wynagrodzenie ON pensja.id_pensji = wynagrodzenie.id_pensji) ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
WHERE pensja.kwota BETWEEN 1500 AND 3000;

/*zad 6_h*/
SELECT pracownicy.imie, pracownicy.nazwisko, godziny.liczba_godzin-160 AS nadgodziny, wynagrodzenie.id_premii
FROM ksiegowosc.pracownicy INNER JOIN(ksiegowosc.godziny INNER JOIN ksiegowosc.wynagrodzenie ON godziny.id_godziny = wynagrodzenie.id_godziny) ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
WHERE godziny.liczba_godzin > 160 AND wynagrodzenie.id_premii IS NULL;

/*zad 6_i*/
SELECT pracownicy.imie, pracownicy.nazwisko, pensja.kwota
FROM ksiegowosc.pracownicy INNER JOIN (ksiegowosc.pensja INNER JOIN ksiegowosc.wynagrodzenie ON pensja.id_pensji = wynagrodzenie.id_pensji) ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
ORDER BY pensja.kwota DESC;

/*zad 6_j*/
SELECT pracownicy.imie, pracownicy.nazwisko, pensja.kwota AS pensja, premia.kwota AS premia
FROM ksiegowosc.premia INNER JOIN (ksiegowosc.pracownicy INNER JOIN (ksiegowosc.pensja INNER JOIN ksiegowosc.wynagrodzenie ON pensja.id_pensji = wynagrodzenie.id_pensji) ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika) ON premia.id_premii = wynagrodzenie.id_premii
ORDER BY pensja.kwota DESC, premia.kwota DESC;


/*zad 6_k*/
SELECT COUNT(stanowisko), stanowisko FROM ksiegowosc.pensja GROUP BY stanowisko;

/*zad 6_l*/
SELECT MIN(kwota), MAX(kwota), AVG(kwota) FROM ksiegowosc.pensja WHERE stanowisko = 'Programista junior';

/*zad 6_m*/
SELECT SUM(kwota) FROM ksiegowosc.pensja;

/*zad 6_n*/
SELECT SUM(kwota), stanowisko FROM ksiegowosc.pensja GROUP BY stanowisko;

/*zad 6_o*/
SELECT COUNT(premia.id_premii) AS liczba_premii, pensja.stanowisko
FROM ksiegowosc.premia INNER JOIN (ksiegowosc.pensja INNER JOIN ksiegowosc.wynagrodzenie ON pensja.id_pensji = wynagrodzenie.id_pensji) ON premia.id_premii = wynagrodzenie.id_premii
GROUP BY stanowisko;


/*zad 6_p*/
/*???*/




DROP TABLE ksiegowosc.pracownicy, ksiegowosc.godziny, ksiegowosc.premia, ksiegowosc.pensja, ksiegowosc.wynagrodzenie;

