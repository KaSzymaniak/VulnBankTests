#  Vulnerability Report: Weak JWT Implementation


## 1. Przegląd
Podczas analizy mechanizmu sesji opartego na **JSON Web Tokens (JWT)**, zidentyfikowano krytyczne błędy w implementacji bezpieczeństwa. Aplikacja ufa danym przesyłanym w tokenie bez odpowiedniej walidacji po stronie serwera, co pozwala na przejęcie uprawnień administratora.


## 2. Zidentyfikowane podatności

### 2.1 Brak żądania wygaśnięcia (claim exp)
* **Opis:** Token zawiera jedynie pole `iat` (Issued At). Brak pola `exp` (Expiration Time) sprawia, że sesja użytkownika jest bezterminowa.
* **Ryzyko:** Raz przejęty token pozwala atakującemu na dostęp do konta ofiary na zawsze.

### 2.2 Pomieszanie algorytmów (Atak None) - CVE-2015-2951
* **Opis:** Serwer akceptuje tokeny z nagłówkiem `"alg": "none"`. Pozwala to na całkowite usunięcie podpisu kryptograficznego i ręczną edycję danych wewnątrz tokena.
* **Ryzyko:** Krytyczne. Każdy użytkownik może stać się administratorem.

### 2.3 Eskalacja uprawnień poprzez manipulację ładunkiem (Payload)
* **Opis:** Flaga `is_admin` oraz identyfikator `user_id` są przechowywane bezpośrednio w części *Payload*. Ponieważ serwer nie weryfikuje podpisu, dane te mogą być modyfikowane przez klienta.


## 3. Dowód koncepcji (PoC)

### Oryginalny token:
```text
eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6IkthcmNpYWN6ZWsiLCJpc19hZG1pbiI6ZmFsc2UsImlhdCI6MTc3MzczNjU0OX0...
```