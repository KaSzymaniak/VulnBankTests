#  Vulnerability Report: No Amount Validation

## 1. Przegląd
Endpoint transferu nie waliduje poprawnie wartosci `amount`, co pozwala przesylac wartosci niezgodne z logika biznesowa.


## 2. Zidentyfikowane podatności

### 2.1 Brak walidacji kwoty po stronie serwera
* **Opis:** Backend akceptuje wartosci graniczne i nieprawidlowe formaty kwot.
* **Co jest nie tak:** Brak twardych regu walidacji (`amount > 0`, maksymalna kwota, precyzja).
* **Ryzyko:** Mozliwa manipulacja saldem oraz niespojne dane finansowe.

## 3. Wpływ
* Naruszenie integralnosci operacji finansowych.
* Ryzyko strat finansowych i blednych rozliczen.

## 4. Ocena końcowa
Podatnosc **No amount validation** zostala potwierdzona. Konieczna jest scisla walidacja kwot po stronie backendu.


