# Raw GraphQL error disclosure
Endpoint GraphQL zwraca surowe bledy wykonania (w tym fragmenty SQL i path).

## Reprodukcja:
1. Zalogowac admina i pobrac token.
2. Wyslac zapytanie GraphQL z accountNumber powodujacym blad SQL.

```powershell
$ADMIN_BODY = '{"username":"admin","password":"admin123"}'
$ADMIN_LOGIN = Invoke-RestMethod -Method Post -Uri "http://localhost:5000/login" -ContentType 'application/json' -Body $ADMIN_BODY
$ADMIN_TOKEN = $ADMIN_LOGIN.token

$PAYLOAD = '{"query":"query { transactionSummary(accountNumber: \"x''\") { scope } }"}'
Set-Content -Path .\gql_payload.json -Value $PAYLOAD

curl.exe -i -s -X POST "http://localhost:5000/graphql" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $ADMIN_TOKEN" \
  --data-binary "@gql_payload.json"
```

## Rezultat:
HTTP 400 zawiera surowy message z backendu (np. "unterminated quoted string...") oraz path: ["transactionSummary"].

![Raw graphql error](img\10_raw_graphql_error.png)