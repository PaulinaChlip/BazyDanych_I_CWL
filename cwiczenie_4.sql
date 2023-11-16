/*CREATE SCHEMA ksiegowosc; 

CREATE TABLE ksiegowosc.pracownicy(
	id_pracownika SERIAL PRIMARY KEY NOT NULL,
	imie varchar(20) NOT NULL,
	nazwisko varchar(30) NOT NULL,
	adres varchar(70) NOT NULL,
	telefon varchar(10) NOT NULL
);

CREATE TABLE ksiegowosc.godziny(
	id_godziny SERIAL PRIMARY KEY NOT NULL,
	data date NOT NULL,
	liczba_godzin int,
	id_pracownika int NOT NULL
);

CREATE TABLE ksiegowosc.pensje(
	id_pensji SERIAL PRIMARY KEY NOT NULL,
	stanowisko varchar(30) NOT NULL,
	kwota money
);

CREATE TABLE ksiegowosc.premie(
	id_premii SERIAL PRIMARY KEY NOT NULL,
	rodzaj varchar(40) NOT NULL,
	kwota money NOT NULL
);

CREATE TABLE ksiegowosc.wynagrodzenia(
	id_wynagrodzenia SERIAL PRIMARY KEY NOT NULL,
	data date NOT NULL,
	id_pracownika int NOT NULL,
	id_godziny int NOT NULL,
	id_pensji int NOT NULL,
	id_premii int
);

ALTER TABLE ksiegowosc.godziny
ADD FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika);

ALTER TABLE ksiegowosc.wynagrodzenia
ADD FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika);

ALTER TABLE ksiegowosc.wynagrodzenia
ADD FOREIGN KEY (id_godziny) REFERENCES ksiegowosc.godziny(id_godziny);

ALTER TABLE ksiegowosc.wynagrodzenia
ADD FOREIGN KEY (id_pensji) REFERENCES ksiegowosc.pensje(id_pensji);

ALTER TABLE ksiegowosc.wynagrodzenia
ADD FOREIGN KEY (id_premii) REFERENCES ksiegowosc.premie(id_premii);

INSERT INTO ksiegowosc.pracownicy (imie,nazwisko,adres,telefon) VALUES
('Jan','Kowalski','Kraków, ul.Długa 36A', '589307482'),
('Alicja','Borowska', 'Warszawa, ul.Wiejska 3', '468290095'),
('Cezary','Darski','Gdańsk, ul.Trefl 532', '538294296'),
('Eliza', 'Frankowska','Gdynia, ul.Portowa 31', '463208035'),
('Grzegorz','Halny','Rzeszów, ul.Polska 321', '538629054'),
('Izabela','Jarska','Kielce, ul.Winiary 2A', '536930485'),
('Kacper','Luzacki','Bochnia, ul.Solna 3C','593809403'),
('Maciej','Nowacki','Konin ul.Środkowa 46','569380305'),
('Olga','Paluch','Legnica, ul.Niemiecka 74','426930080'),
('Robert','Stawski','Szczecin, ul.Nadmorska 32','562984544');

INSERT INTO ksiegowosc.premie (rodzaj,kwota) VALUES
('wielkanocna',100),
('bożonarodzeniowa',200),
('wakacyjna',100),
('końcoworoczna',100),
('za wyjazdy służbowe', 100),
('za szczegolne wyniki', 150),
('za brak L4 w miesiącu', 50),
('za kierowanie projektem',200),
('za przedłużenie umowy', 200),
('premia za 5 lat pracy', 600);

INSERT INTO ksiegowosc.pensje (stanowisko,kwota) VALUES
('Sprzedawca',4500),
('Kierowca-dostawca',4700),
('Kierownik salonu',5900),
('Pracownik infolinii',4600),
('Manager HR', 7800),
('Manager ds. handlu', 8100),
('Manager ds. marketingu',8400),
('Stażysta',3850),
('Asystent klienta',5400),
('Członek zarządu',15000);

INSERT INTO ksiegowosc.godziny(data,liczba_godzin,id_pracownika) VALUES
('2023-06-10',120,8),
('2023-05-10',134,3),
('2023-10-10',75,2),
('2023-09-10',170,1),
('2023-02-10',100,5),
('2023-07-10',180,4),
('2023-08-10',128,9),
('2023-11-10',200,6),
('2023-05-10',90,7),
('2023-04-10',150,10);

INSERT INTO ksiegowosc.wynagrodzenia(data,id_pracownika,id_godziny,id_pensji,id_premii) VALUES
('2023-12-31',3,2,7,NULL),
('2023-12-31', 8,1,5,2),
('2023-12-31',7,9,2,9),
('2023-12-31',6,8,10,NULL),
('2023-12-31',5,5,2,8),
('2023-12-31',1,4,6,5),
('2023-12-31',2,3,3,8),
('2023-12-31',4,6,9,4),
('2023-12-31',9,7,4,NULL),
('2023-12-31',10,10,3,4);

--ppkt a)
SELECT (id_pracownika,nazwisko) FROM ksiegowosc.pracownicy;

--ppkt b)
SELECT kw.id_pracownika, kpen.kwota, kprem.kwota
FROM ksiegowosc.wynagrodzenia kw, ksiegowosc.pensje kpen, ksiegowosc.premie kprem
WHERE kw.id_pensji=kpen.id_pensji AND kw.id_premii=kprem.id_premii AND kprem.kwota+kpen.kwota>money(1000);

--ppkt c)
--sposób nr 1
SELECT kw.id_pracownika, kpen.kwota, kw.id_premii
FROM ksiegowosc.wynagrodzenia kw LEFT JOIN ksiegowosc.pensje kpen ON kw.id_pensji=kpen.id_pensji
WHERE kpen.kwota>money(2000) AND kw.id_premii IS NULL;
--sposób nr 2
SELECT kw.id_pracownika, kpen.kwota, kw.id_premii
FROM  ksiegowosc.wynagrodzenia kw, ksiegowosc.pensje kpen,ksiegowosc.pracownicy kprac
WHERE kprac.id_pracownika=kw.id_pracownika AND kw.id_pensji=kpen.id_pensji AND kpen.kwota>money(2000) AND kw.id_premii IS NULL;

--ppkt d)
SELECT kprac.imie, kprac.nazwisko
FROM ksiegowosc.pracownicy kprac WHERE kprac.imie LIKE 'J%';

--ppkt e)
SELECT kprac.imie, kprac.nazwisko
FROM ksiegowosc.pracownicy kprac WHERE (kprac.imie LIKE '%a' AND kprac.nazwisko LIKE '%n%'); 

--ppkt f)
SELECT kprac.imie, kprac.nazwisko, kgodz.liczba_godzin-160 AS liczba_nadgodzin
FROM ksiegowosc.pracownicy kprac, ksiegowosc.wynagrodzenia kw, ksiegowosc.godziny kgodz
WHERE kprac.id_pracownika=kw.id_pracownika AND kw.id_godziny=kgodz.id_godziny AND kgodz.liczba_godzin>160;

--ppkt g) (zmodyfikowany)
SELECT kprac.imie, kprac.nazwisko, kw.id_pensji, kpen.id_pensji, kpen.kwota
FROM ksiegowosc.pracownicy kprac, ksiegowosc.wynagrodzenia kw, ksiegowosc.pensje kpen
WHERE kprac.id_pracownika=kw.id_pracownika AND kw.id_pensji=kpen.id_pensji AND kpen.kwota>money(1500) AND kpen.kwota>money(5000);

--ppkt h)
SELECT kprac.imie, kprac.nazwisko, kgodz.liczba_godzin, kw.id_premii
FROM ksiegowosc.pracownicy kprac, ksiegowosc.wynagrodzenia kw, ksiegowosc.godziny kgodz
WHERE kprac.id_pracownika=kw.id_pracownika AND kw.id_godziny=kgodz.id_godziny AND kgodz.liczba_godzin>160 AND kw.id_premii IS NULL ;

--ppkt i)
SELECT kprac.imie, kprac.nazwisko, kpen.kwota
FROM ksiegowosc.pracownicy kprac, ksiegowosc.pensje kpen, ksiegowosc.wynagrodzenia kw
WHERE kprac.id_pracownika=kw.id_pracownika AND kw.id_pensji=kpen.id_pensji
ORDER BY kpen.kwota;

--ppkt j)
SELECT kprac.imie, kprac.nazwisko, kpen.kwota, kprem.kwota
FROM ksiegowosc.pracownicy kprac, ksiegowosc.pensje kpen, ksiegowosc.wynagrodzenia kw, ksiegowosc.premie kprem
WHERE kprac.id_pracownika=kw.id_pracownika AND kw.id_pensji=kpen.id_pensji AND kw.id_premii=kprem.id_premii
ORDER BY kpen.kwota, kprem.kwota DESC;

--ppkt k)
SELECT kpen.stanowisko, COUNT(kpen.stanowisko)
FROM ksiegowosc.pracownicy kprac, ksiegowosc.pensje kpen, ksiegowosc.wynagrodzenia kw
WHERE kprac.id_pracownika=kw.id_pracownika AND kw.id_pensji=kpen.id_pensji 
GROUP BY kpen.stanowisko;

--ppkt l)
SELECT kpen.stanowisko, MAX(kpen.kwota), MIN(kpen.kwota), AVG(kpen.kwota::numeric)
FROM ksiegowosc.pensje kpen, ksiegowosc.wynagrodzenia kw
WHERE kw.id_pensji=kpen.id_pensji AND kpen.stanowisko='Kierownik salonu'
GROUP BY kpen.stanowisko;

--ppkt m)
SELECT SUM(kpen.kwota)
FROM ksiegowosc.pensje kpen, ksiegowosc.wynagrodzenia kw
WHERE kw.id_pensji=kpen.id_pensji;

--ppkt n)
SELECT kpen.stanowisko, SUM(kpen.kwota)
FROM ksiegowosc.pensje kpen, ksiegowosc.wynagrodzenia kw
WHERE kw.id_pensji=kpen.id_pensji 
GROUP BY kpen.stanowisko;

--ppkt o)
SELECT kpen.stanowisko, COUNT(kprem.id_premii)
FROM ksiegowosc.pensje kpen, ksiegowosc.wynagrodzenia kw, ksiegowosc.premie kprem
WHERE kw.id_pensji=kpen.id_pensji AND kw.id_premii=kprem.id_premii
GROUP BY kpen.stanowisko;

--ppkt p)
DELETE FROM ksiegowosc.pracownicy kprac USING ksiegowosc.wynagrodzenia kw, ksiegowosc.pensje kpen
WHERE kw.id_pracownika=kprac.id_pracownika AND kw.id_pensji=kpen.id_pensji AND kpen.kwota<money(1200)
*/
