# SQLMap – Automatyczne skanowanie podatności

## Cel testów
Weryfikacja podatności SQL Injection oraz automatyczna ekstrakcja informacji o bazie danych przy użyciu narzędzia SQLMap.

---

## Wykonanie

### Komenda

```bash
sqlmap -u "https://192.168.X.X/cat.php?id=1" --dbs
```

Gdzie za X należy podstawić adres IP maszyny wirtualnej w sieci.

---

## Wyniki skanowania

![SQLMap results](../img/image.png)

---

## Analiza wyników

### Potwierdzenie podatności

W trakcie testów SQLMap potwierdziła, że parametr `id` jest podatny na SQL Injection.

### Typy wykrytych podatności

#### 1. Boolean-based blind SQL Injection
- Podatna na klauzle WHILE lub HAVING
- Możliwość ekstrakcji danych poprzez evaluację warunkowych zapytań
- Wolniejsza metoda, wymaga wielu requestów

#### 2. Error-based SQL Injection
- Wykryto podatność poprzez funkcję EXTRACTVALUE
- Typ bazy danych: MySQL > 5.1
- Szybka metoda - dane zwracane w komunikatach błędu

#### 3. Time-based blind SQL Injection
- Wykorzystuje funkcję SLEEP()
- Dane ekstraktowane poprzez opóźnienia w odpowiedzi serwera
- Skuteczna na serwerach z wolnym czasem odpowiedzi

#### 4. UNION-based SQL Injection
- Wykryto możliwość użycia UNION SELECT
- Liczba kolumn: 1 – 20
- Najszybsza metoda - dane bezpośrednio w odpowiedzi HTTP

#### 5. Stacked queries (częściowo dostępne)
- Wykryto możliwość wykonywania wielu zapytań SQL
- Potencjalnie umożliwia modyfikację danych i eskalację ataku

---

## Informacje o bazie danych

- **DBMS:** MySQL
- **Wersja:** > 5.0.12
- **Funkcje dostępne:** EXTRACTVALUE, SLEEP, UNION SELECT

---

## Wnioski

SQLMap potwierdziła zagrożenie i zidentyfikowała **5 różnych metod** przeprowadzenia ataku SQL Injection. Każda metoda ma różne cechy i zastosowania w zależności od konfiguracji serwera.
