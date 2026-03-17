#  Vulnerability Report: Cross Site Scripting (XSS)
**Target Application:** Vuln-Bank (Localhost)
**Author:** Karol
**Date:** 17.03.2026
**Status:** Confirmed (PoC Created)

---

## 1. Overview
W aplikacji mozliwe jest zapisanie i renderowanie danych uzytkownika bez poprawnej sanitacji/escapingu, co prowadzi do XSS.

---

## 2. Identified Vulnerabilities

### 2.1 Stored/Reflected XSS in User-Controlled Fields (CWE-79)
* **Opis:** Input od uzytkownika jest odtwarzany w UI bez odpowiednich zabezpieczen.
* **Co jest nie tak:** Brak kompletnej sanitacji oraz polityki CSP.
* **Ryzyko:** Kradziez sesji, phishing w aplikacji i wykonanie JS w kontekscie ofiary.

---

## 3. Proof of Concept (PoC)

### 3.1 Test - Payload XSS
1. Wprowadz payload do pola profilu/bio:

```html
<script>alert('XSS')</script>
```

2. Otworz widok, ktory renderuje to pole.
3. Zweryfikuj wykonanie JavaScript.

**Wynik:** Payload jest wykonywany w przegladarce.

---

## 4. Impact
* Kradziez tokenow/sesji.
* Przeprowadzenie atakow na innych zalogowanych uzytkownikow.

---

## 5. Final Assessment
Podatnosc **Cross Site Scripting (XSS)** zostala potwierdzona. Konieczne jest zabezpieczenie calego lancucha input-output.


