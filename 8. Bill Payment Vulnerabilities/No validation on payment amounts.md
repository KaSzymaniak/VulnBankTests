#  Vulnerability Report: No Validation on Payment Amounts
**Target Application:** Vuln-Bank (Localhost)
**Author:** Karol
**Date:** 17.03.2026
**Status:** Confirmed (PoC Created)

---

## 1. Overview
W procesie oplacania rachunkow brak jest pelnej walidacji kwoty platnosci, co pozwala na operacje niezgodne z regula biznesowa.

---

## 2. Identified Vulnerabilities

### 2.1 Missing Amount Validation in Bill Payments (CWE-20)
* **Opis:** Endpoint akceptuje kwoty bez scislej kontroli zakresu i poprawnosci.
* **Co jest nie tak:** Brak walidacji dodatniej kwoty, gornych limitow oraz precyzji.
* **Ryzyko:** Manipulacja platnosciami i niespojnosc historii finansowej.

---

## 3. Proof of Concept (PoC)

### 3.1 Test - Niepoprawna kwota platnosci
1. Zaloguj sie i pobierz JWT.
2. Wyslij:

```bash
curl -i -X POST http://localhost:5000/api/bill-payments/create \
  -H "Authorization: Bearer <JWT_USER>" \
  -H "Content-Type: application/json" \
  -d '{"biller_id":1,"amount":-50,"payment_method":"bank_account"}'
```

3. Sprawdz odpowiedz i zapis transakcji.

**Wynik:** Brak kompletnego odrzucenia niepoprawnych kwot.

---

## 4. Impact
* Mozliwosc naduzyc finansowych.
* Zaburzenie integralnosci historii platnosci.

---

## 5. Recommendations
* Wymus `amount > 0`, limity i precyzje decimal.
* Dodaj reguly antyfraudowe i walidacje biznesowe per biller.
* Pokryj endpoint testami negatywnymi.

---

## 6. Final Assessment
Podatnosc **No validation on payment amounts** zostala potwierdzona. Niezbedna jest silna walidacja danych finansowych po stronie serwera.
