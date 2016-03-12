# Jak wyznaczać agregaty / statystyki w grupach?

Częstą operacją, którą wykonuje się na danych, szczególnie tych dużych, jest wyznaczanie statystyk / podsumowań / agregatów dla podgrup danych.

Aby takie agregaty wyznaczać z pakietem `dplyr` możemy wykorzystać funkcje `summarise()` i `groupby()`. Pierwsza określa jakie statystyki chcemy policzyć, druga określa w jakich grupach.

Przedstawimy te funkcje poniżej jedna po drugiej.

## Jak wyznaczać agregaty?

Funkcją `summarise()` można wyznaczyć agregaty w danych.

Przykładowo, poniższa instrukcja dla zbioru danych `auta2012` liczy średnią cenę, pierwiastek z wariancji ceny i medianę przebiegu aut.


```r
library(dplyr)
library(PogromcyDanych)

auta2012 %>%
  summarise(sredniaCena = mean(Cena.w.PLN),
            sdCena = sqrt(var(Cena.w.PLN)),
            medianaPrzebiegu = median(Przebieg.w.km, na.rm=TRUE))
```

```
##   sredniaCena   sdCena medianaPrzebiegu
## 1    35755.11 70399.67           140000
```

Nie zawsze agregat związany jest z przekształceniem wartości w jakiejś kolumnie.
Przykładowo, dosyć przydatną statystyką jest liczba wierszy, która nie zależy od wartości w danych. Taki agregat można wyznaczyć funkcją `n()`.

Wyznaczając agregaty możemy składać funkcje. Przykładowo składając `mean()` i `grepl()` możemy policzyć procent aut z określonym elementem wyposażenia. 


```r
auta2012 %>%
  summarise(liczba.aut.z.klimatyzacja = sum(grepl("klimatyzacja", Wyposazenie.dodatkowe)),
            procent.aut.z.klimatyzacja = 100*mean(grepl("klimatyzacja", Wyposazenie.dodatkowe)),
            procent.aut.z.automatem = 100*mean(Skrzynia.biegow == "automatyczna"),
            liczba.aut = n())
```

```
##   liczba.aut.z.klimatyzacja procent.aut.z.klimatyzacja
## 1                    162960                   78.49635
##   procent.aut.z.automatem liczba.aut
## 1                16.32354     207602
```

## Grupowanie

Funkcja `group_by()` pozwala określić w jakich grupach mają być liczone agregaty wyznaczane przez funkcję `summarise()`.

Sama funkcja nie powoduje żadnego przetwarzania, a jedynie dodaje znacznik określający co jest teraz zmienną grupującą. Kolejne funkcje w potoku (tj. `summarise()`) będą dzięki temu znacznikowi wiedziały, że statystyki należy wyznaczać w grupach.

Poniższy przykład liczy trzy statystyki (medianę ceny, przebiegu i liczbę wierszy) dla poszczególnych typów paliwa.


```r
auta2012 %>%
  filter(Marka == "Volkswagen", Rok.produkcji == 2007) %>%
  group_by(Rodzaj.paliwa) %>%
  summarise(medianaCeny = median(Cena.w.PLN, na.rm=TRUE),
            medianaPrzebieg = median(Przebieg.w.km, na.rm=TRUE),
            liczba = n())
```

```
## Source: local data frame [3 x 4]
## 
##            Rodzaj.paliwa medianaCeny medianaPrzebieg liczba
##                   (fctr)       (dbl)           (dbl)  (int)
## 1                benzyna     33550.0           67000    190
## 2            benzyna+LPG     34048.9           95000      7
## 3 olej napedowy (diesel)     38900.0          145000   1482
```

Agregaty są zwykłą ramką danych, można wykonywać na nich kolejne operacje, np. sortowanie.


```r
auta2012 %>%
  filter(Marka == "Volkswagen", Rok.produkcji == 2007) %>%
  group_by(Rodzaj.paliwa) %>%
  summarise(medianaCeny = median(Cena.w.PLN, na.rm=TRUE),
            medianaPrzebieg = median(Przebieg.w.km, na.rm=TRUE),
            liczba = n()) %>%
  arrange(liczba)
```

```
## Source: local data frame [3 x 4]
## 
##            Rodzaj.paliwa medianaCeny medianaPrzebieg liczba
##                   (fctr)       (dbl)           (dbl)  (int)
## 1            benzyna+LPG     34048.9           95000      7
## 2                benzyna     33550.0           67000    190
## 3 olej napedowy (diesel)     38900.0          145000   1482
```

## Grupowanie po dwóch zmiennych

Grupować można po dwóch lub większej liczbie zmiennych.
W tym przypadku agregaty liczone są dla każdej występującej w danych kombinacji zmiennych grupujących.

Jeżeli jakaś kombinacja grup w danych nie występuje (np. `Model = Beetle` i `Rodzaj.paliwa = benzyna+LPG`) to nie pojawi się też w agregatach.


```r
auta2012 %>%
  filter(Rok.produkcji == 2007, Marka == "Volkswagen") %>%
  group_by(Model, Rodzaj.paliwa) %>%
  summarise(medianaCeny = median(Cena.w.PLN, na.rm=TRUE),
            medianaPrzebieg = median(Przebieg.w.km, na.rm=TRUE),
            liczba = n()) 
```

```
## Source: local data frame [35 x 5]
## Groups: Model [?]
## 
##        Model          Rodzaj.paliwa medianaCeny medianaPrzebieg liczba
##       (fctr)                 (fctr)       (dbl)           (dbl)  (int)
## 1     Beetle                benzyna     39000.0         30000.0      1
## 2      Caddy                benzyna     27900.0        170000.0      2
## 3      Caddy olej napedowy (diesel)     30813.0        126905.5     49
## 4  Caravelle olej napedowy (diesel)     65900.0        170000.0      9
## 5        Eos                benzyna     53445.0         53000.0      6
## 6        Eos olej napedowy (diesel)     64900.0         62000.0      7
## 7        Fox                benzyna     15227.9         69000.0     11
## 8        Fox olej napedowy (diesel)     17000.0        137000.0      7
## 9       Golf                benzyna     35900.0         70500.0     37
## 10      Golf            benzyna+LPG     31650.0         99500.0      4
## ..       ...                    ...         ...             ...    ...
```

