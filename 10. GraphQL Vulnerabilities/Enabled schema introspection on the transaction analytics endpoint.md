#  Vulnerability Report: Enabled Schema Introspection on the Transaction Analytics Endpoint
**Target Application:** Vuln-Bank (Localhost)
**Author:** Karol
**Date:** 17.03.2026
**Status:** Confirmed (PoC Created)

---

## 1. Overview
Endpoint GraphQL udostepnia introspekcje schematu, co ujawnia szczegoly struktury API i obiektow biznesowych.

---

## 2. Identified Vulnerabilities

### 2.1 GraphQL Schema Introspection Enabled in Runtime
* **Opis:** Atakujacy moze pobrac pelny schemat typow i zapytan GraphQL.
* **Co jest nie tak:** Brak ograniczenia introspekcji na srodowisku runtime dostepnym dla uzytkownika.
* **Ryzyko:** Latwiejsza enumeracja zasobow i budowa precyzyjnych atakow.

---

## 3. Proof of Concept (PoC)

### 3.1 Test - Introspection query
1. Zaloguj sie i pobierz JWT.
2. Wyslij zapytanie:

```bash
curl -i -X POST http://localhost:5000/graphql \
  -H "Authorization: Bearer <JWT_USER>" \
  -H "Content-Type: application/json" \
  -d '{"query":"{ __schema { types { name } } }"}'
```

3. Sprawdz, czy odpowiedz zwraca liste typow schematu.

**Wynik:** Introspekcja jest dostepna i ujawnia strukture API.

---

## 4. Impact
* Ulatwienie rekonesansu i planowania kolejnych atakow.
* Wzrost ryzyka naduzyc endpointow analitycznych.

---

## 5. Final Assessment
Podatnosc **Enabled schema introspection on the transaction analytics endpoint** zostala potwierdzona. Endpoint GraphQL wymaga utwardzenia konfiguracji produkcyjnej.


