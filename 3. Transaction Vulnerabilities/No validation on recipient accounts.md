# Vulnerability Report: No Validation on Recipient Accounts

**Target Application:** Vuln-Bank (Localhost)
**Author:** Dominik
**Date:** 17.03.2026

---

## 1. Przegląd

Wykryto podatnosc polegajaca na braku walidacji konta odbiorcy podczas wykonywania przelewu. Aplikacja akceptuje dowolne wartosci pola `to_account`, bez sprawdzania czy konto istnieje w systemie.

---

## 2. Zidentyfikowana podatność

### 2.1 Brak walidacji kont odbiorców (CWE-20 / Business Logic Flaw)

* **Opis:** System nie weryfikuje czy konto odbiorcy istnieje przed zapisaniem transakcji.
* **Co jest nie tak:** Brak walidacji danych wejściowych oraz brak sprawdzenia integralnosci biznesowej operacji.
* **Ryzyko:** Umozliwia wykonywanie przelewow na nieistniejace konta, co moze prowadzic do utraty srodkow lub manipulacji systemem.

---

## 3. Dowód koncepcji (PoC)

### 3.1 Test — Przelew na nieistniejące konto (krok po kroku)

1. Uruchomiono aplikacje lokalnie przy uzyciu Dockera:

```bash
docker-compose up --build
```

2. Otworzono aplikacje w przegladarce:

```
http://localhost
```

3. Zalogowano sie na konto uzytkownika (np. `dominik2`).

4. Otworzono narzedzia deweloperskie przegladarki (F12) → zakladka **Network**.

5. Wykonano poprawny przelew przez interfejs aplikacji, aby przechwycic prawidlowe zapytanie do endpointu `/transfer`.

6. Zidentyfikowano request typu:

```
POST /transfer
```

z payloadem:

```json
{
  "to_account": "4910990262",
  "amount": "10"
}
```

7. Skopiowano zapytanie (Copy as fetch) i wklejono je do zakladki **Console**.

8. Zmodyfikowano parametr `to_account`, ustawiajac nieistniejacy numer konta:

```json
{
  "to_account": "9999999999",
  "amount": "10"
}
```

9. Wyslano zmodyfikowane zapytanie bez zmiany pozostalych naglowkow i tokenu autoryzacyjnego.

10. Aplikacja zwrocila odpowiedz:

```json
{
  "status": "success"
}
```

co oznacza, ze backend zaakceptowal niepoprawne dane.

11. W celu potwierdzenia wykonania operacji, zalogowano sie do bazy danych PostgreSQL w kontenerze Docker:

```bash
docker exec -it vuln-bank-db-1 psql -U postgres
```

12. Polaczono sie z baza aplikacji:

```sql
\c vulnerable_bank
```

13. Wykonano zapytanie:

```sql
SELECT id, to_account, amount FROM transactions;
```

14. Otrzymano wynik:

```text
id | to_account  | amount
--------------------------
5  | 9999999999 | 10.00
```

---

## 4. Wnioski

* mozliwosc wykonywania przelewow na nieistniejace konta
* brak integralnosci danych finansowych
* potencjalna utrata srodkow
* mozliwosc naduzyc i manipulacji systemem

Podatnosc zostala potwierdzona. Aplikacja nie waliduje kont odbiorcow, co stanowi krytyczny blad logiki biznesowej. Wymagana jest implementacja walidacji istnienia konta oraz kontroli integralnosci transakcji przed ich zapisaniem.
