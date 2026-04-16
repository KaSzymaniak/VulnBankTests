# Skanowanie katalogów i wstępna enumeracja

Zidentyfikowano interesujące pliki i endpointy

## Wymagania
- Narzędzia: gobuster

## Podsumowanie wyników (skrót)
```sh
.htpasswd            (Status: 403) [Size: 291]
.htaccess            (Status: 403) [Size: 291]
admin                (Status: 301) [Size: 316] [--> vulnerable/admin/]                                                                         
all                  (Status: 200) [Size: 2328]
cat                  (Status: 200) [Size: 2111]
cgi-bin/             (Status: 403) [Size: 290]
classes              (Status: 301) [Size: 318] [--> vulnerable/classes/]                                                                       
css                  (Status: 301) [Size: 314] [--> vulnerable/css/]                                                                           
footer               (Status: 200) [Size: 185]
header               (Status: 200) [Size: 796]
images               (Status: 301) [Size: 317] [--> vulnerable/images/]                                                                        
index                (Status: 200) [Size: 1355]
server-status        (Status: 403) [Size: 295]
show                 (Status: 200) [Size: 1320]
```

## kroki
1. Uruchomiłem skan katalogów (wynik dostarczony):  
```bash
gobuster dir -u vulnerable -w /usr/share/wordlists/dirb/big.txt
```
2. Sprawdziłem nagłówki i zawartość strony głównej oraz pliku index:  
```bash
curl -si http://vulnerable/
```
Znaleziono linki:
- css/default.css
- index.php
- /
- cat.php?id=1
- cat.php?id=2
- cat.php?id=3
- /all.php
- /admin/

.htpasswd (Status: 403) [Size: 291]  
- 403 Forbidden: Serwer odmawia dostępu do pliku .htpasswd. Oznacza to, że plik istnieje lub jest zmapowany, ale nie masz uprawnień do jego pobrania. Sprawdź nagłówki odpowiedzi (np. WWW-Authenticate) dla wskazówek o ochronie.

.htaccess (Status: 403) [Size: 291]  
- 403 Forbidden: Bezpośredni dostęp do pliku konfiguracyjnego Apache jest blokowany. Plik jest obecny/rozpoznany przez serwer, ale serwer nie ujawnia jego zawartości publicznie.

admin (Status: 301) [Size: 316] [--> vulnerable/admin/]  
- 301 Moved Permanently: Żądanie do /admin zostało przekierowane trwale (najczęściej dodanie ukośnika). Nagłówek Location wskazuje docelową lokalizację; podąż za nim, aby uzyskać właściwą zawartość.

all (Status: 200) [Size: 2328]  
- 200 OK: Zasób /all dostępny i serwer zwrócił treść (2328 bajtów). Możesz pobrać i przeanalizować odpowiedź.

cat (Status: 200) [Size: 2111]  
- 200 OK: Zasób /cat dostępny; odpowiedź ma 2111 bajtów. Endpoint działa i zwraca dane — miejsce do dalszego testowania parametrów.

cgi-bin/ (Status: 403) [Size: 290]  
- 403 Forbidden: Katalog CGI jest zablokowany przed dostępem. Serwer rozpoznaje lokalizację, ale nie ujawnia zawartości ani listy plików.

classes (Status: 301) [Size: 318] [--> vulnerable/classes/]  
- 301 Moved Permanently: Żądanie przekierowane do katalogu z ukośnikiem; śledź Location, by uzyskać katalogową zawartość.

css (Status: 301) [Size: 314] [--> vulnerable/css/]  
- 301 Moved Permanently: Podobnie — żądanie skierowane do katalogu stylów; follow redirect by pobrać pliki CSS.

footer (Status: 200) [Size: 185]  
- 200 OK: Zasób /footer dostępny; serwer zwrócił niewielką zawartość (185 bajtów), prawdopodobnie fragment HTML do analizy.

header (Status: 200) [Size: 796]  
- 200 OK: Zasób /header dostępny; 796 bajtów treści — sprawdź pod kątem linków i skryptów.

images (Status: 301) [Size: 317] [--> vulnerable/images/]  
- 301 Moved Permanently: Przekierowanie do katalogu obrazów. Follow redirect, by zobaczyć listę/zasoby w katalogu images/.

index (Status: 200) [Size: 1355]  
- 200 OK: Strona główna istnieje i zwraca 1355 bajtów treści. Punkt startowy do mapowania aplikacji.

server-status (Status: 403) [Size: 295]  
- 403 Forbidden: Endpoint diagnostyczny serwera (mod_status) jest zablokowany. Oznacza to, że serwer nie pozwala na dostęp do statystyk/diagnostyki bez uprawnień.

show (Status: 200) [Size: 1320]  
- 200 OK: Zasób /show działa i zwraca 1320 bajtów. Prawdopodobnie przyjmuje parametr (np. id) — wysoki priorytet do dalszego testowania parametrów.

