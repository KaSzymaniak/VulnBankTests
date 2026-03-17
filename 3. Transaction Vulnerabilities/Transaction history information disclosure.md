# Transaction history information disclosure
Podczas testów skoncentrowano się na funkcjonalności wyświetlania historii transakcji użytkownika. Zidentyfikowano, że dostęp do szczegółów transakcji można uzyskać poprzez wołanie do endpointu `/transactions/user`. 

## Wyniki Testu
Zidentyfikowano istotny problem związany z **ujawnieniem informacji dotyczących historii transakcji** użytkowników:

1. **Opis Luka Bezpieczeństwa**:
   - Bez odpowiednich mechanizmów autoryzacji, każdy użytkownik może uzyskać dostęp do historii transakcji dowolnego innego użytkownika, wpisując odpowiedni URL. To zjawisko wskazuje na poważne braki w implementacji kontroli dostępu.

2. **Zagrożenia**:
   - Ujawnienie poufnych informacji, takich jak detale transakcji.
   - Potencjalna możliwość wykorzystania ujawnionych informacji do innych ataków, takich jak phishing czy oszustwa.

## Rekomendacje
Aby zminimalizować ryzyko związane z ujawnieniem informacji, zaleca się podjęcie następujących działań:

- **Implementacja Kontroli Dostępu**: 
  - Należy wprowadzić solidne mechanizmy autoryzacji, aby jedynie upoważnieni użytkownicy mogli acceder do historii transakcji.
  
- **Walidacja Użytkowników**: 
  - Weryfikacja, czy żądający jest właścicielem danych, które chce przeglądać, powinna być obligatoryjna.

- **Testowanie i Monitorowanie**: 
  - Regularne testy penetracyjne oraz monitorowanie dostępu do wrażliwych danych mogą pomóc w identyfikacji problemów na wczesnym etapie.

### Podsumowanie
Zidentyfikowana luka bezpieczeństwa wymaga pilnych działań w celu ochrony danych użytkowników. Wprowadzenie zaleceń zwiększy poziom zabezpieczeń aplikacji oraz zaufanie użytkowników. 