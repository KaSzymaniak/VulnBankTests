# Debug Information Exposure

## Opis:
Aplikacja ujawnia szczegółowe komunikaty błędów bazy danych, takie jak „SQL syntax error”. Tego typu informacje nie powinny być dostępne dla użytkownika końcowego, ponieważ mogą ujawniać wewnętrzną logikę aplikacji oraz strukturę zapytań SQL.

## Reprodukcja:
1. Przejść do ekranu logowania.
2. Wprowadzić nieprawidłowe lub nieoczekiwane dane wejściowe (np. specjalne znaki, błędny format).
3. Otworzyć DevTools (F12) → zakładka **Network**.
4. Wybrać odpowiednie żądanie i przejść do sekcji **Response**.
5. Zaobserwować odpowiedź serwera zawierającą komunikat błędu SQL (np. „SQL syntax error”).

## Rezultat:
Aplikacja zwraca szczegółowe komunikaty błędów, takie jak:
- `SQL syntax error near ...`
- `You have an error in your SQL syntax`
- `syntax error at or near ...`

Komunikaty te mogą ujawniać:
- fragmenty zapytań SQL
- nazwy tabel i kolumn
