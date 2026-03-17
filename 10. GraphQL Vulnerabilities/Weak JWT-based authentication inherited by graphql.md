# Weak JWT-Based Authentication in GraphQL

Podczas przeprowadzania testów penetracyjnych na stronie internetowej działającej w lokalnym środowisku, zidentyfikowano lukę bezpieczeństwa związaną z systemem uwierzytelniania opartym na tokenach JWT (JSON Web Token). Specyfika problemu polega na tym, że mechanizmy zabezpieczające są niewystarczające, co może prowadzić do różnych zagrożeń, w tym nieautoryzowanego dostępu do systemu.

## Opis problemu

1. **Słaba implementacja JWT**: Uwierzytelnianie oparte na JWT w aplikacji wykazuje niedobory w szeregach zabezpieczeń. Tokeny JWT mogą być łatwo wykradzione lub sfałszowane, co umożliwia atakującym bezpośredni dostęp do API GraphQL.
  
2. **Brak odpowiednich algorytmów podpisu**: Gdy tokeny nie są podpisane lub używany jest słaby algorytm szyfrowania, dowolny użytkownik może je zmanipulować, co prowadzi do uzyskania nieautoryzowanych uprawnień.

3. **Brak weryfikacji**: W przypadku, gdy serwer nie weryfikuje odpowiednio pochodzenia tokenu, atakujący mogą uzyskiwać dostęp do danych bez odpowiedniej autoryzacji.

## Wnioski i rekomendacje

1. **Ulepszona weryfikacja algorytmów**: Należy zastosować silniejsze algorytmy podpisu, takie jak RS256, a unikać HMAC poprzez klucz, który może być stosunkowo łatwy do odgadnięcia.

2. **Cykliczna wymiana tokenów**: Wdrożenie mechanizmu cyklicznej wymiany tokenów zabezpieczy aplikację poprzez regularne aktualizowanie tokenów, co zminimalizuje ryzyko ich eksploatacji.

3. **Monitorowanie i logowanie**: Umożliwi to śledzenie i analizę nietypowej aktywności oraz prób dostępu do chronionych zasobów.

4. **Ograniczenie czasu życia tokenów**: Skrócenie czasu życia tokenów JWT do minimalnego wymaganego czasu oraz zwiększenie częstotliwości ich odnowień.