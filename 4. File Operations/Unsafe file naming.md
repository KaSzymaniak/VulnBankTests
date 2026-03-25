# Unsafe file naming
W przypadku zmiany zdjęcia na stronie, użytkownik mógłby wprowadzić nazwy plików, które mogą zagrażać bezpieczeństwu.

### Sprawdzenie Skryptów Zmiany Nazwy Plików
Podczas testów przeanalizowano metody przesyłania zdjęć oraz ich zmiany na stronie. Poniżej przedstawiono kilka kluczowych punktów:

1. **Brak Walidacji Nazw Plików**:
   - System nie sprawdza, czy nazwy plików są odpowiednie lub bezpieczne.
   
2. **Brak Ograniczeń Rozszerzeń**:
   - Umożliwiono przesyłanie wszelkiego rodzaju plików, nie tylko obrazów (np. .php, .exe).

3. **Bezpieczeństwo Danych użytkowników**:
   - Możliwość przesyłania złośliwych plików naraża całą bazę danych na ataki.

### Rekomendacje
Aby zminimalizować ryzyko związane z unsafe file naming, zaleca się wdrożenie następujących praktyk:

1. **Walidacja nazw plików**:
   - Użyj zestawu reguł do sprawdzania dozwolonych znaków oraz długości nazw plików.
   
2. **Ograniczenie Rozszerzeń**:
   - Zezwalaj tylko na przesyłanie plików z określonymi rozszerzeniami (np. .jpg, .png).

3. **Sanitizacja Danych**:
   - Wprowadź mechanizmy sanitizacji danych wejściowych, aby usunąć niebezpieczne znaki i ciągi.

4. **Przechowywanie Plików w Bezpiecznej Lokalizacji**:
   - Zmiana lokalizacji, gdzie pliki są przechowywane, tak aby nie były dostępne poprzez publiczne adresy URL.

### Podsumowanie
Analiza problemu unsafe file naming wykazała znaczne luki w zabezpieczeniach lokalnej strony. Wdrożenie powyższych rekomendacji pomoże w ochronie aplikacji przed atakami, które mogą prowadzić do poważnych konsekwencji dla bezpieczeństwa i prywatności. 

Zarządzanie zapisami plików oraz ich nazewnictwem jest kluczowym krokiem w procesie zabezpieczania systemu.