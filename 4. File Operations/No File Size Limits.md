# No File Size Limits

## Opis:
Aplikacja umożliwia przesyłanie plików użytkownikom bez ograniczenia maksymalnego rozmiaru. Brak limitów powoduje ryzyko wyczerpania zasobów serwera (CPU, pamięci, przestrzeni dyskowej), co może prowadzić do Denial of Service (DoS) lub innych problemów z wydajnością.

## Reprodukcja:
1. Zalogować się do aplikacji jako użytkownik.
2. Przejść do funkcjonalności umożliwiającej upload plików.
3. Przygotować plik o dużym rozmiarze (np. kilka GB) lub skrypt generujący wielokrotne żądania uploadu.
4. Przesłać plik przez interfejs aplikacji.
5. Monitorować zachowanie serwera (czas odpowiedzi, zużycie CPU/memory, logi).

## Rezultat:
- Aplikacja przyjmuje plik bez ograniczeń rozmiaru.  
- Możliwe skutki:
  - spowolnienie lub zawieszenie aplikacji
  - wyczerpanie miejsca na dysku
