# No Rate Limiting

## Opis:
Aplikacja nie posiada ograniczeń dotyczących liczby prób logowania. Brak mechanizmu rate limiting lub blokady konta umożliwia atakującemu wykonywanie nieograniczonej liczby prób zgadnięcia hasła (brute-force) dla dowolnego użytkownika.

## Reprodukcja:
1. Przejść do formularza logowania w aplikacji.
2. Wprowadzić niepoprawne dane logowania.
3. Wysyłać wielokrotne żądania logowania z losowymi lub przewidywalnymi hasłami (np. OWASP ZAP).
4. Monitorować odpowiedzi serwera i sprawdzić, czy kolejne próby są akceptowane bez ograniczeń.

## Rezultat:
- Serwer przyjmuje dowolną liczbę prób logowania bez ograniczeń.
- Brak blokady konta lub opóźnień między próbami umożliwia skuteczny atak brute-force lub dictionary.
- Potencjalne skutki:
  - przejęcie kont użytkowników
  - naruszenie bezpieczeństwa danych
  - przeciążenie strony
