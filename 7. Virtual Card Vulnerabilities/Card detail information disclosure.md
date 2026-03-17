# Uzyskanie Informacji o Kartach Wirtualnych

W trakcie przeprowadzania testów penetracyjnych strony internetowej w lokalnym środowisku stwierdzono występowanie luki bezpieczeństwa, która umożliwia nieautoryzowany dostęp do informacji o kartach wirtualnych. W szczególności problem ten dotyczy endpointu `/api/virtual_cards`, gdzie przypadkowo ujawniane są szczegóły kart.

![image]("../img/card information.png")

## Typ luki: Disclosure of Information
- **Endpoint:** `/api/virtual_cards`
- **Rodzaj danych:** Szczegóły kart wirtualnych, takie jak numery kart, daty ważności, a także inne potencjalnie wrażliwe informacje.
  
## Opcje Testowe
Podczas testowania endpointu wykryto, że:
- Użytkownik nieautoryzowany może uzyskać dostęp do danych kart wirtualnych bez potrzeby posiadania odpowiednich uprawnień.
- Dane nie są odpowiednio zabezpieczone, co pozwala na ich przeglądanie i pobieranie.

## Zasadnicze Wnioski

- **Kompleksowy dostęp:** Wszyscy użytkownicy, niezależnie od poziomu dostępu, mogli przeglądać szczegóły kart wirtualnych.
- **Brak autoryzacji:** Endpoint nie wymagał żadnej formy uwierzytelnienia, co stanowi poważne zagrożenie dla bezpieczeństwa.

## Rekomendacje

1. **Implementacja Uwierzytelnienia:** Należy wprowadzić zabezpieczenia, które uniemożliwią dostęp do tego API osobom nieautoryzowanym. Rozważenie stosowania JWT lub sesji użytkownika.
  
2. **Ograniczenia dostępu:** Wprowadzenie ograniczeń na poziomie API, aby tylko uprawnieni użytkownicy mogli uzyskiwać dostęp do szczegółów kart.

3. **Audyt i Monitoring:** Przeprowadzenie audytu całego systemu w celu zidentyfikowania innych potencjalnych luk oraz monitorowanie logów w celu wykrywania nieautoryzowanych dostępów.

## Podsumowanie
Zidentyfikowana luka dotycząca ujawnienia informacji o kartach wirtualnych w API `/api/virtual_cards` stanowi poważne zagrożenie dla bezpieczeństwa i wymaga natychmiastowych działań naprawczych. Implementacja odpowiednich zabezpieczeń jest kluczowa dla ochrony danych użytkowników.