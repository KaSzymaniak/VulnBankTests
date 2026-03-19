# No file type validation
Upload profilu nie sprawdza typu pliku i przyjmuje dowolny plik jako zdjecie.

## Reprodukcja:
1. Wejsc w zakladke profile

![4_profilepicture.png](img\4_profilepicture.png)

2. Kliknac upload photo i wybrac cos, co nie jest w typowym formacie zdjecia, np .txt

![4_txt_selection.png](img\4_txt_selection.png)

## Rezultat:
Nieprawidlowe wyswietlanie zdjecia profilowego. Zapisanie pliku .txt w static/uploads.

![4_invalid_format_picture.png](img\4_invalid_format_picture.png)