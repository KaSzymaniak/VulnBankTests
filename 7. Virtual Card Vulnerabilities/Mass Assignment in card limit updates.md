#  Vulnerability Report: Mass Assignment in Card Limit Updates
**Target Application:** Vuln-Bank (Localhost)
**Author:** Karol
**Date:** 17.03.2026
**Status:** Confirmed (PoC Created)

---

## 1. Overview
Endpoint aktualizacji limitu karty pozwala na niebezpieczne mapowanie pol z JSON na logike backendu, co umozliwia modyfikacje krytycznych atrybutow.

---

## 2. Identified Vulnerabilities

### 2.1 Mass Assignment in Update Operation (CWE-915)
* **Opis:** Backend nie ogranicza jednoznacznie listy dozwolonych pol przy aktualizacji karty.
* **Co jest nie tak:** Brak allowlisty i separacji modelu API od modelu domenowego.
* **Ryzyko:** Manipulacja limitem i potencjalnie innymi parametrami bez autoryzacji biznesowej.

---

## 3. Proof of Concept (PoC)

### 3.1 Test - Nadpisanie limitu
1. Zaloguj sie i pobierz JWT.
2. Wyslij:

```bash
curl -i -X POST http://localhost:5000/api/virtual-cards/1/update-limit \
  -H "Authorization: Bearer <JWT_USER>" \
  -H "Content-Type: application/json" \
  -d '{"new_limit":999999}'
```

3. Sprawdz, czy limit zostal zmieniony bez dodatkowych kontroli.

**Wynik:** Niewystarczajace ograniczenia aktualizacji wrazliwych pol.

---

## 4. Impact
* Obchodzenie zasad finansowych i naduzycia limitow kart.
* Ryzyko strat oraz naruszenia integralnosci danych finansowych.

---

## 5. Recommendations
* Wprowadz allowliste pol i walidacje biznesowa.
* Autoryzuj aktualizacje per zasob (czy karta nalezy do usera).
* Dodaj limity i alerty dla nietypowych zmian.

---

## 6. Final Assessment
Podatnosc **Mass Assignment in card limit updates** zostala potwierdzona. Endpoint wymaga twardej kontroli dozwolonych pol i zasad biznesowych.
