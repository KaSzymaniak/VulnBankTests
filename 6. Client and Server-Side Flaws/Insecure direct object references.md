# Insecure direct object references
W trakcie przeprowadzania testów penetracyjnych aplikacji webowej, zidentyfikowano wystąpienie luk bezpieczeństwa w postaci **Insecure Direct Object References (IDOR)**. Luka ta może prowadzić do nieautoryzowanego dostępu do danych użytkowników, co stanowi poważne zagrożenie dla bezpieczeństwa.

## Opis Luka

**Insecure Direct Object References** to typ luki, w którym aplikacja umożliwia dostęp do obiektów (np. plików, baz danych) bez odpowiedniej autoryzacji. Atakujący może manipulować identyfikatorami obiektów i uzyskać dostęp do zasobów, do których nie powinien mieć uprawnień.

## Wykryte Wrażliwości

W wyniku przeprowadzonych testów zidentyfikowano następujące przypadki IDOR:

- **Przyklad 1**: Brak kontroli dostępu do zasobów użytkowników na podstawie identyfikatorów w URL.
- **Przyklad 2**: Możliwość manipulacji parametrami żądania w celu uzyskania dostępu do danych innego użytkownika.

## Metodologia Testowania

Testy przeprowadzono w trzech głównych krokach:

1. **Analiza aplikacji** – zidentyfikowanie obiektów, do których użytkownicy mają dostęp, oraz sposobów, w jakie aplikacja identyfikuje te obiekty.
2. **Testy autoryzacyjne** – manipulacja identyfikatorami w żądaniach HTTP w celu sprawdzenia, czy system odpowiednio reaguje na nieuprawniony dostęp.
3. **Dokumentacja wyników** – zapisanie wszelkich odkrytych luk oraz zasobów, do których uzyskano dostęp.