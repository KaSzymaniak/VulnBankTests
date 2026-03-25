#  Vulnerability Report: Unrestricted File Upload

## 1. Przegląd
Mechanizm uploadu plikow profilowych akceptuje pliki bez wystarczajacej walidacji typu i zawartosci.


## 2. Zidentyfikowane podatności

### 2.1 Brak ograniczeń typu pliku
* **Opis:** Endpoint przyjmuje pliki, ktore nie sa bezpiecznymi obrazami.
* **Co jest nie tak:** Brak whitelisty MIME/rozszerzen i brak skanowania zawartosci.
* **Ryzyko:** Mozliwosc wrzucenia zlosliwych plikow i dalszej eksploitacji.

## 3. Wpływ
* Zwiekszenie powierzchni ataku przez upload niebezpiecznych plikow.
* Ryzyko hostowania szkodliwych payloadow.

## 4. Ocena końcowa
Podatnosc **Unrestricted file upload** zostala potwierdzona. Upload wymaga scislej walidacji i izolacji plikow.


