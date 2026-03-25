# No Validation on Card Limits

## 1. Opis:
Aplikacja nie weryfikuje poprawnie limitów finansowych podczas dodawania nowej karty płatniczej. Brak walidacji dostępnych środków lub limitów kredytowych umożliwia stworzenie karty płatniczej z ujemnym limite środków.

## 2. Reprodukcja:
- Zalogować się do aplikacji jako użytkownik.
- Przejść do funkcjonalności dodawania nowej karty płatniczej.
- Wprowadzić kwotę na minusie jako limit karty.
- Wysłać żądanie o dodaniu karty płatniczej.

![Image](img\CardLimitIMG.png)

## 3. Rezultat:
Aplikacja akceptuje transakcje mimo braku sensu logicznego, co skutkuje:
- możliwością stworzenia karty płatniczej, która nie działa

