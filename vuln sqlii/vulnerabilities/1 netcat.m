# HTTP Headers Analysis – Information Disclosure

## Cel testów

Identyfikacja ujawnianych informacji o technologii oraz konfiguracji serwera na podstawie nagłówków HTTP.

---

## Wykonanie

Analiza odpowiedzi serwera przy użyciu ręcznego zapytania HTTP (netcat):

```bash
nc 192.168.50.20 80
```

Wysłane zapytanie:

```http
GET / HTTP/1.1
Host: 192.168.50.20
```

---

## Wynik

![](../img/netcat.png)

## Wnioski
1. Aplikacja jest oparta o php
2. Używany jest framework nginx w wersji 0.7.67
