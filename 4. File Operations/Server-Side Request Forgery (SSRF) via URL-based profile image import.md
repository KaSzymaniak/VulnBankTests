# Vulnerability Report: Server-Side Request Forgery (SSRF) with Internal Network Access

## 1. Przegląd

W aplikacji wykryto krytyczną podatność typu **Server-Side Request Forgery (SSRF)** w funkcjonalności importu zdjęcia profilowego z URL. Backend wykonuje zapytania HTTP na podstawie danych dostarczonych przez użytkownika bez jakiejkolwiek walidacji, co umożliwia dostęp do zasobów wewnętrznych oraz skanowanie usług działających na serwerze.

## 2. Zidentyfikowana podatność

### 2.1 Nieograniczony SSRF poprzez import obrazu profilowego 

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

## 3. Wnioski

* możliwość skanowania portów na serwerze (internal port scanning)
* wykrywanie usług backendowych (PostgreSQL, Redis)
* mapowanie infrastruktury wewnętrznej
* potencjalny dostęp do usług nieprzeznaczonych dla użytkownika
* możliwość wykorzystania podatności w dalszych atakach (pivoting)

Podatność SSRF została potwierdzona. Aplikacja umożliwia wykonywanie zapytań HTTP do dowolnych adresów, w tym do usług wewnętrznych działających na serwerze.