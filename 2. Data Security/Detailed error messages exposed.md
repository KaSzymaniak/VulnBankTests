# Detailed error messages exposed
Aplikacja zwraca surowe komunikaty wyjatkow backendu w odpowiedzi HTTP.

## Reprodukcja:
1. Wyslac niepoprawne body JSON do endpointu resetu hasla v1:

PowerShell:
~~~powershell
Invoke-WebRequest -Method POST -Uri "http://localhost:5000/api/v1/forgot-password" `
  -ContentType "application/json" `
  -Body "null"
~~~

Bash:
~~~bash
curl -s -X POST http://localhost:5000/api/v1/forgot-password \
  -H "Content-Type: application/json" \
  -d "null"
~~~

## Rezultat:
W polu message widoczny jest szczegolowy blad, np.:
- "'NoneType' object has no attribute 'get'"

![2_errormessage.png](img\2_errormessage.png)