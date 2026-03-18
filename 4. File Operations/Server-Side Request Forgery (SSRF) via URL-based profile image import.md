# Vulnerability Report: Server-Side Request Forgery (SSRF) with Internal Network Access

**Target Application:** Vuln-Bank (Localhost)
**Author:** Dominik
**Date:** 18.03.2026

---

## 1. Overview

W aplikacji wykryto krytyczną podatność typu **Server-Side Request Forgery (SSRF)** w funkcjonalności importu zdjęcia profilowego z URL. Backend wykonuje zapytania HTTP na podstawie danych dostarczonych przez użytkownika bez jakiejkolwiek walidacji, co umożliwia dostęp do zasobów wewnętrznych oraz skanowanie usług działających na serwerze.

---

## 2. Identified Vulnerability

### 2.1 Unrestricted SSRF via Profile Image Import (CWE-918)

* **Opis:** Endpoint `upload_profile_picture_url` pobiera zasób na podstawie URL dostarczonego przez użytkownika.
* **Co jest nie tak:**

  * brak walidacji adresów URL
  * brak blokady adresów lokalnych i prywatnych
  * brak ograniczeń dotyczących portów i protokołów
* **Ryzyko:**

  * dostęp do usług backendowych (np. PostgreSQL, Redis)
  * możliwość skanowania portów (internal network enumeration)
  * ujawnienie architektury systemu
  * potencjalny pivot do dalszych ataków

---

## 3. Proof of Concept (PoC)

### 3.1 Przygotowanie środowiska

Uruchomiono aplikację:

```bash id="6l6q1k"
docker-compose up --build
```

Otworzono aplikację:

```text id="o7hx3v"
http://localhost:5000
```

Zalogowano się jako użytkownik:

```text id="0k1j3g"
dominik2
```

---

### 3.2 Przechwycenie requestów

1. Otworzono DevTools (**F12**)
2. Przejście do zakładki:

```id="ghz0h4"
Network → Fetch/XHR
```

---

### 3.3 Test bazowy

Wprowadzono URL:

```text id="bztx2o"
http://example.com
```

**Wynik:**

* status: `200 OK`
* komunikat: `Imported from URL successfully`

---

### 3.4 Dostęp do localhost

Wprowadzono:

```text id="iywq3q"
http://127.0.0.1:5000
```

**Wynik:**

* status: `200 OK`
* backend wykonuje request do własnego serwera

---

### 3.5 Test dostępu do usług wewnętrznych (port scanning)

Wprowadzono:

```text id="kq1t1n"
http://127.0.0.1:5432
```

**Wynik:**

* status: `500 Internal Server Error`

---

Wprowadzono:

```text id="1q6o2g"
https://127.0.0.1:6379
```

**Wynik:**

* status: `500 Internal Server Error`

---

Wprowadzono:

```text id="q9v2zw"
http://172.16.0.0
```

**Wynik:**

* status: `500 Internal Server Error`

---

### 3.6 Interpretacja wyników

Błąd `500 Internal Server Error` wskazuje, że:

* backend podjął próbę połączenia z docelowym hostem/portem
* usługa nie obsługuje protokołu HTTP (np. PostgreSQL, Redis)
* brak obsługi odpowiedzi skutkuje wyjątkiem aplikacji

**Wniosek:** Backend ma dostęp do usług wewnętrznych i podejmuje próby połączeń.

---

## 4. Wnioski

* możliwość skanowania portów na serwerze (internal port scanning)
* wykrywanie usług backendowych (PostgreSQL, Redis)
* mapowanie infrastruktury wewnętrznej
* potencjalny dostęp do usług nieprzeznaczonych dla użytkownika
* możliwość wykorzystania podatności w dalszych atakach (pivoting)

Podatność SSRF została potwierdzona. Aplikacja umożliwia wykonywanie zapytań HTTP do dowolnych adresów, w tym do usług wewnętrznych działających na serwerze.

Uzyskane odpowiedzi `500 Internal Server Error` wskazują na możliwość komunikacji backendu z usługami nieobsługującymi HTTP, co stanowi dowód dostępu do wewnętrznej infrastruktury.

Podatność klasyfikowana jako: **CRITICAL**

---

## 5. Jak zabezpieczyć się przed tym problemem?

* blokada adresów lokalnych:

  * `127.0.0.0/8`
  * `0.0.0.0`
  * `::1`
* blokada zakresów prywatnych (RFC1918):

  * `10.0.0.0/8`
  * `172.16.0.0/12`
  * `192.168.0.0/16`
* walidacja adresów URL poprzez rozwiązywanie DNS i sprawdzanie IP
* zastosowanie whitelisty domen zamiast blacklisty
* blokada dostępu do portów innych niż HTTP/HTTPS
* użycie proxy kontrolującego ruch wychodzący
* obsługa błędów bez ujawniania informacji o backendzie

---
