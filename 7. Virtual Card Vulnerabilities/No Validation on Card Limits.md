# No Validation on Card Limits

## Opis:
Aplikacja nie weryfikuje poprawnie limitów finansowych podczas dodawania nowej karty płatniczej. Brak walidacji dostępnych środków lub limitów kredytowych umożliwia stworzenie karty płatniczej z ujemnym limite środków.

## Reprodukcja:
1. Zalogować się do aplikacji jako użytkownik.
2. Przejść do funkcjonalności dodawania nowej karty płatniczej.
4. Wprowadzić kwotę na minusie jako limit karty.
5. Wysłać żądanie o dodaniu karty płatniczej.

![Image].(../CardLimitIMG.png)

## Rezultat:
Aplikacja akceptuje transakcje mimo braku sensu logicznego, co skutkuje:
- możliwością stworzenia karty płatniczej, która nie działa

