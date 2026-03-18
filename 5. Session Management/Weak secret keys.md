
# Vulnerability Report: Weak JWT Secret Key

**Target Application:** Vuln-Bank (Localhost)  
**Author:** Dominik  
**Date:** 18.03.2026  

---

## 1. Overview

W trakcie testów bezpieczeństwa zidentyfikowano krytyczną podatność wynikającą z użycia słabego sekretu do podpisywania tokenów JWT oraz braku poprawnej walidacji danych zawartych w tokenie.

Sekret (`secret123`) jest trywialny i możliwy do odgadnięcia, co umożliwia generowanie dowolnych, poprawnie podpisanych tokenów. Dodatkowo aplikacja ufa polu `user_id` zawartemu w payloadzie JWT, co pozwala na dostęp do danych innych użytkowników.

---

## 2. Identified Vulnerability

### 2.1 Weak JWT Secret Key + Broken Access Control (CWE-522 / CWE-287 / CWE-284)

- **Opis:**  
  Aplikacja wykorzystuje słaby sekret (`secret123`) do podpisywania tokenów JWT (algorytm HS256) oraz nie weryfikuje poprawnie tożsamości użytkownika po stronie backendu.

- **Problem:**  
  - sekret JWT jest łatwy do odgadnięcia  
  - backend ufa danym zawartym w tokenie (np. `user_id`)  
  - brak walidacji dostępu do zasobów  

- **Skutek:**  
  - możliwość generowania dowolnych tokenów  
  - możliwość podszywania się pod innych użytkowników  
  - dostęp do danych innych użytkowników  

---

## 3. Proof of Concept (PoC)

### 3.1 Pobranie tokenu

Token JWT został pobrany z przeglądarki:

- Otworzono DevTools (F12)  
- Przejście do zakładki **Application → Local Storage**  
- Odczyt wartości klucza:

eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6ImRvbWluaWsiLCJpc19hZG1pbiI6ZmFsc2UsImlhdCI6MTc3Mzg2OTUwMX0.kjJEG_slbUaYqBfHP3S2o_g6QF4KNw6rmWCmpjdm-Fc

---

### 3.2 Analiza tokenu

Token został wklejony do narzędzia (np. jwt.io), gdzie uzyskano:

- Header: {"alg": "HS256"}  
- Payload: {"user_id": 2, "username": "dominik", "is_admin": false, "iat": 1773869501}  

Wniosek:

- Token wykorzystuje algorytm symetryczny HS256  
- Do weryfikacji wymagany jest sekret serwera  

---

### 3.3 Odgadnięcie sekretu

Przeprowadzono próbę zgadnięcia sekretu przy użyciu popularnych wartości:

- secret  
- password  
- admin  
- secret123  

Po wprowadzeniu:
```
secret123  
```
uzyskano wynik:
```
{"Valid JWT, Signature verified"}
```
Wniosek:

- Sekret został poprawnie odgadnięty  
- Możliwe jest podpisywanie dowolnych tokenów  

---

### 3.4 Modyfikacja tokenu

Zmodyfikowano payload:
```java
{
  "user_id": 1,
  "username": "admin",
  "is_admin": true,
  "iat": 1773869501
}
```
Token został ponownie podpisany przy użyciu:
```
secret123  
```
---

### 3.5 Wykorzystanie podatności (IDOR)

Po zmianie wartości `user_id` w tokenie:

- widoczne są dane (karty) innych użytkowników w ekranie aplikacji
- brak weryfikacji uprawnień po stronie backendu  

---


## 4. Wnioski exploit'u

- Sekret JWT jest słaby i możliwy do odgadnięcia  
- Tokeny mogą być dowolnie modyfikowane i podpisywane  
- Backend akceptuje sfałszowane tokeny  
- Backend ufa polu `user_id` zawartemu w JWT  
- Brak kontroli dostępu na poziomie zasobów  

---

## 5. Możliwe zagrożenia

- Możliwość podszywania się pod dowolnego użytkownika  
- Dostęp do danych innych użytkowników (np. kart płatniczych)  
- Naruszenie poufności danych  
- Możliwość dalszej eskalacji uprawnień  
- Pełne obejście mechanizmu autoryzacji  

---

## 7. Rekomendacje

- Zmiana sekretu JWT na silny, losowy (min. 256-bit)  
- Przechowywanie sekretu w zmiennych środowiskowych  
- Nie ufać danym zawartym w JWT (np. `user_id`)  
- Weryfikować użytkownika po stronie backendu (np. na podstawie sesji / DB)  
- Implementacja kontroli dostępu (authorization checks)  
- Wprowadzenie mechanizmów audytu i logowania  
