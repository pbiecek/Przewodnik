## Skrobanie danych ze strony www

Przyjrzyjmy się jak wygląda przykładowa ,,poważna'' praca z R na takim przykładzie.

1. Wykorzystamy funkcje z pakietu `rvest` aby odczytać bezpośrednio z wikipedii dane o pozycji Polski w rankingu FIFA.
2. Wykorzystamy funkcje z pakietów `tidyr` i `dplyr` aby przekształcić wczytane dane do odpowiedniej postaci.
3. Wykorzystamy funkcje z pakietu `ggplot2` aby przedstawić graficznie wczytane dane.

Cały kod R, który wykonuje te trzy etapy, jest dosyć krótki i łatwo go prześledzić krok po kroku. 
Niektóre elementy mogą wydawać się znajome inne mogą być zaskakujące. W kolejnych rozdziałach wyjaśnimy każdy z zaprezentowanych tutaj elementów.
Aby go uruchomić należy wcześniej zainstalować niezbędne pakiety. O tym jak instalować nowe pakiety napiszmy w kolejnym rozdziale.

### Wczytanie danych

Poniższy fragment kodu wczytuje do R tabelę z danymi ze strony *Reprezentacja Polski w piłce nożnej* z wikipedii. 
Wykorzystujemy tutaj funkcje z pakietu `rvest`, który jest bardzo przydatny w pobieraniu danych ze stron internetowych.
Na tej stronie jest wiele tabel, ale w instrukcji wyłuskującej tabele wskazujemy, że chodzi nam o tabelę 39.
Po wczytaniu danych wyświetlamy pierwszych 6 wierszy.

```
library("rvest")
wikiPL <- "https://pl.wikipedia.org/wiki/Reprezentacja_Polski_w_pi%C5%82ce_no%C5%BCnej"
webpage <- read_html(wikiPL)
tab <- html_table(html_nodes(webpage,xpath = '//*[@id="mw-content-text"]/table[39]'))
tab <- tab[[1]]
head(tab)
##    Rok  I II III IV  V VI VII VIII IX  X XI XII Śr.
## 1 1993  –  –   –  –  –  –   –   20 22 23 26  28  24
## 2 1994 28 24  24 28 27 32  32   32 33 36 33  29  30
## 3 1995 29 32  32 34 36 29  32   28 33 27 33  33  32
## 4 1996 35 37  37 40 42 42  50   55 56 55 52  53  48
## 5 1997 53 56  56 52 57 57  51   53 50 45 47  48  52
## 6 1998 48 60  61 55 54 54  48   40 34 34 29  31  45
```

### Transformacja danych

Po wczytaniu danych, zazwyczaj kolejnym krokiem jest wyczyszczenie, przetransformowanie danych.
Do tego celu mogą przydać się funkcje z pakietów `tidyr` i `dplyr`, omówimy je szczegółowo już niedługo, poniżej krótka ilustracja.
Zamieniamy dane z formatu w którym miesiące są w różnych kolumnach, na format wąski, w którym miesiące są w jednej kolumnie. Zamieniamy rzymskie nazwy miesięcy na arabskie.
Teraz dane są gotowe do prezentacji graficznej.

```
library("tidyr")
library("dplyr")
colnames(tab)[2:13] <- 1:12
data_long <- gather(tab[,1:13], Miesiac, Pozycja, -Rok)
data_long <- mutate(data_long, 
                    Pozycja = as.numeric(Pozycja),
                    Miesiac = as.numeric(Miesiac))
head(data_long)
##    Rok Miesiac Pozycja
## 1 1993       1      NA
## 2 1994       1      28
## 3 1995       1      29
## 4 1996       1      35
## 5 1997       1      53
## 6 1998       1      48
```

### Prezentacja graficzna danych

Wczytaliśmy dane, czas się im przyjrzeć. 
Do graficznej prezentacji danych wykorzystać można pakiet `ggplot2`.
Poniżej przedstawiamy instrukcje, które wyprodukują wykres z poniższego rysunku, tak zwany wykres pudełkowy. 
Przedstawia on minimalną, maksymalną, połówkową i ćwiartkowy pozycję Polski w rankingu w każdym roku. 
Widzimy w których latach były największe zmiany oraz kiedy byliśmy na najlepszych pozycjach.

```
library("ggplot2")
ggplot(data_long, aes(factor(Rok), Pozycja)) +
  geom_boxplot() + ggtitle("Pozycja Polski w rankingu FIFA")
```

![Pozycja Polski w rankingu FIFA.](figures/fifaB.png)

