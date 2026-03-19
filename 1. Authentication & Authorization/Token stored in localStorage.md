# Token stored in localStorage
Aplikacja przechowuje token JWT w localStorage, co zwiększa ryzyko przejęcia tokena.

## Reprodukcja:
1. Zalogować się do aplikacji.
2. Otworzyć DevTools → Application → Local Storage.
3. Zweryfikować obecność tokena.

## Rezultat:
Widoczny jwt_token wraz z jego wartością.

![1_jwttoken.png](img\1_jwttoken.png)


