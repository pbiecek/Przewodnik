# Jak badać właściwości jednej zmiennej?

## Jak weryfikować właściwości zmiennej ilościowej?

W rozdziale o eksploracji jednej zmiennej pokazaliśmy jak wyznaczać rozmaite charakterystyki danych.

Czasem jednak, nie interesuje nas ocena tych charakterystyk, ale chcemy sprawdzić czy istotnie różnią się one od zadanej wartości.

Do weryfikacji służą testy statystyczne, poniżej przedstawimy kilka wybranych.

### Czy ta średnia jest różna od $$\mu_0$$?

W próbie prostej z rozkładu normalnego, w której nieznana jest wariancja (najczęstsza sytuacja), do weryfikacji hipotezy zerowej dotyczącej parametru średniej

$$
H_0: \mu = \mu_0
$$

przeciwko alternatywie jedno, lub dwustronnej, wykorzystuje się najczęściej tzw. test t-studenta dla jednej próby (zobacz np. https://en.wikipedia.org/wiki/Student%27s_t-test#One-sample_t-test).

Statystyka testowa dla tego testu to 
$$
t = \frac{\bar{x} - \mu_0}{s/\sqrt{n}},
$$
a rozkład statystyki dla prawdziwej hipotezy zerowej to rozkład t z n-1 stopniami swobody.

Przykładowo, sprawdźmy, czy wiek posłów różni się od średniej w populacji. Bierne prawo wyborcze przysługuje w Polsce od 21 roku życia. Uwzględniając strukturę populacji średnia wiek osób w wieku powyżej 21 roku życia to około 50 lat (TODO: wylicz dokładniej).

Sprawdzimy więc, czy średni wiek posłów różni się istotnie od średniego wieku w populacji osób, którym przysługuje bierne prawo wyborcze. Wykorzystamy do tego funkcję `t.test()` z argumentem `mu`. Argumentem `alternative` można określić alternatywę.


```r
poslowie <- archivist::aread("pbiecek/Przewodnik/arepo/2977e638f6d6b9d504c10fc29d779d42")

t.test(poslowie$Wiek, mu = 50)
```

```
## 
## 	One Sample t-test
## 
## data:  poslowie$Wiek
## t = 0.92843, df = 459, p-value = 0.3537
## alternative hypothesis: true mean is not equal to 50
## 95 percent confidence interval:
##  49.46705 51.48751
## sample estimates:
## mean of x 
##  50.47728
```

### Czy ta mediana jest różna od $$m_0$$?

Jeżeli założenie o rozkładzie normalnym jest nie do przyjęcia, to popularną alternatywą dla testu t jest test dla mediany.

$$
H_0: m = m_0
$$

Za statystykę testową wykorzystuje częstość obserwacji w próbie większych niż $$m_0$$. Zauważmy, że jest on równoważny testowi weryfikującemu strukturę zmiennej binarnej, czy $$P(x>m_0) \neq 0.5$$.

Podobnie jak w poprzednim punkcie, sprawdzimy , czy średni wiek posłów różni się istotnie od średniego wieku w populacji osób, którym przysługuje bierne prawo wyborcze. 


```r
prop.test( x = sum(poslowie$Wiek > 50),
           n = length(poslowie$Wiek),
           p = 0.5)
```

```
## 
## 	1-sample proportions test with continuity correction
## 
## data:  sum(poslowie$Wiek > 50) out of length(poslowie$Wiek), null probability 0.5
## X-squared = 5.2196, df = 1, p-value = 0.02233
## alternative hypothesis: true p is not equal to 0.5
## 95 percent confidence interval:
##  0.5075742 0.6001998
## sample estimates:
##         p 
## 0.5543478
```


### Czy wariancja jest różna od $$\sigma^2$$?

Testować można też inne parametry rozkładu, np. wariancje.

$$
H_0: \sigma^2 = \sigma^2_0
$$

Za statystykę testową wykorzystuje się przeskalowany iloraz próbkowej i weryfikowanej wariancji. 
$$
t = (n-1) s^2/\sigma_0^2
$$
Przy prawdziwej hipotezie zerowej ma on rozkład $$\chi^2$$ z n-1 stopniami swobody.


```r
library(PairedData)

var.test(poslowie$Wiek, ratio=100)
```

```
## 
## 	One-sample variance test
## 
## data:  x
## X-squared = 557.98, df = 459, p-value = 0.002074
## alternative hypothesis: true variance is not equal to 100
## 95 percent confidence interval:
##  107.2517 138.9632
## sample estimates:
## variance 
## 121.5648
```

## Jak weryfikować wskaźniki struktury zmiennej binarnej?


### Czy ta częstość jest różna od $$p_0$$?

Zmienne jakościowe charakteryzuje się za pomocą częstości występowania poszczególnych wartości.

Również z punktu widzenia weryfikacji, interesujące są te częstości występowania. Typowa hipoteza zerowa, weryfikuje, czy częstość występowania wyróżnionego poziomu różni się od $$p_0$$.

$$
H_0: p = p_0
$$

Statystyką testową jest liczba wystąpień wyróżnionego poziomu, która przy prawdziwej hipotezie zerowej ma rozkład dwumianowy z parametrem $$p_0$$.

Wykorzystajmy ten test aby zweryfikować, czy częstość kobiet w Sejmie istotnie odbiega od częstości kobiet w populacji (nieznacznie ponad 0.5). Wykorzystamy do tego funkcję `binom.test()`, wykonującą dokładny test dwumianowy (często wykorzystywana funkcja `prop.test()` wykorzystuje rozkład asymptotyczny).

Informacji o płci nie mamy, musimy ją wyznaczyć na podstawie ostatniej litery imienia.


```r
poslowie$Kobieta <- grepl(gsub(poslowie$ImieNazwisko, pattern=" .*$", replacement = ""), pattern = "a$")
poslowie$Kobieta <- ifelse(poslowie$Kobieta, "Kobieta", "Mężczyzna")

table(poslowie$Kobieta)
```

```
## 
##   Kobieta Mężczyzna 
##       125       335
```

```r
binom.test(x = sum(poslowie$Kobieta == "Kobieta"),
           n = length(poslowie$Kobieta),
          p = 0.5)
```

```
## 
## 	Exact binomial test
## 
## data:  sum(poslowie$Kobieta == "Kobieta") and length(poslowie$Kobieta)
## number of successes = 125, number of trials = 460, p-value <
## 2.2e-16
## alternative hypothesis: true probability of success is not equal to 0.5
## 95 percent confidence interval:
##  0.2315798 0.3148618
## sample estimates:
## probability of success 
##              0.2717391
```



## Jak weryfikować zgodność z rozkładem?




