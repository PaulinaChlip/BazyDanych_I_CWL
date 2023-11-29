
ALTER TABLE ksiegowosc.pracownicy
ALTER COLUMN telefon TYPE varchar(16);

UPDATE  ksiegowosc.pracownicy
SET telefon = '(+48)' || telefon;

UPDATE ksiegowosc.pracownicy
SET telefon=CONCAT(SUBSTRING(telefon FROM 1 FOR 8),'-',
				   SUBSTRING(telefon FROM 9 FOR 3),'-',
				   SUBSTRING(telefon FROM 10 FOR 3));

SELECT UPPER(imie), UPPER(nazwisko), UPPER(adres), UPPER(telefon), LENGTH(nazwisko) AS dlugosc_nazwiska
FROM ksiegowosc.pracownicy
WHERE LENGTH(nazwisko) = (SELECT MAX(LENGTH(nazwisko)) FROM ksiegowosc.pracownicy);

SELECT MD5(imie), MD5(nazwisko), MD5(adres), MD5(telefon), MD5(CAST(kwota AS varchar(8)))
FROM ksiegowosc.pracownicy kprac, ksiegowosc.pensje kpen, ksiegowosc.wynagrodzenia
WHERE ksiegowosc.wynagrodzenia.id_pracownika=kprac.id_pracownika AND ksiegowosc.wynagrodzenia.id_pensji=kpen.id_pensji; 

SELECT kprac.*, kpen.kwota, kprem.kwota
FROM ksiegowosc.pracownicy kprac
LEFT JOIN ksiegowosc.wynagrodzenia kw ON kw.id_pracownika=kprac.id_pracownika
LEFT JOIN ksiegowosc.premie kprem ON kw.id_premii=kprem.id_premii
LEFT JOIN  ksiegowosc.pensje kpen ON kw.id_pensji=kpen.id_pensji;


SELECT
'Pracownik' AS tekst,
kprac.imie,
kprac.nazwisko,
'w dniu' AS tekst,
kgodz.data,
'otrzymał/a pensję całkowitą' AS tekst,
CASE
        WHEN kw.id_premii IS NULL THEN kpen.kwota
        ELSE kpen.kwota+kprem.kwota
    END AS wynagrodzenie,
'gdzie wynagrodzenie zasadnicze wyniosło:' AS tekst,
CASE
        WHEN kgodz.liczba_godzin>160 THEN kpen.kwota::numeric::int-(kpen.kwota::numeric::int/kgodz.liczba_godzin)*(kgodz.liczba_godzin-160)
        ELSE kpen.kwota::numeric::int
    END AS wyn_zasadnicze,
'premia:' AS tekst,
kprem.kwota,
'nadgodziny:' AS tekst,
CASE
        WHEN kgodz.liczba_godzin>160 THEN (kpen.kwota::numeric::int/kgodz.liczba_godzin)*(kgodz.liczba_godzin-160)
        ELSE 0
    END AS nadgodziny
FROM ksiegowosc.pracownicy kprac
LEFT JOIN ksiegowosc.wynagrodzenia kw ON kw.id_pracownika=kprac.id_pracownika
LEFT JOIN ksiegowosc.pensje kpen ON kw.id_pensji=kpen.id_pensji
LEFT JOIN ksiegowosc.premie kprem ON kw.id_premii=kprem.id_premii
LEFT JOIN ksiegowosc.godziny kgodz ON kw.id_godziny=kgodz.id_godziny;
