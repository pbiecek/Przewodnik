# Jak tworzyć wykresy z pakietem ggplot2?

Pakiet `ggplot2` jest jednym z najbardziej zaawansowanych narzędzi do tworzenia wykresów statystycznych. Zaawansowanie nie oznacza, że można szybko zrobić w nim wykres, ani też, że dostępnych jest wiele szablonów wykresów. Oznacza, że konstrukcja pakietu jest na tyle elastyczna, że można z nim wykonać praktycznie każdą grafikę statystyczną.

Tę elastyczność uzyskuje się opierając strukturę wykresu na sposobie w jaki myślimy i czytamy wykresy. Patrząc na wykres nie widzimy w nim zbioru odcinków i kółek, ale kolekcje obiektów na swój sposób podobnych lub różnych. Tworząc wykres nie powinniśmy więc myśleć o tym gdzie i jak narysować odcinek, ale o tym jak elementy wykresu mają reprezentować dane.

Gramatyka grafiki jest szerzej opisana [w tym eseju](http://biecek.pl/Eseje/indexGramatyka.html).

Poniższe przykłady oparte są o zbiór danych `countries` ze współczynnikami dzietności / umieralności dla różnych krajów.


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
