# HTTP Headers Analysis – Information Disclosure

## Cel testów
Identyfikacja ujawnianych informacji o technologii, konfiguracji HTTP i błędów aplikacji na podstawie nagłówków odpowiedzi serwera.

---

## Wykonanie

Analizowano nagłówki odpowiedzi dla kluczowych endpointów:

```powershell
curl.exe -i http://192.168.56.6/
curl.exe -i "http://192.168.56.6/all.php"
curl.exe -i http://192.168.56.6/admin
```

### Wyniki

![HTTP headers home](../img/image.png)

![HTTP headers admin](../img/image.png)

![HTTP headers all.php](../img/image.png)

---

## Analiza odpowiedzi

### Endpoint główny (/)
- **Status:** 200 OK
- **Server:** Apache/2.2.16 (Debian)
- **X-Powered-By:** PHP/5.3.3-7+squeeze14

### Endpoint /all.php
- **Status:** 200 OK
- **Error disclosure:** Notice: Undefined index: order in /var/www/all.php on line 6
- Ujawnia ścieżkę pliku i szczegół błędu PHP

### Endpoint /admin
- **Status:** 301 Moved Permanently
- **Location:** /admin/
- Przekierowanie do katalogu z ukośnikiem

---

## Zidentyfikowane luki bezpieczeństwa

### 1. Information Disclosure – Wersje oprogramowania
**Problem:**
- Serwer ujawnia wersje Apache (2.2.16) i PHP (5.3.3-7+squeeze14)
- Wersje te są zagrożone znanymi exploitami

**Ryzyko:** 
- Atakujący może szybko zidentyfikować odpowiednie exploity
- Możliwa automatyczna eskalacja ataku

**Dowód:**
```
Server: Apache/2.2.16 (Debian)
X-Powered-By: PHP/5.3.3-7+squeeze14
```

### 2. Error Disclosure – Szczegóły błędów PHP
**Problem:**
- Aplikacja ujawnia ścieżki plików (`/var/www/all.php`)
- Wyświetla komunikaty błędów PHP w odpowiedziach HTTP
- Brakuje obsługi błędów (try-catch)

**Ryzyko:**
- Informacja o strukturze katalogów
- Możliwość identyfikacji narzędzi i frameworków
- Wskazówki do dalszego mapowania aplikacji

**Dowód:**
```
Notice: Undefined index: order in /var/www/all.php on line 6
```

### 3. Brak Security Headers
**Problem:**
- Brak nagłówków ochrony:
  - `X-Frame-Options` – brak ochrony przed clickjacking
  - `X-Content-Type-Options` – brak ochrony MIME type sniffing
  - `Content-Security-Policy` – brak CSP
  - `Strict-Transport-Security` – brak HSTS
  - `Referrer-Policy` – brak kontroli referrera

**Ryzyko:**
- Potencjalny clickjacking
- XSS podatność
- MIME type confusion
- Niezabezpieczona komunikacja (bez HTTPS)

---

## Rekomendacje bezpieczeństwa

1. **Ukryj wersje oprogramowania** w nagłówkach:
   ```apache
   ServerTokens Prod
   ServerSignature Off
   Header unset X-Powered-By
   ```

2. **Wyłącz wyświetlanie błędów** PHP w HTTP:
   ```php
   display_errors = Off
   log_errors = On
   error_log = /var/log/php_errors.log
   ```

3. **Dodaj security headers**:
   ```apache
   Header set X-Frame-Options "DENY"
   Header set X-Content-Type-Options "nosniff"
   Header set Content-Security-Policy "default-src 'self'"
   Header set Referrer-Policy "strict-origin-when-cross-origin"
   Header set Strict-Transport-Security "max-age=31536000; includeSubDomains" env=HTTPS
   ```

4. **Wdróż centralne logowanie** błędów na serwerze

5. **Monitoruj dostęp** do wrażliwych endpointów
