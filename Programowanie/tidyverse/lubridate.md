## Pakiet lubridate, czyli jak pracować z datami

### Data

Pakiet `lubridate` posiada funkcje pozwalające na łatwe konwertowanie napisów z datami na obiekty klasy `Date`.

Jeżeli konwertujemy datę, wystarczy wskazać kolejność w jakiej występuje w dacie rok (y), miesiąc (m) i dzień (d).


```r
library("lubridate")

ymd("20170101")
```

```
## [1] "2017-01-01"
```

```r
mdy("01-01-2017")
```

```
## [1] "2017-01-01"
```

```r
dmy("01/01/2017")
```

```
## [1] "2017-01-01"
```

### Czas

Podobnie w przypadku gdy wczytujemy datę razem z godziną/minutą/sekundą. Do parsowania takich obiektów można wykorzystać funkcje z sufiksem `hms` lub `hm` lub tylko `h` (w zależności od tego czy w napisie jest tylko godzina, czy też minuta/sekunda).


```r
(obiad <- ymd_hms("2017-01-01 12:58:01", tz="CET"))
```

```
## [1] "2017-01-01 12:58:01 CET"
```

```r
(kolacja <- ymd_hms("2017-01-01 19:31:55", tz="CET"))
```

```
## [1] "2017-01-01 19:31:55 CET"
```

### Cechy daty

Z dat można wyłuskiwać informację o tym który to dzień roku, który tydzień roku lub który dzień tygodnia.


```r
wday(obiad)
```

```
## [1] 1
```

```r
wday(obiad, label = TRUE)
```

```
## [1] Sun
## Levels: Sun < Mon < Tues < Wed < Thurs < Fri < Sat
```

### Arytmetyka na datach

Daty można odejmować od siebie, można do nich dodawać określoną liczbę godzin, dni, tygodni.


```r
kolacja - obiad
```

```
## Time difference of 6.565 hours
```

```r
obiad + days(3) + minutes(5)
```

```
## [1] "2017-01-04 13:03:01 CET"
```

```r
obiad + weeks(1:10)
```

```
##  [1] "2017-01-08 12:58:01 CET" "2017-01-15 12:58:01 CET"
##  [3] "2017-01-22 12:58:01 CET" "2017-01-29 12:58:01 CET"
##  [5] "2017-02-05 12:58:01 CET" "2017-02-12 12:58:01 CET"
##  [7] "2017-02-19 12:58:01 CET" "2017-02-26 12:58:01 CET"
##  [9] "2017-03-05 12:58:01 CET" "2017-03-12 12:58:01 CET"
```

### Przedziały

Z dat można budować przedziały, na których również można wykonywać proste operacje arytmetyczne.


```r
glod <- interval(obiad, kolacja)

glod %/% hours(1)
```

```
## [1] 6
```

### Więcej informacji 

[Dates and Times Made Easy with lubridate](https://www.jstatsoft.org/article/view/v040i03)

