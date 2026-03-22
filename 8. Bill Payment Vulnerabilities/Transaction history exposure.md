# Transaction history exposure
Historia transakcji jest dostepna bez uwierzytelnienia po samym numerze konta.

## Reprodukcja:
1. Uzyc numeru konta ofiary.
2. Wyslac zapytanie bez tokena:

~~~powershell
Invoke-RestMethod -Method Get -Uri "http://localhost:5000/transactions/9810342544"
~~~

## Rezultat:
API zwraca status success i liste transakcji dla wskazanego konta bez logowania.

![8_transactionhistory.png](img\8_transactionhistory.png)