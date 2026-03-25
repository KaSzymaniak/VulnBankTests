# SQL Injection in GraphQL Resolver Query Construction

## Opis:
Dane wejściowe użytkownika są bezpośrednio wykorzystywane do budowy zapytań SQL bez odpowiedniej walidacji lub parametryzacji. Pozwala to na manipulację zapytaniami do bazy danych poprzez specjalnie spreparowane zapytania GraphQL.

## Reprodukcja:
1. Otworzyć przeglądarkę i za pomocą Dev Tools (F12) znaleźć token
2. Wysłać zapytanie GraphQL zawierające parametr wejściowy używając terminala:
```bash
curl -X POST http://localhost:5000/graphql
-H "Content-Type: application/json"
-H "Authorization: Bearer Token"
-d "{\"query\":\"{ __type(name: \\\"TransactionSummaryType\\\") { name fields { name type { name kind ofType { name } } } } }\"}"
```
![Image](img\GraphlSQLInjIMG.png)

## Rezultaty:
- Możliwe jest wpływanie na zapytania wykonywane przez backend poprzez manipulację danymi wejściowymi.
- Informacje o schemacie bazy danych mogą być ujawnione w odpowiedzi.
