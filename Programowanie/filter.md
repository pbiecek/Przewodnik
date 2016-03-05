# Jak filtrować wiersze?

Jedną z najczęstszych operacji na danych jest filtrowanie wierszy, które spełniają określony warunek / warunki.

Funkcja `filter()` pakietu `dplyr` wykonuje filtrowanie. Jej pierwszym argumentem jest zbiór danych na których ma pracować, a kolejne argumenty to warunki logiczne. 

Wynikiem tej funkcji są wiersze spełniające wszystkie określone warunki logiczne. Określając warunki można wykorzystywać nazwy kolumn ze zbioru danych bez podawania dodatkowych odnośników.

Przykładowo, instrukcja które ze zbioru danych `auta2012` wybierze tylko oferty ze wskazanym polem `Marka == "Porsche"`.


```r
tmp <- filter(auta2012,
        Marka == "Porsche")
```

```
## Error in as.ts(x): object 'auta2012' not found
```

```r
head(tmp)
```

```
## Error in head(tmp): object 'tmp' not found
```

Możemy określać jednocześnie więcej warunków. Poniższy przykład jako wynik zbuduje zbiór danych marki `Porsche` z silnikami przekraczającymi 300 KM.


```r
tylkoPorscheZDuzymSilnikiem <- filter(auta2012,
         Marka == "Porsche",
         KM > 300)
```

```
## Error in match.arg(method): object 'KM' not found
```

```r
head(tylkoPorscheZDuzymSilnikiem)
```

```
## Error in head(tylkoPorscheZDuzymSilnikiem): object 'tylkoPorscheZDuzymSilnikiem' not found
```

