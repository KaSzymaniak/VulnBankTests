#  Vulnerability Report: Prompt Injection


## 1. Przegląd
Endpoint AI chat przyjmuje nieufny input i pozwala na manipulacje instrukcjami modelu, co prowadzi do prompt injection.


## 2. Zidentyfikowane podatności

### 2.1 Niezaufany kontekst podpowiedzi
* **Opis:** Uzytkownik moze podac tresc nadpisujaca intencje systemowe i polityke odpowiedzi modelu.
* **Co jest nie tak:** Brak izolacji instrukcji systemowych od tresci uzytkownika i brak twardego filtra.
* **Ryzyko:** Ujawnienie danych kontekstowych oraz wykonywanie niezamierzonych operacji logicznych.


## 3. Wpływ
* Ujawnienie danych i logiki systemowej.
* Obnizenie zaufania do funkcji AI support.


## 4. Ocena końcowa
Podatnosc **Prompt Injection** zostala potwierdzona. Warstwa AI wymaga dodatkowych zabezpieczen sterowania kontekstem.


