#  Vulnerability Report: SQL Injection in Login
**Target Application:** Vuln-Bank (Localhost)
**Author:** Karol
**Date:** 17.03.2026
**Status:** Confirmed (PoC Created)

---

## 1. Overview
Podczas testow endpointu logowania wykryto SQL Injection. Parametry `username` i `password` sa laczone z zapytaniem SQL bez bezpiecznej parametryzacji.

---

## 2. Identified Vulnerabilities

### 2.1 SQL Injection in Authentication Query (CWE-89)
* **Opis:** Dane wejsciowe z formularza logowania sa wstrzykiwane bezposrednio do zapytania SQL.
* **Co jest nie tak:** Brak prepared statements / parameterized queries.
* **Ryzyko:** Obejscie logowania i potencjalny nieautoryzowany dostep do kont.

---

## 3. Proof of Concept (PoC)

### 3.1 Test - Login bypass
1. Otworz logowanie HTTP POST na `http://localhost:5000/login`.
2. Uzyj payloadu SQLi:

```text
username: ' OR '1'='1' --
password: dowolne
```

3. Wyslij zadanie i sprawdz, czy aplikacja tworzy sesje/token.

**Wynik:** Mozliwe obejscie normalnej walidacji hasla i zalogowanie bez prawidlowych danych.

---

## 4. Impact
* Nieautoryzowany dostep do kont.
* Mozliwa eskalacja i pelne przejecie aplikacji przy laczeniu z innymi lukami.

---

## 5. Final Assessment
Podatnosc **SQL Injection in login** zostala potwierdzona. Mechanizm logowania nie powinien budowac zapytan SQL przez konkatenacje stringow.


