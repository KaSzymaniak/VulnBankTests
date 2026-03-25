# Vulnerability Report: Weak JWT Secret Key

## 1. Przegląd

W trakcie testów bezpieczeństwa zidentyfikowano krytyczną podatność wynikającą z użycia słabego sekretu do podpisywania tokenów JWT oraz braku poprawnej walidacji danych zawartych w tokenie.

## 2. Zidentyfikowana podatność

### 2.1 Słaby klucz JWT

- **Opis:**  
  Aplikacja wykorzystuje słaby sekret (`secret123`) do podpisywania tokenów JWT oraz nie weryfikuje poprawnie tożsamości użytkownika po stronie backendu.

- **Problem:**  
  - sekret JWT jest łatwy do odgadnięcia  
  - backend ufa danym zawartym w tokenie (np. `user_id`)  
  - brak walidacji dostępu do zasobów  

- **Skutek:**  
  - możliwość generowania dowolnych tokenów  
  - możliwość podszywania się pod innych użytkowników  
  - dostęp do danych innych użytkowników  


## 3. Wnioski exploit'u

- Secret JWT jest słaby i możliwy do odgadnięcia  
- Tokeny mogą być dowolnie modyfikowane i podpisywane  
- Backend akceptuje sfałszowane tokeny  
- Backend ufa polu `user_id` zawartemu w JWT  
- Brak kontroli dostępu na poziomie zasobów  
