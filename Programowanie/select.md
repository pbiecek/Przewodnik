# Jak wybierać kolumny?

Dane potrafią zawierać dużą liczbę kolumn. Ale często pracujemy tylko na kilku z nich. Usunięcie pozostałych spowoduje, że dane będą mniejsze i operacje na nich będą szybsze.

Inną zaletą wybierania jedynie potrzebnych kolumn jest łatwiejsze wyświetlanie danych. Zamiast pokazywać wszystkie, nawet nieistotne kolumny, często lepiej pokazać jedynie te istotne.

Funkcja `select()` z pakietu `dplyr` pozwala na wybór jednej lub wielu zmiennych ze źródła danych. Pierwszym argumentem jest źródło danych a kolejnymi są nazwy kolumn, które mają być wybrane.
Przykładowo, poniższa instrukcja wybiera jedynie wiek auta i rok produkcji.


```r
library(dplyr)
library(PogromcyDanych)

tmp <- select(auta2012, Rodzaj.paliwa, Rok.produkcji)
head(tmp)
```

```
##            Rodzaj.paliwa Rok.produkcji
## 1 olej napedowy (diesel)          2008
## 2 olej napedowy (diesel)          2008
## 3 olej napedowy (diesel)          2009
## 4 olej napedowy (diesel)          2003
## 5 olej napedowy (diesel)          2007
## 6 olej napedowy (diesel)          2004
```

Poza wskazywaniem wszystkich kolumn przez nazwę można również korzystać z operatora negacji `-` (wszystkie kolumny poza wskazanymi) lub z funkcji `matches()`, `starts_with()`, `ends_with()` pozwalających na definiowanie grup nazw kolumn spełniających określone warunki


```r
tmp <- select(auta2012, starts_with("Cena"))
head(tmp)
```

```
##    Cena Cena.w.PLN
## 1 49900      49900
## 2 88000      88000
## 3 86000      86000
## 4 25900      25900
## 5 55900      55900
## 6 45900      45900
```


