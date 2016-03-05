# Jak filtrować wiersze?

Jedną z najczęstszych operacji na danych jest filtrowanie wierszy, które spełniają określony warunek / warunki.

Funkcja `filter()` pakietu `dplyr` wykonuje filtrowanie. Jej pierwszym argumentem jest zbiór danych na których ma pracować, a kolejne argumenty to warunki logiczne. 

Wynikiem tej funkcji są wiersze spełniające wszystkie określone warunki logiczne. Określając warunki można wykorzystywać nazwy kolumn ze zbioru danych bez podawania dodatkowych odnośników.

Przykładowo, instrukcja które ze zbioru danych `auta2012` wybierze tylko oferty ze wskazanym polem `Marka == "Porsche"`.


```r
library(dplyr)
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
library(PogromcyDanych)
```

```
## Loading required package: SmarterPoland
```

```
## Loading required package: ggplot2
```

```
## Loading required package: httr
```

```
## Loading required package: htmltools
```

```r
tmp <- filter(auta2012,
        Marka == "Porsche")
head(tmp)
```

```
##     Cena Waluta Cena.w.PLN Brutto.netto  KM  kW   Marka         Model
## 1 244900    PLN     244900        netto 388 285 Porsche           911
## 2 229000    PLN     229000       brutto 355 261 Porsche           911
## 3 133990    PLN     133990        netto 295 217 Porsche       Boxster
## 4 154900    PLN     154900       brutto 295 217 Porsche       Boxster
## 5 162520    PLN     162520        netto 500 368 Porsche Cayenne Turbo
## 6 162520    PLN     162520        netto 500 368 Porsche       Cayenne
##   Wersja Liczba.drzwi Pojemnosc.skokowa Przebieg.w.km Rodzaj.paliwa
## 1                 2/3              5461         32350       benzyna
## 2                 2/3              3824         63000       benzyna
## 3                 2/3              3387         52849       benzyna
## 4                 2/3              3387         52849       benzyna
## 5                 4/5              4806         57000       benzyna
## 6                 4/5              4511         62000       benzyna
##   Rok.produkcji            Kolor Kraj.aktualnej.rejestracji
## 1          2008 srebrny-metallic                     Polska
## 2          2007  czarny-metallic                     Polska
## 3          2007  czarny-metallic                     Polska
## 4          2007  czarny-metallic                     Polska
## 5          2007  czarny-metallic                     Polska
## 6          2007  czarny-metallic                     Polska
##   Kraj.pochodzenia Pojazd.uszkodzony Skrzynia.biegow
## 1           Polska                      automatyczna
## 2           Polska                          manualna
## 3           Polska                      automatyczna
## 4           Polska                      automatyczna
## 5           Polska                      automatyczna
## 6           Polska                      automatyczna
##   Status.pojazdu.sprowadzonego
## 1                             
## 2                             
## 3                             
## 4                             
## 5                             
## 6                             
##                                                                                                                                                                                                                                                                                                                                                                          Wyposazenie.dodatkowe
## 1                           ABS, el. szyby, el. lusterka, klimatyzacja, skorzana tapicerka, alufelgi, system nawigacji, szyberdach, ASR, centralny zamek, poduszka powietrzna, radio / CD, wspomaganie kierownicy, immobiliser, komputer, ksenony, tempomat, podgrzewane fotele, czujnik deszczu, lwiatla przeciwmglowe, kierownica wielofunkcyjna, czujnik parkowania, reg. wysokole podwozia
## 2                                                                                                     ABS, 4x4, hak, el. szyby, klimatyzacja, skorzana tapicerka, alufelgi, system nawigacji, ASR, centralny zamek, autoalarm, poduszka powietrzna, radio / CD, wspomaganie kierownicy, immobiliser, komputer, ksenony, tempomat, podgrzewane fotele, czujnik deszczu, ESP, czujnik parkowania
## 3                                                                                                                                                                                                             ABS, el. lusterka, klimatyzacja, skorzana tapicerka, alufelgi, szyberdach, centralny zamek, autoalarm, poduszka powietrzna, radio / CD, immobiliser, ksenony, czujnik parkowania
## 4                                                                                                                                          ABS, el. lusterka, klimatyzacja, skorzana tapicerka, alufelgi, ASR, centralny zamek, autoalarm, poduszka powietrzna, radio / CD, wspomaganie kierownicy, immobiliser, komputer, ksenony, podgrzewane fotele, czujnik deszczu, lwiatla przeciwmglowe
## 5                                               ABS, 4x4, el. szyby, el. lusterka, klimatyzacja, skorzana tapicerka, alufelgi, system nawigacji, ASR, centralny zamek, autoalarm, poduszka powietrzna, radio / CD, wspomaganie kierownicy, immobiliser, komputer, ksenony, tempomat, podgrzewane fotele, czujnik deszczu, lwiatla przeciwmglowe, kierownica wielofunkcyjna, czujnik parkowania
## 6 ABS, 4x4, el. lusterka, klimatyzacja, skorzana tapicerka, alufelgi, system nawigacji, ASR, centralny zamek, autoalarm, poduszka powietrzna, radio / CD, wspomaganie kierownicy, immobiliser, komputer, ksenony, tempomat, podgrzewane fotele, czujnik deszczu, ESP, EDS, lwiatla przeciwmglowe, kierownica wielofunkcyjna, niezalezne ogrzewanie, czujnik parkowania, reg. wysokole podwozia
```

Możemy określać jednocześnie więcej warunków. Poniższy przykład jako wynik zbuduje zbiór danych marki `Porsche` z silnikami przekraczającymi 300 KM.


```r
tylkoPorscheZDuzymSilnikiem <- filter(auta2012,
         Marka == "Porsche",
         KM > 300)
head(tylkoPorscheZDuzymSilnikiem)
```

```
##     Cena Waluta Cena.w.PLN Brutto.netto  KM  kW   Marka         Model
## 1 244900    PLN     244900        netto 388 285 Porsche           911
## 2 229000    PLN     229000       brutto 355 261 Porsche           911
## 3 162520    PLN     162520        netto 500 368 Porsche Cayenne Turbo
## 4 162520    PLN     162520        netto 500 368 Porsche       Cayenne
## 5  69900    PLN      69900       brutto 340 250 Porsche       Cayenne
## 6 359000    PLN     359000       brutto 400 294 Porsche      Panamera
##   Wersja Liczba.drzwi Pojemnosc.skokowa Przebieg.w.km Rodzaj.paliwa
## 1                 2/3              5461         32350       benzyna
## 2                 2/3              3824         63000       benzyna
## 3                 4/5              4806         57000       benzyna
## 4                 4/5              4511         62000       benzyna
## 5                 4/5              4511         94000       benzyna
## 6                 4/5              4800         29000       benzyna
##   Rok.produkcji            Kolor Kraj.aktualnej.rejestracji
## 1          2008 srebrny-metallic                     Polska
## 2          2007  czarny-metallic                     Polska
## 3          2007  czarny-metallic                     Polska
## 4          2007  czarny-metallic                     Polska
## 5          2004   szary-metallic                     Polska
## 6          2010  bezowy-metallic                     Polska
##    Kraj.pochodzenia Pojazd.uszkodzony Skrzynia.biegow
## 1            Polska                      automatyczna
## 2            Polska                          manualna
## 3            Polska                      automatyczna
## 4            Polska                      automatyczna
## 5 Stany Zjednoczone                      automatyczna
## 6                                        automatyczna
##   Status.pojazdu.sprowadzonego
## 1                             
## 2                             
## 3                             
## 4                             
## 5                             
## 6                             
##                                                                                                                                                                                                                                                                                                                                                                                                                                       Wyposazenie.dodatkowe
## 1                                                                                        ABS, el. szyby, el. lusterka, klimatyzacja, skorzana tapicerka, alufelgi, system nawigacji, szyberdach, ASR, centralny zamek, poduszka powietrzna, radio / CD, wspomaganie kierownicy, immobiliser, komputer, ksenony, tempomat, podgrzewane fotele, czujnik deszczu, lwiatla przeciwmglowe, kierownica wielofunkcyjna, czujnik parkowania, reg. wysokole podwozia
## 2                                                                                                                                                                  ABS, 4x4, hak, el. szyby, klimatyzacja, skorzana tapicerka, alufelgi, system nawigacji, ASR, centralny zamek, autoalarm, poduszka powietrzna, radio / CD, wspomaganie kierownicy, immobiliser, komputer, ksenony, tempomat, podgrzewane fotele, czujnik deszczu, ESP, czujnik parkowania
## 3                                                                                                            ABS, 4x4, el. szyby, el. lusterka, klimatyzacja, skorzana tapicerka, alufelgi, system nawigacji, ASR, centralny zamek, autoalarm, poduszka powietrzna, radio / CD, wspomaganie kierownicy, immobiliser, komputer, ksenony, tempomat, podgrzewane fotele, czujnik deszczu, lwiatla przeciwmglowe, kierownica wielofunkcyjna, czujnik parkowania
## 4                                                              ABS, 4x4, el. lusterka, klimatyzacja, skorzana tapicerka, alufelgi, system nawigacji, ASR, centralny zamek, autoalarm, poduszka powietrzna, radio / CD, wspomaganie kierownicy, immobiliser, komputer, ksenony, tempomat, podgrzewane fotele, czujnik deszczu, ESP, EDS, lwiatla przeciwmglowe, kierownica wielofunkcyjna, niezalezne ogrzewanie, czujnik parkowania, reg. wysokole podwozia
## 5 ABS, 4x4, hak, el. szyby, el. lusterka, klimatyzacja, skorzana tapicerka, alufelgi, szyberdach, ASR, centralny zamek, autoalarm, poduszka powietrzna, radio / CD, wspomaganie kierownicy, immobiliser, instalacja gazowa, komputer, ksenony, tempomat, podgrzewane fotele, czujnik deszczu, ESP, lwiatla przeciwmglowe, kierownica wielofunkcyjna, czujnik parkowania, reg. wysokole podwozia, bagaznik na dach, przyciemniane szyby, pod. przednia szyba
## 6                   ABS, 4x4, el. szyby, el. lusterka, klimatyzacja, skorzana tapicerka, alufelgi, system nawigacji, szyberdach, ASR, centralny zamek, autoalarm, poduszka powietrzna, radio / CD, wspomaganie kierownicy, immobiliser, komputer, ksenony, tempomat, podgrzewane fotele, czujnik deszczu, ESP, EDS, lwiatla przeciwmglowe, kierownica wielofunkcyjna, czujnik parkowania, reg. wysokole podwozia, przyciemniane szyby, blokada dyferencjalu
```

