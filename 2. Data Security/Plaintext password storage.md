# Vulnerability Report: Plaintext Password Storage

## 1. Przegląd

Wykryto krytyczna podatnosc polegajaca na przechowywaniu hasel uzytkownikow w postaci jawnej (plaintext). Aplikacja nie stosuje mechanizmow haszowania ani zabezpieczen kryptograficznych, co prowadzi do bezposredniego ujawnienia danych uwierzytelniajacych w bazie danych.

## 2. Zidentyfikowana podatność

### 2.1 Przechowywanie haseł otwartym tekstem (Plaintext)

* **Opis:** Hasla uzytkownikow sa przechowywane w bazie danych w formie niezaszyfrowanej.
* **Co jest nie tak:** Brak zastosowania bezpiecznych funkcji haszujacych (np. bcrypt, Argon2) oraz brak polityki ochrony danych uwierzytelniajacych.
* **Ryzyko:** Atakujacy, ktory uzyska dostep do bazy danych, moze natychmiast odczytac hasla i wykorzystac je do przejecia kont lub atakow na inne systemy.


## 3. Wynik

Aplikacja przechowuje hasla w postaci jawnej (plaintext), co zostalo potwierdzone bezposrednim odczytem z bazy danych:

![alt text](img\image.png)


## 4. Wnioski

* mozliwosc natychmiastowego przejecia kont uzytkownikow
* brak ochrony danych w przypadku wycieku bazy danych
* naruszenie poufnosci informacji uwierzytelniajacych
* mozliwosc wykorzystania hasel w innych systemach (credential reuse)

Podatnosc **Plaintext Password Storage** zostala potwierdzona. Aplikacja nie zapewnia podstawowego poziomu ochrony danych uwierzytelniajacych, co stanowi krytyczne ryzyko bezpieczenstwa. Wymagane jest natychmiastowe wdrozenie bezpiecznych mechanizmow haszowania hasel oraz eliminacja przechowywania danych w postaci jawnej.
