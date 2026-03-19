# No Transaction Limits 

## Opis:
Aplikacja nie posiada odpowiednich ograniczeń dotyczących liczby oraz wartości wykonywanych transakcji. Brak mechanizmów kontroli (np. ograniczenie ilości przeprowadzanych transakcji, walidacja salda) umożliwia wykonywanie wielu operacji w krótkim czasie, co może prowadzić do niespójności danych i uzyskania ujemnego salda konta.

## Reprodukcja:
1. Zalogować się do aplikacji.
2. Wypełnić formularz do przelewów.
3. Przechwycić żądanie HTTP w narzędziu proxy (np. OWASP ZAP).
4. Zidentyfikować parametr odpowiedzialny za kwotę transakcji.
5. Wykonać wielokrotne żądania w krótkim czasie (np. przy użyciu fuzzingu).
6. Obserwować zmiany salda konta po wykonaniu wielu operacji.

![Image](img\TransactionIMG.png)

## Rezultat:
Aplikacja pozwala na wykonanie wielu transakcji bez odpowiednich ograniczeń, co skutkuje:
- możliwością przekroczenia dostępnego salda
- uzyskaniem ujemnego stanu konta
- niespójnością danych finansowych


