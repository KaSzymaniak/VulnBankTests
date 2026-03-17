# Predictable reference number
W ramach procesu zabezpieczania aplikacji internetowej przeprowadzono testy pentracyjne w lokalnym środowisku. Celem testów było zidentyfikowanie słabości oraz potencjalnych luk bezpieczeństwa, które mogłyby zostać wykorzystane przez atakujących.

### Wyniki Testów
W wyniku przeprowadzonych testów zidentyfikowano kilka istotnych kwestii:

1. **Słaba Predykcja numeru referencyjnego**:
   - Ostatnie cyfry numeru referencyjnego są zmienne, co może prowadzić do potencjalnych ataków, takich jak brute force.

2. **Brak Odpowiedniej Walidacji**:
   - Wprowadzane dane nie były należycie walidowane, co zwiększa ryzyko wstrzykiwania złośliwego kodu.

3. **Potencjalne podatności**:
   - Zidentyfikowano luki w zabezpieczeniach sesji, które mogą prowadzić do nieautoryzowanego dostępu.

### Rekomendacje
Aby poprawić bezpieczeństwo aplikacji, zaleca się:

- Implementację losowych numerów referencyjnych, które są trudniejsze do przewidzenia.
- Udoskonalenie systemu walidacji danych, aby zminimalizować ryzyko wstrzykiwania.
- Zastosowanie dodatkowych zabezpieczeń sesji, takich jak regularne odświeżanie tokenów sesji oraz ich unieważnianie po określonym czasie.

### Podsumowanie
Testy pentracyjne ujawniły kluczowe słabości aplikacji, które powinny być niezwłocznie naprawione. Regularne testowanie i monitorowanie bezpieczeństwa aplikacji są kluczowe dla ochrony przed potencjalnymi zagrożeniami.