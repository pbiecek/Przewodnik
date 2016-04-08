# Jak analizować czas działania kodu R? 

Skrypty R działają za wolno?

To z pewnością wina tych leniwych twórców R, którzy coś źle zrobili!

...

A może nie?

A może to nasz kod jest nieefektywnie napisany?

Jeżeli dopuszczasz taką możliwość to przydadzą Ci się narzędzia do analizy czasu działania kodu R.


# Czas działania zbioru instrukcji

Funkcja `system.time()` zlicza jak długo (w sekundach) wykonuje się określony zbiór instrukcji.
Raportowane są trzy liczby, `elapsed` - czyli ile czasu minęło, `user` - ile czasu procesora zużył R, `system` - ile czasu procesora zużyły w tym czasie procesy poza R.

Stwórzmy dużą ramkę danych i zobaczmy jak długo trwa policzenie na niej regresji liniowej.


```r
system.time({
  N <- 2000
  df <- as.data.frame(matrix(runif(2*N*N), 2*N, N))
  tmp <- summary(lm(V1~., data=df))
})
```

```
##    user  system elapsed 
##  15.538   0.375  16.502
```

Kilkanaście sekund! 

# Profiler

Mierzenie całkowitego czasu działania może być przydatne, choć często chcielibyśmy czegoś więcej. Wiadomo, że funkcja `lm()` wywołuje pod funkcje. Która z nich zabiera lwią część czasu działania?

Aby to sprawdzić można wykorzystać funkcję `Rprof()`.
Uaktywnia ona profiler, który do określony czas (argument `interval`, domyślnie 0.02 sek) sprawdza jak wygląda stos wywołań R. Informacje o tym stosie wywołań są zapisywane w pliku wskazanym przez argument `filename`, domyślnie w pliku `Rprof.out`.


```r
Rprof("profiler.out", interval = 0.01, memory.profiling=TRUE)
  N <- 2000
  df <- as.data.frame(matrix(runif(2*N*N), 2*N, N))
  tmp <- summary(lm(V1~., data=df))
Rprof()
```

Fragment pliku `Rprof.out` jest przedstawiony poniżej. Pierwsze kolumny opisują zajętość pamięci, ostatnia wymienia funkcje, które aktualnie znajdują się na stosie wywołania.

```
memory profiling: sample.interval=10000
:2707201:50881097:139412560:121:"runif" "matrix" "as.data.frame" 
:2707201:50881097:139412560:0:"runif" "matrix" "as.data.frame" 
:2707201:50881097:139412560:0:"runif" "matrix" "as.data.frame" 
:2707201:50881097:139412560:0:"runif" "matrix" "as.data.frame" 
:2707206:58881410:139413624:0:"matrix" "as.data.frame" 
:2707206:58881410:139413624:0:"matrix" "as.data.frame" 
:2707206:58881410:139413624:0:"matrix" "as.data.frame" 
:2707206:58881410:139413624:0:"matrix" "as.data.frame" 
:2708210:64700854:140252056:0:"as.vector" "as.data.frame.matrix" "as.data.frame" 
```

Analiza bezpośrednia pliku `Rprof.out` nie jest łatwa, ponieważ ten plik trzeba odpowiednio przetworzyć aby wyliczyć, która funkcja jak długo działania. 

To przetworzenie jest wykonywane funkcją `summaryRprof()`. Zwraca ona listę z czterema elementami:

* `by.self` informacja, która funkcja jak długo działała, uporządkowana zgodnie z czasem działania wyłącznie danej funkcji bez podfunkcji.
* `by.total` informacja, która funkcja jak długo działała wliczając czas działania podfunkcji,
* `sample.interval`, częstość próbkowania kodu,
* `sampling.time`, czas trwania całego analizowanego kodu.

Poniżej przedstawiamy przykład działania


```r
summaryRprof("profiler.out")$by.self
```

```
##                           self.time self.pct total.time total.pct
## "lm.fit"                       7.96    71.71       7.96     71.71
## "chol2inv"                     1.85    16.67       1.85     16.67
## "matrix"                       0.21     1.89       0.38      3.42
## "runif"                        0.17     1.53       0.17      1.53
## "na.omit.data.frame"           0.11     0.99       0.29      2.61
## "[.data.frame"                 0.10     0.90       0.10      0.90
## "makepredictcall.default"      0.10     0.90       0.10      0.90
## ".External2"                   0.09     0.81       0.42      3.78
## "as.vector"                    0.09     0.81       0.09      0.81
## ".External"                    0.08     0.72       0.08      0.72
## "is.na"                        0.08     0.72       0.08      0.72
## "na.omit"                      0.04     0.36       0.33      2.97
## "%in%"                         0.03     0.27       0.06      0.54
## "match"                        0.03     0.27       0.05      0.45
## "summary.lm"                   0.02     0.18       1.87     16.85
## "makepredictcall"              0.02     0.18       0.12      1.08
## "paste"                        0.02     0.18       0.09      0.81
## "[["                           0.02     0.18       0.05      0.45
## "vapply"                       0.02     0.18       0.02      0.18
## "model.frame.default"          0.01     0.09       0.60      5.41
## "deparse"                      0.01     0.09       0.07      0.63
## ".subset2"                     0.01     0.09       0.01      0.09
## "all"                          0.01     0.09       0.01      0.09
## "model.response"               0.01     0.09       0.01      0.09
## "pmatch"                       0.01     0.09       0.01      0.09
```

## Graficzne statystyki z pakietem profr

Funkcja `summaryRprof()` przedstawia statystyki działania w sposób tekstowy. Ale często dobrym uzupełnieniem takiej informacji jest wykres, pokazujący jak długo trwają które funkcje i podfunkcje.

Taką graficzną analizę kodu można wykonać pakietem `profr` (nie zgadniecie kto jest twórcą tego pakietu, tak Hadley Wickham). 

Pakiet ten wykorzystać można na dwa sposoby. Można funkcją `parse_rprof()` odczytać plik utworzony przez `Rprof()`. Lub (co jest zalecane) profilowanie można wykonać funkcją `profr()`, która zawiera dodatkowe informacje o czasie wykonania.

Poniżej te dodatkowe informacje są wypisywane, dodatkowo generyczna funkcja `plot()` przedstawia graficznie stos wywołań funkcji.


```r
library(profr)
pro <- profr({
  N <- 2000
  df <- as.data.frame(matrix(runif(2*N*N), 2*N, N))
  tmp <- summary(glm(V1~., data=df))
}, 0.01)
head(pro)
```

```
##    level g_id t_id                    f start   end n  leaf  time source
## 28     1    1    1        as.data.frame  0.00  0.43 1 FALSE  0.43   base
## 29     1    2    1              summary  0.43 20.15 1 FALSE 19.72   base
## 30     2    1    1               matrix  0.00  0.33 1 FALSE  0.33   base
## 31     2    2    1 as.data.frame.matrix  0.33  0.43 1 FALSE  0.10   base
## 32     2    3    1                  glm  0.43 18.42 1 FALSE 17.99  stats
## 33     2    4    1          summary.glm 18.42 20.15 1 FALSE  1.73  stats
```

```r
plot(pro)
```

![plot of chunk profiler](figure/profiler-1.png)

Na bazie tego jednego wykresu łatwo zauważyć, że generowanie danych trwało chwilę, wywołanie `summary()` trwało trochę dłużej, a najwięcej czasu zabrała funkcja `glm()`

## Ale po co nam to?

Mierząc czas działania, możemy porównać kilka potencjalnych rozwiązań i wybrać lepsze.

Zobaczmy na przykład, w jaki sposób tworzyć wektor 100 000 losowych liczb z rozkładu jednostajnego. Porównamy cztery możliwe rozwiązania i zobaczymy które jest najszybsze.


```r
system.time({ x=NULL; for (i in 1:10^5) x =c(x, runif(1)) })
```

```
##    user  system elapsed 
##  16.979  13.325  30.399
```

```r
system.time({ x=NULL; for (i in 1:10^5) x[i] =runif(1) })
```

```
##    user  system elapsed 
##   9.500  12.624  22.196
```

```r
system.time({x=numeric(10^5); for(i in 1:10^5) x[i]=runif(1)})
```

```
##    user  system elapsed 
##   0.308   0.037   0.360
```

```r
system.time({ x=NULL; x = runif(10^5) })
```

```
##    user  system elapsed 
##   0.003   0.000   0.003
```

Pierwsze dwa dynamicznie rozciągają wektor, co w R oznacza kopiowanie w kółko całego wektora wyników. Trwa to długo. Inicjacja wektora pustymi wartościami powoduje że czas obliczeń skrócił się 30 razy. Wektoryzacja obliczeń skraca czas obliczeń o kolejne 10 razy.

## Z dokładnością do mikrosekundy

Jeżeli mierzenie czasu działania z dokładnością do sekundy nie jest wystarczające, to warto skorzystać z biblioteki `microbenchmark`. Nie dość, że powtarza ona określone instrukcje wiele razy (domyślnie 100), to jeszcze prezentuje graficznie i tekstowo rozkład czasów działania.



```r
library(microbenchmark)
library(ggplot2)

microbenchmark(
  skladanie = { x=NULL; for (i in 1:10^3) x =c(x, runif(1)) },
  skladanie2 = { x=NULL; for (i in 1:10^3) x[i] =runif(1) },
  inicjacja = {x=numeric(10^3); for(i in 1:10^3) x[i]=runif(1)},
  wektoryzacja = { x=NULL; x = runif(10^3) })
```

```
## Unit: microseconds
##          expr      min       lq       mean   median       uq       max
##     skladanie 2961.737 3684.758 4542.48931 4008.024 4236.851 58727.642
##    skladanie2 3058.808 3773.830 4638.96561 4036.253 4418.396 53049.009
##     inicjacja 2250.163 2504.703 5033.90407 2832.123 3247.410 68066.542
##  wektoryzacja   29.412   30.919   42.17776   32.027   33.770   874.727
##  neval cld
##    100   b
##    100   b
##    100   b
##    100  a
```

```r
boxplot(.Last.value)
```

```
## Error in sort.int(x, na.last = na.last, decreasing = decreasing, ...): 'x' must be atomic
```

```r
autoplot(.Last.value)
```

```
## Error: Objects of type gg/ggplot not supported by autoplot.
```

