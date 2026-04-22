# Reconnaissance – Nmap & Enumeracja Katalogów

## Cel testów
Identyfikacja aktywnych hostów, otwartych portów, usług oraz mapowanie struktury aplikacji webowej.

---

## Część 1: Skanowanie Nmap

### Cel
Identyfikacja aktywnych usług sieciowych i wersji oprogramowania na docelowym hoście.

### Wykonanie

```bash
nmap -sV 192.168.X.X
```

### Wyniki

![nmap scan](../img/image.png)

### Wstępna analiza

System odpowiada na zapytania skanera i udostępnia usługi sieciowe w sieci lokalnej.

### Wykryte otwarte porty i usługi

**Port 22/tcp – SSH**
- Usługa: OpenSSH
- Wersja: 5.5p1 Debian 6+squeeze2 (protocol 2.0)
- Status: open

**Port 80/tcp – HTTP**
- Usługa: Apache httpd
- Wersja: 2.2.16 (Debian)
- Status: open

### Interpretacja ryzyka
- **Information disclosure:** Ujawnienie wersji usług ułatwia dobór exploitów
- **Attack surface:** Otwarte porty 22 i 80 stanowią główne wektory ataku

---

## Część 2: Enumeracja Katalogów

### Cel
Mapowanie struktury aplikacji webowej i identyfikacja endpointów potencjalnie podatnych.

### Wykonanie

```bash
gobuster dir -u http://192.168.X.X -w /usr/share/wordlists/dirb/big.txt
```

### Wyniki

![dir scan](../img/image.png)

**Zidentyfikowane zasoby:**

| Zasób | Status | Typ | Opis |
|-------|--------|------|------|
| .htpasswd | 403 | Config | Plik ochrony HTTP Basic Auth |
| .htaccess | 403 | Config | Konfiguracja Apache |
| admin | 301 | Katalog | Panel administracyjny |
| all | 200 | Endpoint | Lista wszystkich zdjęć |
| cat | 200 | Endpoint | Kategorie (SQL Injection) |
| cgi-bin/ | 403 | Katalog | Skrypty CGI (zablokowane) |
| classes | 301 | Katalog | Klasy PHP/backend |
| css | 301 | Katalog | Pliki stylów |
| images | 301 | Katalog | Grafiki aplikacji |
| index | 200 | Endpoint | Strona główna |
| server-status | 403 | Diagnostyka | Status Apache mod_status |
| show | 200 | Endpoint | Widok pojedynczego zdjęcia |

### Szczegółowa analiza

**Kody odpowiedzi:**
- **200 OK:** Zasoby dostępne i działające (all, cat, index, show, footer, header)
- **301 Moved Permanently:** Katalogi przekierowane z dodaniem ukośnika (admin/, classes/, css/, images/)
- **403 Forbidden:** Dostęp zablokowany do plików konfiguracyjnych i diagnostyki

### Interpretacja ryzyka

- **Recon confirmed:** Cel jest dostępny i gotowy do testów
- **Information disclosure:** Ujawnienie nazw katalogów ułatwia mapowanie aplikacji
- **Attack surface:** Endpoint `cat` (SQL Injection) i `admin` (wymagają dalszych testów)
- **Configuration exposure:** Widoczność plików .htaccess i .htpasswd wskazuje na konfiguracyjne luki

### Rekomendacje

1. Ograniczyć ujawnianie nazw katalogów poprzez proper 404 responses
2. Ukryć listę plików w katalogach
3. Uwierzytelniać dostęp do panelu administracyjnego
4. Monitorować i blokować skanowanie bezpieczeństwa

show (Status: 200) [Size: 1320]  
- 200 OK: Zasób /show działa i zwraca 1320 bajtów. Prawdopodobnie przyjmuje parametr (np. id) — wysoki priorytet do dalszego testowania parametrów.

