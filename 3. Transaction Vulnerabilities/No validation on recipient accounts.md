# Vulnerability Report: No Validation on Recipient Accounts


## 1. Przegląd

Wykryto podatnosc polegajaca na braku walidacji konta odbiorcy podczas wykonywania przelewu. Aplikacja akceptuje dowolne wartosci pola `to_account`, bez sprawdzania czy konto istnieje w systemie.


## 2. Zidentyfikowana podatność

### 2.1 Brak walidacji kont odbiorców 

* **Opis:** System nie weryfikuje czy konto odbiorcy istnieje przed zapisaniem transakcji.
* **Co jest nie tak:** Brak walidacji danych wejściowych oraz brak sprawdzenia integralnosci biznesowej operacji.
* **Ryzyko:** Umozliwia wykonywanie przelewow na nieistniejace konta, co moze prowadzic do utraty srodkow lub manipulacji systemem.


## 3. Wnioski

* mozliwosc wykonywania przelewow na nieistniejace konta
* brak integralnosci danych finansowych
* potencjalna utrata srodkow
* mozliwosc naduzyc i manipulacji systemem

Podatnosc zostala potwierdzona. Aplikacja nie waliduje kont odbiorcow, co stanowi krytyczny blad logiki biznesowej. Wymagana jest implementacja walidacji istnienia konta oraz kontroli integralnosci transakcji przed ich zapisaniem.
