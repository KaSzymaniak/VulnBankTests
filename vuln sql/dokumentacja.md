---
title: Pentester Lab — From SQL Injection to Shell
author:
  - Dominik Uchman
  - Eryk Warot
  - Karol Szymaniak
  - Mateusz Saj
  - Mikołaj Maliszewski
toc-tile: Spis treści
---

# Wstęp

Celem tych testów jest przeprowadzenie kontrolowanej ścieżki eksploitacji od podatności SQL Injection do uzyskania powłoki (shell) na docelowym systemie. Scenariusz obejmuje identyfikację i walidację podatności SQLi, eskalację przez pobieranie/wywoływanie wrażliwych danych i wstrzyknięcie poleceń, a następnie ustanowienie stabilnej interaktywnej sesji powłoki.

# Zakres testów
- Wykrywanie i potwierdzanie podatności SQL Injection
- Eksploatacja SQLi w celu wydobycia danych
- Użycie pozyskanych danych do dalszej eskalacji
- Przełączenie ataku z SQLi na wykonywanie poleceń systemowych
- Uzyskanie i utrzymanie powłoki (reverse shell, web shell), oraz podstawowe działania post-exploitation (enumeracja, utrwalenie, czyszczenie śladów minimalne — tylko w celach edukacyjnych).