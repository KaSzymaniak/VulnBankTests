# SQL Injection in GraphQL Resolver Query Construction

## Opis:
Dane wejściowe użytkownika są bezpośrednio wykorzystywane do budowy zapytań SQL bez odpowiedniej walidacji lub parametryzacji. Pozwala to na manipulację zapytaniami do bazy danych poprzez specjalnie spreparowane zapytania GraphQL.

## Reprodukcja:
1. Otworzyć przeglądarkę lub narzędzie typu Postman / OWASP ZAP i wysłać żądanie do endpointu GraphQL: http://localhost:5000/graphql
2. Wysłać zapytanie GraphQL zawierające parametr wejściowy, np.:
```graphql
query {
  user(id: "1") {
    id
    name
  }
}
```
3. Zmodyfikować parametr wejściowy, wprowadzając nieoczekiwane znaki (np. apostrof ') w celu wywołania błędu SQL:
```
query {
  user(id: "1'") {
    id
    name
  }
}
```
4. Obserwować odpowiedź serwera w DevTools (F12) → Network lub w konsoli ZAP / Postman.
5. Sprawdzić, czy pojawiają się błędy związane z bazą danych (np. SQL syntax error) lub ujawniające strukturę tabel i pól.

## Rezultaty:
- Serwer zwraca błędy SQL lub inne nieprawidłowe odpowiedzi wskazujące na niebezpieczne budowanie zapytań.
- Możliwe jest wpływanie na zapytania wykonywane przez backend poprzez manipulację danymi wejściowymi.
- Informacje o schemacie bazy danych mogą być ujawnione w odpowiedzi (raw error disclosure).
