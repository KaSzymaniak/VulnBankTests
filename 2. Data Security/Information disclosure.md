#  Vulnerability Report: Information Disclosure

## 1. Przegląd
Wykryto wyciek informacji poprzez odpowiedzi API. Endpointy zwracaja dane, ktore nie sa wymagane do realizacji funkcji klienta (m.in. pola wewnetrzne i informacje o innych uzytkownikach), a bledy backendu ujawniaja szczegoly implementacyjne.


## 2. Zidentyfikowane podatności

### 2.1 Nadmierne dane zwracane przez API
* **Opis:** Odpowiedzi zawieraja nadmiarowe pola (np. identyfikatory wewnetrzne, metadane techniczne, pelne obiekty zamiast minimalnego zestawu danych).
* **Co jest nie tak:** Brak zasady minimalizacji danych (least privilege / need-to-know) po stronie backendu.
* **Ryzyko:** Atakujacy moze budowac mape systemu i przygotowac kolejne ataki (BOLA, account enumeration, phishing ukierunkowany).

### 2.2 Ujawnienie danych użytkownika pomiędzy kontami
* **Opis:** Po modyfikacji parametrow zapytania/API ID mozliwe jest pobranie danych nalezacych do innego uzytkownika.
* **Co jest nie tak:** Brak poprawnej autoryzacji obiektowej na poziomie rekordu.
* **Ryzyko:** Naruszenie poufnosci danych klientow i mozliwe naruszenie RODO.

### 2.3 Szczegółowe ujawnianie błędów
* **Opis:** Aplikacja zwraca szczegolowe komunikaty bledu (stack trace, nazwy tabel/kolumn, fragmenty zapytan SQL, szczegoly frameworka).
* **Co jest nie tak:** Srodowisko produkcyjne ujawnia informacje diagnostyczne, ktore powinny byc ukryte.
* **Ryzyko:** Ulatwienie exploitacji SQL injection i innych atakow przez poznanie struktury backendu.

## 3. Wpływ
* Naruszenie poufnosci danych klientow.
* Zwiekszenie powierzchni ataku przez ujawnienie szczegolow architektury i modelu danych.
* Wyzsze prawdopodobienstwo skutecznych atakow wtornych.
