mozemy dodawac pliki

helloworld.php

NO PHP!!

helloworld

```php
<?php
    echo 'Hello World!';
?>
```

[dodanie pliku helloworld](\img\php_hello_world.png)

.phtml — alternative PHP file extension.
.php3, .php4, .php5 — legacy versions (rarely used today).
.inc — include files (often contain PHP); should be protected from direct web access.
.html or .htm — can contain PHP if server configured (e.g., via Apache AddType/AddHandler or .htaccess to pass .html to PHP).

php3

```
http://vulnerable/admin/uploads/helloworld.php3
```

Wyswietlilo sie hellow world

TODO: dziwne
The filename should only contains between 3 to 8 letters

TODO: exec shell from php

TODO: get everything from shell