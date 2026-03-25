#  Vulnerability Report: Enabled Schema Introspection on the Transaction Analytics Endpoint

## 1. Przegląd
Endpoint GraphQL udostepnia introspekcje schematu, co ujawnia szczegoly struktury API i obiektow biznesowych.

## 2. Zidentyfikowane podatności

### 2.1 Introspekcja schematu GraphQL włączona w czasie działania
* **Opis:** Atakujacy moze pobrac pelny schemat typow i zapytan GraphQL.
* **Co jest nie tak:** Brak ograniczenia introspekcji na srodowisku runtime dostepnym dla uzytkownika.
* **Ryzyko:** Latwiejsza enumeracja zasobow i budowa precyzyjnych atakow.

## 3. Wpływ
* Ulatwienie rekonesansu i planowania kolejnych atakow.
* Wzrost ryzyka naduzyc endpointow analitycznych.


