#  Vulnerability Report: No Amount Validation
**Target Application:** Vuln-Bank (Localhost)
**Author:** Karol
**Date:** 17.03.2026
**Status:** Confirmed (PoC Created)

---

## 1. Przegląd
Endpoint transferu nie waliduje poprawnie wartosci `amount`, co pozwala przesylac wartosci niezgodne z logika biznesowa.

---

## 2. Zidentyfikowane podatności

### 2.1 Brak walidacji kwoty po stronie serwera (CWE-20)
* **Opis:** Backend akceptuje wartosci graniczne i nieprawidlowe formaty kwot.
* **Co jest nie tak:** Brak twardych regu walidacji (`amount > 0`, maksymalna kwota, precyzja).
* **Ryzyko:** Mozliwa manipulacja saldem oraz niespojne dane finansowe.

---

## 3. Dowód koncepcji (PoC)

### 3.1 Test - Niepoprawna kwota transferu
1. Zaloguj sie i pobierz JWT.
2. Wyslij:

```bash
curl -i -X POST http://localhost:5000/transfer \
  -H "Authorization: Bearer <JWT_USER>" \
  -H "Content-Type: application/json" \
  -d '{"from_account":"1001","to_account":"1002","amount":0}'
```

3. Powtorz dla wartosci ujemnej i ekstremalnie duzej.

**Wynik:** Aplikacja nie odrzuca wszystkich niepoprawnych wartosci `amount`.

---

## 4. Wpływ
* Naruszenie integralnosci operacji finansowych.
* Ryzyko strat finansowych i blednych rozliczen.

---

## 5. Ocena końcowa
Podatnosc **No amount validation** zostala potwierdzona. Konieczna jest scisla walidacja kwot po stronie backendu.


