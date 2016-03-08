## Estymacja parametrów rozkładu

Do oceny parametrów metodą największej funkcji wiarogodności w określonej rodzinie rozkładów służy funkcja `MASS::fitdistr()`. 
Estymowane mogą być parametry dla szerokiej klasy rozkładów, praktycznie wszystkich wymienionych w tabeli powyżej. Pierwszym argumentem funkcji `fitdistr()` jest wektor obserwacji, na bazie którego wykonana będzie estymacja. Drugim argumentem powinna być nazwa rozkładu, a trzecim argumentem lista z początkowymi ocenami parametrów rozkładu. Trzeci argument nie jest wymagany dla rozkładu wykładniczego, normalnego, log-normalnego i Poissona, dla tych rozkładów funkcja `fitdistr()` ma wbudowane metody inicjalizacji.
Poniżej przedstawiamy przykład wywołania tej funkcji. Poza ocenami parametrów wyznaczany jest też błąd standardowy tych ocen (przedstawiony w nawiasach).


Wylosujmy 100 obserwacji z rozkładu log-normalnego.

```r
wek <- rlnorm(100)
```

Sprawdzamy jak wyglądają oceny parametrów w rodzinie rozkładów normalnych (tu nie ma dobrych odpowiedzi, ale to tylko ćwiczenie).


```r
fitdistr(wek, "normal")
```

```
##      mean         sd    
##   1.6698846   2.1792353 
##  (0.2179235) (0.1540952)
```

A teraz wyznaczamy oceny w rodzinie rozkładów gamma.


```r
fitdistr(wek, "gamma", list(shape=3, rate=3))
```

```
##      shape       rate   
##   1.0846942   0.6495628 
##  (0.1360306) (0.1025949)
```

