# SQL Injection

W trakcie przeprowadzonych testów penetracyjnych zidentyfikowano podatność aplikacji na atak typu **SQL Injection**. Opisano następujące kroki ataku oraz uzyskane wyniki.

## Mechanizm Ataku

1. **Atak SQL Injection**: 
   - **Login**: Wprowadzenie ciągu `' or 1 = 1; --` jako login skutkuje pomyślnym zalogowaniem się jako użytkownik admina. Ten nieautoryzowany dostęp jest możliwy dzięki wykorzystaniu luki w walidacji danych wejściowych, co skutkuje wykonaniem zapytania, które zawsze zwraca prawdę (`1 = 1`).

2. **Brak informacji o wersji bazy danych**:
   - Użycie standardowych technik do pozyskania informacji o wersji bazy danych zostało zablokowane, co zwiększa bezpieczeństwo aplikacji. Jednak aplikacja wciąż wykazuje inne słabości, które można wykorzystać.

3. **Dostęp do tabeli**:
   - Próba niepoprawnego logowania (np. poprzez wprowadzenie złego loginu) generuje komunikat o błędzie, co umożliwia identyfikację tabeli `users`. 

4. **Uzyskanie listy użytkowników**:
   - Wprowadzenie atakującego ciągu `‘ or 1 = 1; select * from users; --` jako login skutkuje zwróceniem pełnej listy użytkowników z tabeli `users`. Wydobycie tych informacji potwierdza istnienie podatności na SQL Injection.

## Podsumowanie i Wnioski

Podczas przeprowadzonych testów penetracyjnych odkryto poważną datę w zabezpieczeniach aplikacji, umożliwiającą uzyskanie nieautoryzowanego dostępu oraz wyciąganie poufnych informacji. Kluczowe zalecenia to:

- **Wdrażanie filtracji danych wejściowych**: Należy wprowadzić silniejsze walidacje i sanitizację danych wejściowych, aby zapobiec wykonywaniu nieautoryzowanych zapytań SQL.
- **Użycie parametrów zapytań**: Zastosowanie parametrów w zapytaniach SQL, co znacząco zredukowałoby ryzyko SQL Injection.
- **Przeprowadzanie regularnych testów bezpieczeństwa**: Regularne audyty i testy penetracyjne są kluczowe dla identyfikacji potencjalnych luk w zabezpieczeniach.