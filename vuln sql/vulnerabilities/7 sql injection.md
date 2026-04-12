# Wykorzystanie podatności SQL Injection 

## Cel testów
Weryfikacja podatności typu SQL Injection w parametrze `id` oraz ekstrakcja danych z bazy danych poprzez technikę UNION-based SQL Injection.

---

## Wykonanie

Testy przeprowadzono na endpoint'cie
```
http://192.168.X.X/cat.php?id=1
```
Gdzie za X należy podstawić adres IP maszyny wirtualnej w sieci

W trakcie analizy wykorzystano ręczne testy UNION SQL Injection oraz narzędzie sqlmap.

---

## Wstępna identyfikacja podatności

Parametr `id` został potwierdzony jako podatny na SQL Injection.

### Wyniki testów:

- możliwość wykonania UNION SELECT
- identyfikacja struktury zapytania (4 kolumny)
- możliwość ekstrakcji danych z bazy

---

## Struktura zapytania SQL

Wykryto, że zapytanie SQL posiada:

- Liczba kolumn: **4**
- Przynajmniej jedna kolumna jest reflektowana w odpowiedzi HTTP

---

## Wyekstraktowane dane

### 1. Nazwa bazy danych

![](../img/sqlmapdatabase.png)

---

### 2. Lista tabel

Uzyskano dostęp do metadanych bazy danych poprzez `information_schema.tables`, co pozwoliło na identyfikację dostępnych tabel w systemie.

![](../img/sqlmaptabele.png)

---

### 3. Lista Kolumn

Uzyskano dostęp do metadanych bazy danych poprzez `information_schema.columns`, co pozwoliło na identyfikację dostępnych tabel w systemie.
![](../img/sqlmapkolumny.png)
---

### 4. Hasło użytkownika z dostępem administratorskim

![](../img/sqlmaphasło.png)
---

### Wyniki

Uzyskane hasło jest zahashowane, ale po wklejeniu go do przeglądaraki otrzymujemy możliwość odhashowania za pomocą algorytmu MD5
