# No Validation on Biller ID

## Opis:
Aplikacja nie weryfikuje poprawności identyfikatora odbiorcy płatności (`billerId`). Użytkownik może dowolnie modyfikować wartość `billerId` w żądaniu (np. przy użyciu narzędzi takich jak OWASP ZAP), co pozwala na wykonywanie transakcji na rzecz nieautoryzowanych lub nieistniejących odbiorców.

## Reprodukcja:
1. Zalogować się do aplikacji jako użytkownik.
2. Przejść do funkcjonalności opłacania rachunków.
3. Opłacić jakiś przykładowy rachunek.
4. Otworzyć OWASP ZAP i przechwycić żądanie płatności (np. `POST /api/bill/pay`).
5. Zmodyfikować wartość `billerId` na dowolną (np. losowa wartość).
6. Wysłać zmodyfikowane żądanie.

## Rezultat:
- Aplikacja akceptuje dowolny `billerId` bez walidacji.
- Transakcja zostaje przetworzona mimo nieprawidłowego lub nieautoryzowanego identyfikatora.
- Możliwe jest kierowanie płatności do nieuprawnionych odbiorców.
