# Jak pracować z wektorami?

Trzy podstawowe struktury danych w programie R to:

* wektory - uporządkowane zbiory wartości tego samego typu, np. wektory liczb, napisów. 
* tabele z danymi - uporządkowany zbiór wektorów o tej samej długości (kolumn w tabeli z danymi). 
* listy - uporządkowane zbiory wartości, potencjalnie każda wartość może mieć inny typ.

Poniżej pokażemy jak z tych typów korzystać.

W programie R nawet jedna wartość jest wektorem, tyle że małym, jednoelementowym.


```r
4
```

```
## [1] 4
```

Dłuższe wektory można tworzyć funkcją `c()`, która skleja kilka wektorów w jeden.


```r
c(3, 4, 5)
```

```
## [1] 3 4 5
```

Przykładami wektorów są sekwencje, czyli kolekcje kolejnych wartości liczbowych. 
Sekwencje kolejnych liczb można stworzyć operatorem `:` lub funkcją `seq()`.


```r
2:7
```

```
## [1] 2 3 4 5 6 7
```

```r
seq(from = 3, to = 15, by = 2)
```

```
## [1]  3  5  7  9 11 13 15
```

W podobny sposób można tworzyć wektory wartości logicznych lub napisowych.


```r
w_logiczne <- c(TRUE, FALSE, TRUE, FALSE, TRUE, FALSE)
w_logiczne
```

```
## [1]  TRUE FALSE  TRUE FALSE  TRUE FALSE
```

```r
w_napisy <- c("alfa", "beta", "gamma", "delta")
w_napisy
```

```
## [1] "alfa"  "beta"  "gamma" "delta"
```

## Indeksowanie wektora

W jaki sposób wybierać elementy wektora? Indeksując ten wektor. Zobaczmy jak budować indeksy za przykład wykorzystując kolejne litery alfabetu łacińskiego.


```r
head(LETTERS)
```

```
## [1] "A" "B" "C" "D" "E" "F"
```

Aby odwołać się do określonych indeksów wektora należy użyć operatora []. Wewnątrz nawiasów kwadratowych podaje się indeks elementu, do którego chcemy się odwołać.


```r
LETTERS[5]
```

```
## [1] "E"
```

```r
LETTERS[c(1, 5, 10)]
```

```
## [1] "A" "E" "J"
```

```r
indeksy <- c(1, 5, 10)
LETTERS[indeksy]
```

```
## [1] "A" "E" "J"
```

```r
LETTERS[10:1]
```

```
##  [1] "J" "I" "H" "G" "F" "E" "D" "C" "B" "A"
```

Indeksować można również używając wartości logicznych.


```r
LETTERS > "K"
```

```
##  [1] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [12]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
## [23]  TRUE  TRUE  TRUE  TRUE
```

## Indeksowanie tabel danych

Tabelę z danymi indeksuje się w ten sam sposób co wektory, z tą różnicą, że należy osobno wskazać indeksy dla wierszy i kolumn.

Indeksy podaje się w nawiasach kwadratowych, indeksy wierszy od indeksów kolumn rozdziela się znakiem przecinka. Do dalszych przykładów wykorzystamy przykładową ramkę z danymi.


```r
library(PogromcyDanych)
koty_ptaki
```

```
##           gatunek   waga dlugosc predkosc  habitat zywotnosc druzyna
## 1          Tygrys 300.00     2.5       60     Azja        25     Kot
## 2             Lew 200.00     2.0       80   Afryka        29     Kot
## 3          Jaguar 100.00     1.7       90  Ameryka        15     Kot
## 4            Puma  80.00     1.7       70  Ameryka        13     Kot
## 5         Leopard  70.00     1.4       85     Azja        21     Kot
## 6          Gepard  60.00     1.4      115   Afryka        12     Kot
## 7           Irbis  50.00     1.3       65     Azja        18     Kot
## 8          Jerzyk   0.05     0.2      170 Euroazja        20    Ptak
## 9           Strus 150.00     2.5       70   Afryka        45    Ptak
## 10  Orzel przedni   5.00     0.9      160   Polnoc        20    Ptak
## 11 Sokol wedrowny   0.70     0.5      110   Polnoc        15    Ptak
## 12 Sokol norweski   2.00     0.7      100   Polnoc        20    Ptak
## 13       Albatros   4.00     0.8      120 Poludnie        50    Ptak
```


Przykładowe odwołanie się do trzeciego wiersza z ramki danych


```r
koty_ptaki[3, ]
```

```
##   gatunek waga dlugosc predkosc habitat zywotnosc druzyna
## 3  Jaguar  100     1.7       90 Ameryka        15     Kot
```

Aby wybrać fragment tabeli z danymi, można indeksować i wiersze i kolumny.


```r
koty_ptaki[2:7, c(1,2,5)]
```

```
##   gatunek waga habitat
## 2     Lew  200  Afryka
## 3  Jaguar  100 Ameryka
## 4    Puma   80 Ameryka
## 5 Leopard   70    Azja
## 6  Gepard   60  Afryka
## 7   Irbis   50    Azja
```


Funkcje `head()` i `tail()` wybierają kilka pierwszych/ ostatnich wierszy. Domyślnie 6, ale określając wartość drugiego argumentów można wybrać mniej / więcej wierszy.


```r
head(koty_ptaki,2)
```

```
##   gatunek waga dlugosc predkosc habitat zywotnosc druzyna
## 1  Tygrys  300     2.5       60    Azja        25     Kot
## 2     Lew  200     2.0       80  Afryka        29     Kot
```

Podobnie jak dla wektorów można wybierać wiersze/kolumny używając indeksów logicznych lub nazw wierszy/kolumn.


```r
najszybsze <- koty_ptaki$predkosc > 120
najszybsze
```

```
##  [1] FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE  TRUE FALSE
## [12] FALSE FALSE
```

```r
koty_ptaki[najszybsze, ]
```

```
##          gatunek waga dlugosc predkosc  habitat zywotnosc druzyna
## 8         Jerzyk 0.05     0.2      170 Euroazja        20    Ptak
## 10 Orzel przedni 5.00     0.9      160   Polnoc        20    Ptak
```

I przez nazwy.


```r
colnames(koty_ptaki)
```

```
## [1] "gatunek"   "waga"      "dlugosc"   "predkosc"  "habitat"   "zywotnosc"
## [7] "druzyna"
```

```r
koty_ptaki[, "waga"]
```

```
##  [1] 300.00 200.00 100.00  80.00  70.00  60.00  50.00   0.05 150.00   5.00
## [11]   0.70   2.00   4.00
```

Indeksy można wykorzystywać by sortować tabele z danymi.


```r
koty_ptaki[,"predkosc"]
```

```
##  [1]  60  80  90  70  85 115  65 170  70 160 110 100 120
```

```r
order(koty_ptaki[,"predkosc"])
```

```
##  [1]  1  7  4  9  2  5  3 12 11  6 13 10  8
```

```r
kolejnosc <- order(koty_ptaki[,"predkosc"])
koty_ptaki[kolejnosc, ]
```

```
##           gatunek   waga dlugosc predkosc  habitat zywotnosc druzyna
## 1          Tygrys 300.00     2.5       60     Azja        25     Kot
## 7           Irbis  50.00     1.3       65     Azja        18     Kot
## 4            Puma  80.00     1.7       70  Ameryka        13     Kot
## 9           Strus 150.00     2.5       70   Afryka        45    Ptak
## 2             Lew 200.00     2.0       80   Afryka        29     Kot
## 5         Leopard  70.00     1.4       85     Azja        21     Kot
## 3          Jaguar 100.00     1.7       90  Ameryka        15     Kot
## 12 Sokol norweski   2.00     0.7      100   Polnoc        20    Ptak
## 11 Sokol wedrowny   0.70     0.5      110   Polnoc        15    Ptak
## 6          Gepard  60.00     1.4      115   Afryka        12     Kot
## 13       Albatros   4.00     0.8      120 Poludnie        50    Ptak
## 10  Orzel przedni   5.00     0.9      160   Polnoc        20    Ptak
## 8          Jerzyk   0.05     0.2      170 Euroazja        20    Ptak
```

