# Punkty podatności na SQL Injection

## Punkty podatności na SQL Injection

Poniżej przedstawiono kluczowe obszary, w których aplikacje mogą być narażone na zagrożenie SQL Injection:

| **Punkt Podatności**                     | **Opis**                                                                                          | **Przykład**                                                                                           |
|------------------------------------------|--------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------|
| **Formularze logowania**                 | Niezabezpieczone pola wejściowe w formularzach umożliwiają atakującym manipulację zapytań SQL.   | Wprowadzenie ciągu `' OR 1=1; --` jako login powoduje nieautoryzowane logowanie.                     |
| **Pola wyszukiwania**                   | Wyszukiwanie bez walidacji danych może prowadzić do dynamicznego tworzenia zapytań SQL.            | Użycie niebezpiecznego ciągu może umożliwić wyciąganie danych z tabeli.                               |
| **Parametry URL**                       | Nieodpowiednia obsługa parametrów w adresie URL, które są bezpośrednio włączane do zapytań SQL.  | Możliwość modyfikacji parametrów jak `?id=1; DROP TABLE users; --` w celu usunięcia tabeli.          |
| **Brak stosowania Prepared Statements** | Wykonywanie zapytań SQL bez użycia z bezpiecznych metod, takich jak przygotowane wyrażenia.      | Bez parametrów, zapytania są bardziej podatne na manipulację przez atakujących.                      |
| **Nieprawidłowe komunikaty o błędach**  | Wyświetlanie szczegółowych komunikatów o błędach, które mogą ujawniać struktury bazy danych.      | Błąd SQL zwracający szczegółowe informacje o kolumnach i tabelach, co ułatwia atak.                   |

## Zalecenia Zabezpieczeń

Aby zredukować ryzyko ataków typu SQL Injection, należy rozważyć następujące praktyki:

1. **Wykorzystanie przygotowanych instrukcji (Prepared Statements)**:
   - Umożliwia to oddzielenie danych od kodu SQL, co sprawia, że zapytania są znacznie bezpieczniejsze.

2. **Sanitizacja i walidacja danych wejściowych**:
   - Każda dana wprowadzona przez użytkownika powinna być poprawiana i walidowana, aby potwierdzić jej poprawność i izoąć niebezpieczne znaki.

3. **Minimalizacja danych wyjściowych**:
   - Wyświetlanie użytkownikowi jedynie potrzebnych informacji. Unikanie ujawniania struktury bazy danych.

4. **Ograniczenie uprawnień użytkowników**:
   - Kontrole dostępu powinny być szczegółowo zarządzane, aby minimalizować ryzyko dostępu do wrażliwych danych.

5. **Regularne testy penetracyjne**:
   - Umożliwia to identyfikację nowych luk oraz ocena efektywności aktualnych zabezpieczeń.