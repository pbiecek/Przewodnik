# Jak sortować wiersze?

Sortowanie danych po określonej kolumnie znacznie ułatwia analizę wartości w tej kolumnie. 
Przede wszystkim natychmiast widać wartości skrajne, sortowanie jest więc wygodne podczas eksploracji danych.

Funkcją `arrange()` z pakietu `dplyr` możemy wykonać sortowanie po jednej lub większej liczbie zmiennych. W przypadku remisów ze względu na pierwsze kryteria, porządek rozstrzygają kolejne kryteria.

W przykładzie poniżej w pierwszej kolejności dane są sortowane po wartościach z kolumny `Model`. Dopiero w przypadku, gdy w tej kolumnie znajdują się takie same wartości, ich kolejność jest rozstrzygana przez kolejną zmienną, cena w PLN.


```r
library(dplyr)
library(PogromcyDanych)

posortowaneAuta <- arrange(auta2012, Model, Cena.w.PLN)

head(select(posortowaneAuta, Model, Marka, Cena.w.PLN, Cena, Waluta))
```

```
##   Model Marka Cena.w.PLN Cena Waluta
## 1                   1600 1600    PLN
## 2                   2600 2600    PLN
## 3                   5800 5800    PLN
## 4                   6000 6000    PLN
## 5                   6499 6499    PLN
## 6                   7300 7300    PLN
```

