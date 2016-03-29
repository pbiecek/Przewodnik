# Jak czyścić dane?

Funkcje w pakiecie `dplyr` zakładają że przetwarzanie jest wykonywane po kolumnach. Cała kolumna jest transformowana ale na raz transformowana jest tylko jedna kolumna.

Jednak czasem dane są w formacie, gdy przetwarzanie chciałoby wykonać się w wierszach. Z jednej strony można wyobrazić sobie kolejne funkcje, które działałyby na wierszach, ale zwiększyłoby to bałagan związany z tym co i kiedy można zrobić na jakich danych.

Dlatego logika w tandemie `dplyr` + `tidyr` oparta jest na przetwarzaniu kolumnowym. Jeżeli dane są rozsmarowane w wierszach to potrzebujemy instrukcji które przetworzą je na postać kolumnową (tak zwaną postać wąską).

Jako przykład dla takich funkcji wykorzystamy dane z Eurostatu udostępniane przez pakiet `dplyr`.

Poniżej wczytujemy dane z tabeli `tsdtr210` która w Eurostacie gromadzi dane o udziale środków transportu w różnych krajach.


```r
library(eurostat)

tsdtr210 <- getEurostatRCV("tsdtr210")
head(tsdtr210)
```

```
##                    unit vehicle geo time value
## PC_BUS_TOT_AT_1990   PC BUS_TOT  AT 1990  11.0
## PC_BUS_TOT_BE_1990   PC BUS_TOT  BE 1990  10.6
## PC_BUS_TOT_BG_1990   PC BUS_TOT  BG 1990    NA
## PC_BUS_TOT_CH_1990   PC BUS_TOT  CH 1990   3.7
## PC_BUS_TOT_CY_1990   PC BUS_TOT  CY 1990    NA
## PC_BUS_TOT_CZ_1990   PC BUS_TOT  CZ 1990    NA
```

Pobrane dane są w postaci wąskiej. Kolumna `geo` określa kraj, kolumna `time` określa rok, kolumna `vehicle` rodzaj transportu, a kolumna `value` popularność danego rodzaju transportu w określonym kraju, w określonym roku.

## Rozsmaruj na kolumny

Aby przejść z postaci wąskiej do postaci szerokiej, można użyć funkcji `spread()`.
Ta funkcja poza pierwszym argumentem - zbiorem danych - oczekuje jeszcze dwóch innych argumentów. Jeden będzie kluczem odpowiadającym nazwom kolumn a drugi będzie wartościami, które zostaną wpisane do poszczególnych kolumn. Wiersze nowej tabeli z danymi są wybierane jako unikalne wartości w pozostałych kolumnach (tutaj wiersze będą opisywały unikalne kombinacje jednostki, typu transportu i kraju).


```r
library(tidyr)

szeroka <- spread(tsdtr210, time, value)
szeroka %>% filter(geo == "PL")
```

```
##   unit vehicle geo 1990 1991 1992 1993 1994 1995 1996 1997 1998 1999 2000
## 1   PC BUS_TOT  PL 28.1 25.6 24.4 23.2 20.9 19.9 19.4 17.9 17.4 16.8 27.7
## 2   PC     CAR  PL 41.3 49.8 55.3 57.9 62.3 64.6 69.3 71.3 72.1 72.3 61.0
## 3   PC     TRN  PL 30.6 24.6 20.3 18.9 16.8 15.5 11.3 10.8 10.5 10.9 11.3
##   2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013
## 1 26.4 24.9 24.3 23.6 22.4 21.8 20.8 19.9 17.9 16.8 15.7 14.8 14.1
## 2 62.9 65.1 66.5 67.9 69.4 70.1 70.7 71.9 74.7 76.1 77.4 78.5 79.6
## 3 10.7  9.9  9.2  8.5  8.2  8.2  8.5  8.2  7.4  7.1  6.9  6.7  6.2
```

Dane w tabeli pobranej z baz Eurostatu mają więcej wymiarów. Każdy z nich może być użyty do stworzenia nowych kolumn.

Przykładowo poniżej, kolejne kolumny opisują dane z różnych krajów.


```r
szeroka2 <- spread(tsdtr210, geo, value)
# wyświetlmy wiersze dla roku 2010
szeroka2 %>% filter(time == "2010")
```

```
##   unit vehicle time   AT   BE   BG   CH   CY   CZ DE   DK   EE   EL   ES
## 1   PC BUS_TOT 2010 10.3 12.7 16.4  5.1 18.1 19.5  6 10.5 14.4 17.3 12.3
## 2   PC     CAR 2010 78.7 79.7 80.0 77.3 81.9 73.0 86 79.7 83.6 81.6 82.3
## 3   PC     TRN 2010 11.0  7.7  3.6 17.6   NA  7.5  8  9.8  2.0  1.1  5.4
##   EU27 EU28   FI   FR   HR   HU   IE   IS   IT   LT   LU   LV   MK   MT
## 1  9.2  9.2  9.9  5.3 10.7 21.5 14.5 11.4 12.1  7.6 12.1 17.1 20.3 18.5
## 2 83.6 83.6 84.9 85.5 83.7 68.6 82.6 88.6 82.4 91.7 83.5 78.2 77.5 81.5
## 3  7.2  7.2  5.2  9.3  5.6 10.0  2.9   NA  5.6  0.7  4.5  4.7  2.2   NA
##     NL   NO   PL   PT   RO   SE   SI   SK   TR   UK
## 1  3.5  6.8 16.8  6.5 12.9  7.2 10.8 15.3 38.3  6.2
## 2 87.7 88.4 76.1 89.1 81.3 83.4 86.8 78.0 59.3 86.3
## 3  8.9  4.8  7.1  4.4  5.9  9.4  2.5  6.7  2.4  7.5
```

# Zbierz w kolumny

Operacją odwrotną do rozsmarowania jest zbieranie w kolumny, można je wykonać funkcją `gather()`. Przekształca ona dane z postaci szerokiej do wąskiej.

Funkcja ta jako pierwszy argument wskazuje zbiór danych, kolejne dwa argumenty określają nazwy kolumn z kluczami i wartościami a pozostałe argumenty wskazują kolumny starego zbioru danych , które mają być zebrane razem w nowym zbiorze danych. Można stosować notacje z `-` czyli ,,wszystko poza...''.


```r
szeroka %>% 
  gather(rok, wartosc, -geo, -vehicle) %>%
  tail()
```

```
##      vehicle geo  rok wartosc
## 2620     TRN  RO 2013     4.5
## 2621     TRN  SE 2013     9.3
## 2622     TRN  SI 2013     2.3
## 2623     TRN  SK 2013     7.1
## 2624     TRN  TR 2013     1.4
## 2625     TRN  UK 2013     8.4
```

Aby wyświetlić przykładowe 6 wierszy użyto tutaj funkcji `tail()` (wyświetla ostatnie sześć wierszy) ponieważ w pierwszych sześciu wierszach są wartości `NA`,

## Sklejanie kolumn

Zdarza się, że wartości z kilku kolumn chcemy skleić ze sobą w jedną kolumnę (w napis).
Można to zrobić funkcją `unite()`.

Poniższy przykład skleja wartości w kolumnach `geo` i `time` w jedną kolumnę `geo_time`.


```r
unite(tsdtr210, geo_time, geo, time, sep=":") %>%
  head()
```

```
##                    unit vehicle geo_time value
## PC_BUS_TOT_AT_1990   PC BUS_TOT  AT:1990  11.0
## PC_BUS_TOT_BE_1990   PC BUS_TOT  BE:1990  10.6
## PC_BUS_TOT_BG_1990   PC BUS_TOT  BG:1990    NA
## PC_BUS_TOT_CH_1990   PC BUS_TOT  CH:1990   3.7
## PC_BUS_TOT_CY_1990   PC BUS_TOT  CY:1990    NA
## PC_BUS_TOT_CZ_1990   PC BUS_TOT  CZ:1990    NA
```

Operacja sklejenia jest często przydatna, jeżeli chcemy oprzeć grupowanie o kilka zmiennych. Wtedy te zmienne możemy posklejać i taki zlepek traktować jako nową zmienną grupującą.

## Rozcinanie kolumn

Operację odwrotną do sklejania, a więc rozcinanie kolumn, można wykonać funkcją `separate()`.

Przedstawimy działanie tej funkcji na przykładzie sztucznego zbioru danych z dwoma kolumnami - datą i id.

W poniższym przykładzie, funkcja `separate()` na podstawie kolumny `daty` tworzy trzy nowe kolumny. Wypełnia je wartościami po rozbiciu napisy na części rozdzielone znakiem `-`.


```r
df <- data.frame(daty = c("2004-01-01", "2012-04-15", "2006-10-29", "2010-03-03"),
                 id = 1:4)
df
```

```
##         daty id
## 1 2004-01-01  1
## 2 2012-04-15  2
## 3 2006-10-29  3
## 4 2010-03-03  4
```

```r
separate(df, col = daty, into = c("rok", "miesiac", "dzien"), sep = "-")
```

```
##    rok miesiac dzien id
## 1 2004      01    01  1
## 2 2012      04    15  2
## 3 2006      10    29  3
## 4 2010      03    03  4
```

Jeżeli w kolumnie, która jest rozcinana, będzie zbyt mało lub zbyt dużo wartości (np. tylko dwa elementy rozdzielane separatorem) to domyślnie funkcja `separate()` będzie sygnalizowała ostrzeżenia.
Dodatkowymi argumentami `extra=` i `fill=` można określić jak traktowane mają być nadmiarowe lub brakujące elementy.

