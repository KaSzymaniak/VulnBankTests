#  Vulnerability Report: Cross Site Scripting (XSS)

## 1. Przegląd
W aplikacji mozliwe jest zapisanie i renderowanie danych uzytkownika bez poprawnej sanitacji/escapingu, co prowadzi do XSS.

## 2. Zidentyfikowane podatności

### 2.1 Przechowywany/Zwierciedlony XSS w polach kontrolowanych przez użytkownika
* **Opis:** Input od uzytkownika jest odtwarzany w UI bez odpowiednich zabezpieczen.
* **Co jest nie tak:** Brak kompletnej sanitacji oraz polityki CSP.
* **Ryzyko:** Kradziez sesji, phishing w aplikacji i wykonanie JS w kontekscie ofiary.

## 3. Wpływ
* Kradziez tokenow/sesji.
* Przeprowadzenie atakow na innych zalogowanych uzytkownikow.

## 4. Ocena końcowa
Podatnosc **Cross Site Scripting (XSS)** zostala potwierdzona. Konieczne jest zabezpieczenie calego lancucha input-output.


