# Weak password reset mechanism (4-digit PIN)
Mechanizm resetu hasła opiera się wyłącznie na 4-cyfrowym kodzie PIN (10000 możliwych kombinacji), który jest wysyłany na adres e-mail użytkownika. Tak ograniczona przestrzeń klucza umożliwia skuteczny atak typu brute-force/fuzzing i przejęcie konta bez dodatkowych zabezpieczeń.

## Reprodukcja:
1. Przejść do formularza resetu hasła w aplikacji.
2. Wprowadzić login konta użytkownika.
3. Przechwycić żądanie w narzędziu proxy (np. OWASP ZAP).
4. Zidentyfikować parametr odpowiedzialny za kod PIN w żądaniu.
5. Uruchomić atak typu fuzzing/brute-force:
   - Zakres: `0000–9999`
   - Ustawić payload jako wszystkie możliwe kombinacje PIN.
6. Monitorować odpowiedzi serwera w celu wykrycia poprawnego kodu (np. zmiana statusu odpowiedzi).
7. Po odnalezieniu poprawnego PIN-u hasło zostanie zmienione.

![image](img\PINimg.png)

## Rezultat:
Możliwe jest odgadnięcie poprawnego kodu PIN poprzez brute-force, co pozwala na nieautoryzowaną zmianę hasła i przejęcie konta użytkownika.
