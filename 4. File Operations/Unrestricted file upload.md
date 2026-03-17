#  Vulnerability Report: Unrestricted File Upload
**Target Application:** Vuln-Bank (Localhost)
**Author:** Karol
**Date:** 17.03.2026
**Status:** Confirmed (PoC Created)

---

## 1. Overview
Mechanizm uploadu plikow profilowych akceptuje pliki bez wystarczajacej walidacji typu i zawartosci.

---

## 2. Identified Vulnerabilities

### 2.1 Missing File Type Restrictions (CWE-434)
* **Opis:** Endpoint przyjmuje pliki, ktore nie sa bezpiecznymi obrazami.
* **Co jest nie tak:** Brak whitelisty MIME/rozszerzen i brak skanowania zawartosci.
* **Ryzyko:** Mozliwosc wrzucenia zlosliwych plikow i dalszej eksploitacji.

---

## 3. Proof of Concept (PoC)

### 3.1 Test - Upload niedozwolonego typu
1. Zaloguj sie i pobierz JWT.
2. Wyslij plik testowy:

```bash
curl -i -X POST http://localhost:5000/upload_profile_picture \
  -H "Authorization: Bearer <JWT_USER>" \
  -F "file=@test.txt"
```

3. Sprawdz, czy backend zaakceptowal plik.

**Wynik:** Brak twardej walidacji typow plikow po stronie serwera.

---

## 4. Impact
* Zwiekszenie powierzchni ataku przez upload niebezpiecznych plikow.
* Ryzyko hostowania szkodliwych payloadow.

---

## 5. Recommendations
* Wprowadz whitelisty rozszerzen i MIME.
* Waliduj magic bytes i skanuj pliki antymalware.
* Przechowuj pliki poza web root i generuj bezpieczne nazwy.

---

## 6. Final Assessment
Podatnosc **Unrestricted file upload** zostala potwierdzona. Upload wymaga scislej walidacji i izolacji plikow.
