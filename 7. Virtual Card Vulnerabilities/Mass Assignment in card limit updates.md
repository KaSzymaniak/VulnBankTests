#  Vulnerability Report: Mass Assignment in Card Limit Updates

## 1. Przegląd
Endpoint aktualizacji limitu karty pozwala na niebezpieczne mapowanie pol z JSON na logike backendu, co umozliwia modyfikacje krytycznych atrybutow.

## 2. Zidentyfikowane podatności

### 2.1 Masowe przypisanie w operacji aktualizacji
- **Opis:** Backend nie ogranicza jednoznacznie listy dozwolonych pol przy aktualizacji karty.
- **Co jest nie tak:** Brak allowlisty i separacji modelu API od modelu domenowego.
- **Ryzyko:** Manipulacja limitem i potencjalnie innymi parametrami bez autoryzacji biznesowej.

## 3. Wpływ
- Obchodzenie zasad finansowych i naduzycia limitow kart.
- Ryzyko strat oraz naruszenia integralnosci danych finansowych.

## 4. Ocena końcowa
Podatnosc **Mass Assignment in card limit updates** zostala potwierdzona. Endpoint wymaga twardej kontroli dozwolonych pol i zasad biznesowych.


