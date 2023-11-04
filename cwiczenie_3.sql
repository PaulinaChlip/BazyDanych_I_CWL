
CREATE SCHEMA rozliczenia;

CREATE TABLE rozliczenia.pracownicy(
	id_pracownika int PRIMARY KEY,
	imie varchar (30) NOT NULL,
	nazwisko varchar(30) NOT NULL,
	adres varchar(100) NOT NULL,
	telefon varchar(10) NOT NULL
);

CREATE TABLE rozliczenia.godziny(
	id_godziny int PRIMARY KEY NOT NULL,
	data date NOT NULL,
	liczba_godzin int,
	id_pracownika int NOT NULL
);

CREATE TABLE rozliczenia.premie(
	id_premii int PRIMARY KEY NOT NULL,
	rodzaj varchar(100),
	kwota money NOT NULL
);

CREATE TABLE rozliczenia.pensje(
	id_pensji int PRIMARY KEY NOT NULL,
	stanowisko varchar(40),
	kwota money NOT NULL,
	id_premii int NOT NULL
);

ALTER TABLE rozliczenia.godziny
ADD FOREIGN KEY (id_pracownika) REFERENCES rozliczenia.pracownicy(id_pracownika);

ALTER TABLE rozliczenia.pensje
ADD FOREIGN KEY (id_premii)REFERENCES rozliczenia.premie(id_premii);

INSERT INTO rozliczenia.pracownicy (id_pracownika,imie,nazwisko,adres,telefon) VALUES
(1, 'jan','Kowalski','Kraków, ul.Długa 36A', '589307482'),
(2,'Alicja','Borowska', 'Warszawa, ul.Wiejska 3', '468290095'),
(3,'Cezary','Darski','Gdańsk, ul.Trefl 532', '538294296'),
(4,'Eliza', 'Frankowska','Gdynia, ul.Portowa 31', '463208035'),
(5,'Grzegorz','Halny','Rzeszów, ul.Polska 321', '538629054'),
(6,'Izabela','Jarska','Kielce, ul.Winiary 2A', '536930485'),
(7,'Kacper','Luzacki','Bochnia, ul.Solna 3C','593809403'),
(8,'Maciej','Nowacki','Konin ul.Środkowa 46','569380305'),
(9,'Olga','Paluch','Legnica, ul.Niemiecka 74','426930080'),
(10,'Robert','Stawski','Szczecin, ul.Nadmorska 32','562984544');

INSERT INTO rozliczenia.godziny VALUES
(1,'2023-06-12',5,8),
(2,'2023-05-21',8,3),
(3,'2023-10-16',7,2),
(4,'2023-09-01',7,1),
(5,'2023-02-22',10,5),
(6,'2023-07-07',9,4),
(7,'2023-08-12',10,9),
(8,'2023-11-26',2,6),
(9,'2023-05-15',5,7),
(10,'2023-04-04',8,10);

INSERT INTO rozliczenia.premie VALUES
(1,'wielkanocna',100),
(2,'bożonarodzeniowa',200),
(3,'wakacyjna',100),
(4,'końcoworoczna',100),
(5,'za wyjazdy służbowe', 100),
(6,'za szczegolne wyniki', 150),
(7,'za brak L4 w miesiącu', 50),
(8,'za kierowanie projektem',200),
(9,'za przedłużenie umowy', 200),
(10,'premia za 5 lat pracy', 600);

INSERT INTO rozliczenia.pensje VALUES
(1,'Sprzedawca',3500,7),
(2,'Kierowca-dostawca',3700,4),
(3,'Kierownik salonu',4900,9),
(4,'Pracownik infolinii',3600,3),
(5,'Manager HR', 6800,6),
(6,'Manager ds. handlu', 7100,5),
(7,'Manager ds. marketingu',7400,6),
(8,'Stażysta',2850,3),
(9,'Asystent klienta',4400,10),
(10,'Członek zarządu',12000,8);

SELECT (nazwisko, adres) FROM rozliczenia.pracownicy;

SELECT DATE_PART ('dow',data) AS dzien_tygodnia,
DATE_PART('month',data) AS miesiac
FROM rozliczenia.godziny

ALTER TABLE rozliczenia.pensje
RENAME COLUMN kwota to kwota_brutto;

ALTER TABLE rozliczenia.pensje
ADD kwota_netto money;

UPDATE rozliczenia.pensje
SET kwota_netto=kwota_brutto*0.7;
*/
