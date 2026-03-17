#  Vulnerability Report: Information Disclosure
**Target Application:** Vuln-Bank (Localhost)
**Author:** Karol
**Date:** 17.03.2026
**Status:** Confirmed (PoC Created)

---

## 1. Overview
Wykryto wyciek informacji poprzez odpowiedzi API. Endpointy zwracaja dane, ktore nie sa wymagane do realizacji funkcji klienta (m.in. pola wewnetrzne i informacje o innych uzytkownikach), a bÅ‚Ä™dy backendu ujawniaja szczegoly implementacyjne.

---

## 2. Identified Vulnerabilities

### 2.1 Excessive Data Returned by API (CWE-200)
* **Opis:** Odpowiedzi zawieraja nadmiarowe pola (np. identyfikatory wewnetrzne, metadane techniczne, pelne obiekty zamiast minimalnego zestawu danych).
* **Co jest nie tak:** Brak zasady minimalizacji danych (least privilege / need-to-know) po stronie backendu.
* **Ryzyko:** Atakujacy moze budowac mape systemu i przygotowac kolejne ataki (BOLA, account enumeration, phishing ukierunkowany).

### 2.2 User Data Disclosure Across Accounts
* **Opis:** Po modyfikacji parametrow zapytania/API ID mozliwe jest pobranie danych nalezacych do innego uzytkownika.
* **Co jest nie tak:** Brak poprawnej autoryzacji obiektowej na poziomie rekordu.
* **Ryzyko:** Naruszenie poufnosci danych klientow i mozliwe naruszenie RODO.

### 2.3 Verbose Error Disclosure (CWE-209)
* **Opis:** Aplikacja zwraca szczegolowe komunikaty bledu (stack trace, nazwy tabel/kolumn, fragmenty zapytan SQL, szczegoly frameworka).
* **Co jest nie tak:** Srodowisko produkcyjne ujawnia informacje diagnostyczne, ktore powinny byc ukryte.
* **Ryzyko:** Ulatwienie exploitacji SQL injection i innych atakow przez poznanie struktury backendu.

---

## 3. Proof of Concept (PoC)

### 3.1 Test - Nadmiarowe dane w profilu
1. Zaloguj sie jako zwykly uzytkownik i skopiuj token JWT.
2. Wyslij zapytanie do endpointu profilu:

```bash
curl -i http://localhost:8000/api/profile \
  -H "Authorization: Bearer <JWT_USER>"
```

3. Zweryfikuj, czy odpowiedz zawiera pola niewymagane przez UI (np. `is_admin`, `user_id`, pola techniczne).

**Wynik:** API zwraca wiecej informacji niz potrzebne frontendowi.

### 3.2 Test - Odczyt danych innego uzytkownika
1. Bedac zalogowanym jako user A, wykonaj zapytanie z innym identyfikatorem:

```bash
curl -i http://localhost:8000/api/users/2 \
  -H "Authorization: Bearer <JWT_USER_A>"
```

2. Sprawdz, czy zwracane sa dane usera B.

**Wynik:** Ujawnienie danych innego konta (information disclosure).

### 3.3 Test - Ujawnianie informacji przez bledy
1. Wyslij celowo bledne zapytanie (np. niepoprawny parametr typu):

```bash
curl -i "http://localhost:8000/api/transactions?limit='"
```

2. Sprawdz tresc bledu HTTP 4xx/5xx.

**Wynik:** Odpowiedz zawiera szczegoly techniczne (np. SQL/framework), ktore nie powinny byc publiczne.

---

## 4. Impact
* Naruszenie poufnosci danych klientow.
* Zwiekszenie powierzchni ataku przez ujawnienie szczegolow architektury i modelu danych.
* Wyzsze prawdopodobienstwo skutecznych atakow wtornych.

---

## 5. Final Assessment
Podatnosc **Information Disclosure** zostala potwierdzona. Aplikacja ujawnia dane i szczegoly implementacyjne, ktore nie powinny byc dostepne dla zwyklego uzytkownika. Wymagane jest ograniczenie zakresu danych w odpowiedziach API oraz poprawa kontroli autoryzacji i obslugi bledow.
