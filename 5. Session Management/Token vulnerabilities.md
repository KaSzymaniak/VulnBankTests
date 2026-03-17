#  Vulnerability Report: Token Vulnerabilities
**Target Application:** Vuln-Bank (Localhost)
**Author:** Karol
**Date:** 17.03.2026
**Status:** Confirmed (PoC Created)

---

## 1. Overview
Implementacja tokenow sesyjnych posiada bledy bezpieczenstwa (m.in. slaby sekret i problemy walidacji), co umozliwia manipulacje tokenem.

---

## 2. Identified Vulnerabilities

### 2.1 Weak JWT Secret and Validation Flow
* **Opis:** Konfiguracja tokenow opiera sie o slaby sekret i toleruje niebezpieczne przypadki walidacji.
* **Co jest nie tak:** Brak silnego klucza, brak twardej polityki walidacji i wygasania.
* **Ryzyko:** Przejecie sesji i privilege escalation.

---

## 3. Proof of Concept (PoC)

### 3.1 Test - Token tampering
1. Zaloguj sie i pobierz prawidlowy JWT.
2. Zmodyfikuj payload (np. `is_admin`) i podejmij probe uzycia tokena.
3. Sprawdz odpowiedz endpointu chronionego (np. `/dashboard`).

**Wynik:** Token handling nie zapewnia wystarczajacej ochrony przed manipulacja i reuse.

---

## 4. Impact
* Nieautoryzowany dostep do zasobow chronionych.
* Ryzyko przejecia kont uprzywilejowanych.

---

## 5. Final Assessment
Podatnosc **Token vulnerabilities** zostala potwierdzona. Mechanizm tokenow wymaga utwardzenia kryptograficznego i walidacyjnego.


