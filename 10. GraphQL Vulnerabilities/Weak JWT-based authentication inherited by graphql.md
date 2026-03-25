# Weak JWT-Based Authentication in GraphQL

Zidentyfikowano lukę bezpieczeństwa związaną z systemem uwierzytelniania opartym na tokenach JWT (JSON Web Token). Specyfika problemu polega na tym, że mechanizmy zabezpieczające są niewystarczające, co może prowadzić do różnych zagrożeń, w tym nieautoryzowanego dostępu do systemu.

## Opis problemu

1. **Słaba implementacja JWT**: Uwierzytelnianie oparte na JWT w aplikacji wykazuje niedobory w szeregach zabezpieczeń. Tokeny JWT mogą być łatwo wykradzione lub sfałszowane, co umożliwia atakującym bezpośredni dostęp do API GraphQL.
  
2. **Brak odpowiednich algorytmów podpisu**: Gdy tokeny nie są podpisane lub używany jest słaby algorytm szyfrowania, dowolny użytkownik może je zmanipulować, co prowadzi do uzyskania nieautoryzowanych uprawnień.

3. **Brak weryfikacji**: W przypadku, gdy serwer nie weryfikuje odpowiednio pochodzenia tokenu, atakujący mogą uzyskiwać dostęp do danych bez odpowiedniej autoryzacji.