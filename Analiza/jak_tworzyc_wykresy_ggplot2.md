# Jak tworzyć wykresy z pakietem ggplot2?

Pakiet `ggplot2` jest jednym z najbardziej zaawansowanych narzędzi do tworzenia wykresów statystycznych. Zaawansowanie nie oznacza, że można w nim wykres zrobić szybko, ani też że dostępnych jest wiele cukierkowych wykresów, ale że konstrukcja pakietu jest na tyle elastyczna, że można z nim wykonać praktycznie każdą grafikę statystyczną.

Tą elastyczność uzyskuje się opierając opis wykresu na sposobie w jaki myślimy i czytamy wykresy. Patrząc na wykres nie widzimy w nim zbioru odcinków i kółek, ale kolekcje obiektów na swój sposób podobnych lub różnych. Gramatyka grafiki jest szerzej opisana [w tym eseju](http://biecek.pl/Eseje/indexGramatyka.html).

Poniższe przykłady oparte są o dwa zbiory danych. Zbiór `countries` ze współczynnikami dzietności / umieralności dla różnych krajów oraz zbiór `maturaExam` z wynikami matur w kolejnych latach.


```r
library(SmarterPoland)
head(countries)
```

```
##               country birth.rate death.rate population continent
## 1         Afghanistan       34.1        7.7      30552      Asia
## 2             Albania       12.9        9.4       3173    Europe
## 3             Algeria       24.3        5.7      39208    Africa
## 4             Andorra        8.9        8.4         79    Europe
## 5              Angola       44.1       13.9      21472    Africa
## 6 Antigua and Barbuda       16.5        6.8         90  Americas
```

```r
head(maturaExam)
```

```
##   id_ucznia punkty  przedmiot  rok
## 1         4     14 matematyka 2011
## 2         4     31  j. polski 2011
## 3         5     19 matematyka 2010
## 4         5     35  j. polski 2010
## 5         7     16 matematyka 2010
## 6         7     43  j. polski 2010
```

## Jak zrobić pierwszy wykres?

Minimalny wykres z pakietem `ggplot2` składa się przynajmniej z trzech elementów. 

* Funkcja `ggplot()` tworzy zrąb wykresu. W tym miejscu deklaruje się parametry wspólne dla pozostałych elementów wykresu. Deklaracja może być pusta, ale zazwyczaj wskazuje się tutaj zbiór danych (poniżej `countries`) i mapowania (poniżej funkcja `aes()`).
* Funkcje `geom_`/`stat_` tworzą kolejne warstwy prezentacji danych. Poniżej wykorzystywana jest funkcja `geom_point()` tworząca warstwę wykresu prezentującą dane. 
* Operator `+` łączy opisu kolejnych elementów wykresu.

Zbudujmy więc wykres, przedstawiający za pomocą punktów informacje o częstości narodzin i zgonów dla różnych krajów.


```r
library(ggplot2)

ggplot(countries, aes(x=birth.rate, y=death.rate)) +
  geom_point()
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2-1.png)

Gramatyka zaimplementowana w pakiecie `ggplot2` pozwala na budowę wykresów o strukturze przedstawionej na poniższej grafice. Składa się na z wielu elementów, omówimy je jeden po drugim.

![Szkielet gramatyki ggplot2](rysunki/ggplot2.png)

## Jak określać mapowania?


## Jak określać geometrię?


## Jak składać kilka geometrii?


## Jak określać statystyki?


## Jak tworzyć panele?


## Jak modyfikować położenie elementów?


## Jak modyfikować skale?


## Jak modyfikować układ współrzędnych?


## Jak modyfikować styl wykresu?



