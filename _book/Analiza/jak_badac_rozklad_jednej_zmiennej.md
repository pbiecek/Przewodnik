# Jak badać rozkład jednej zmiennej?

W tym rozdziale przedstawimy podstawowe narzędzia analizy rozkładu zmiennych ilościowych i jakościowych.
Wykorzystamy do tego bazę danych dotyczących posłów z 8 kadencji Sejmu.
Dane pobierane są bezpośrednio z Internetu z serwisu GitHub.


```r
poslowie <- archivist::aread("pbiecek/Przewodnik/arepo/07088eb35cc2c9d2a2a856a36b3253ad")

head(poslowie)
```

```
##   Glosow                   Klub  Wyksztalcenie                      Zawod
## 1  10500 Prawo i Sprawiedliwość         wyższe              poseł na Sejm
## 2  18514 Prawo i Sprawiedliwość         wyższe           parlamentarzysta
## 3   7275  Platforma Obywatelska         wyższe         agroprzedsiębiorca
## 4  15668               Kukiz'15         wyższe specjalista ds. medialnych
## 5  12021 Prawo i Sprawiedliwość         wyższe           poseł na Sejm RP
## 6   7935               Kukiz'15 średnie ogólne                dziennikarz
##          ImieNazwisko DataUrodzenia MiejsceUrodzenia  Wiek
## 1     Adam Abramowicz    1961-03-10   Biała Podlaska 55.01
## 2    Andrzej Adamczyk    1959-01-04      Krzeszowice 57.19
## 3    Zbigniew Ajchler    1955-11-21        Szamotuły 60.32
## 4 Adam Andruszkiewicz    1990-06-30          Grajewo 25.69
## 5     Waldemar Andzel    1971-09-17          Czeladź 44.48
## 6          Piotr Apel    1984-02-08         Warszawa 32.08
```

## Zmienna ilościowa

W zbiorze danych `poslowie` mamy kilka zmiennych ilościowych. Czy potrafisz je wskazać? Z pewnoscią należy do nich `Wiek` i `Glosow`. 


Jaki jest średni wiek posłów?


```r
mean(poslowie$Wiek)
```

```
## [1] 50.36813
```


A średnia obcięta, wyznaczona na podstawie 60\% środkowych obserwacji?

```r
mean(poslowie$Wiek, trim=0.2)
```

```
## [1] 51.01785
```

Mediana bliska średniej, czyżby brak skośności?


```r
median(poslowie$Wiek)
```

```
## [1] 51.87
```

Odchylenie standardowe zmiennej wiek.


```r
sd(poslowie$Wiek)
```

```
## [1] 11.03323
```

Jaka jest najmniejsza i największa wartość przyjmowana przez zmienną Wiek?


```r
range(poslowie$Wiek)
```

```
## [1] 23.50 77.53
```

Ile wynosi rozstęp kwartylowy?


```r
IQR(poslowie$Wiek)
```

```
## [1] 17.195
```

Kurtoza / miara spłaszczenia. Aby ją wyznaczyć potrzebujemy pakietu `e1071`.


```r
library(e1071)
kurtosis(poslowie$Wiek)
```

```
## [1] -0.7078222
```

Skośność.


```r
skewness(poslowie$Wiek)
```

```
## [1] -0.2292414
```


Wybrane kwantyle zmiennej wiek.


```r
quantile(poslowie$Wiek, c(0.1, 0.25, 0.5, 0.75, 0.9))
```

```
##    10%    25%    50%    75%    90% 
## 34.586 42.025 51.870 59.220 63.864
```

Odchylenie medianowe.


```r
mad(poslowie$Wiek)
```

```
## [1] 12.39454
```

Najwazniejsze statystyki


```r
summary(poslowie$Wiek)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   23.50   42.02   51.87   50.37   59.22   77.53
```

## Zmienna jakościowa



- dla zmiennych ciągłych, dyskretnych, ciągłych z atomem
- estymator jądrowy gęstości (histogram)
- ecdf
- testy zgodności
