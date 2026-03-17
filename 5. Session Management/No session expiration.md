# Brak wygasania sesji
W ramach testu penetracyjnego przeprowadzono analizę aplikacji webowej, ze szczególnym uwzględnieniem mechanizmu zarządzania sesjami użytkowników. Celem testu było zidentyfikowanie potencjalnych luk związanych z bezpieczeństwem sesji, w tym problemu związanego z brakiem wygasania sesji.

## Metodologia
Testowane funkcjonalności były realizowane w środowisku lokalnym. Zastosowane metody obejmowały:
- **Analizę źródła kodu**: Sprawdzenie, jak zarządzane są sesje.
- **Testy manualne**: Weryfikacja, czy sesje wygasają po określonym czasie nieaktywności użytkownika.
- **Narzędzia skanowania**: Użycie narzędzi do identyfikacji podatności w aplikacji internetowej.

## Wyniki
Podczas testów stwierdzono, że:
- Sesje użytkowników nie wygasają automatycznie po określonym czasie bez aktywności.
- Użytkownicy mogą być zalogowani na stronie przez nieokreślony czas, co zwiększa ryzyko nieautoryzowanego dostępu po opuszczeniu komputera.
- Brak mechanizmu wygasania sesji może prowadzić do sytuacji, w których inny użytkownik może przejąć aktywną sesję.

## Rekomendacje
Aby poprawić bezpieczeństwo aplikacji, zaleca się:
1. **Implementację mechanizmu wygasania sesji**: Sesje powinny wygasać po określonym czasie bez aktywności (np. 15 minut).
2. **Informowanie użytkowników**: Przekazywanie komunikatu o nadchodzącym wygaśnięciu sesji z możliwością jej odnowienia.
3. **Bezpieczne zarządzanie sesjami**: Użycie tokenów sesyjnych z ograniczoną ważnością oraz ich rotacja.

## Podsumowanie
Przeprowadzone testy ujawniły istotny problem związany z bezpieczeństwem sesji w aplikacji. Wdrożenie rekomendowanych zmian zwiększy odporność systemu na potencjalne ataki oraz przyczyni się do ochrony danych użytkowników. 
