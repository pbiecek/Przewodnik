# Jak badać zależności pomiędzy parą zmiennych?

Testów weryfikujących strukturę zależności pomiędzy parą zmiennych jest co niemiara. 
W języku polskim całkiem bogata kolekcja testów jest przedstawiona w książce Ryszarda Magiery ,,Modele i metody statystyki Matematycznej''.

Zamiast jednak opisywać wszystkie testy statystyczne (co jest niemożliwe) poniżej skupimy się na przedstawieniu tych najbardziej popularnych / najbardziej istotnych.

## Jak weryfikować niezależność dwóch zmiennych jakościowych?

**Model**: Przyjmijmy, że obserwujemy dwuwymiarową zmienną losową $$(X,Y)$$. $$X$$ przyjmuje wartości ze zbioru $$(x_1, ..., x_r)$$ a $$Y$$ przyjmuje wartości ze zbioru $$(y_1, ..., y_s)$$. 

Brzegowy rozkład zmiennej X określmy jako $$P(X = x_i) = p_{i.}$$ a zmiennej $$Y$$ jako $$P(Y = Y_j) = p_{.j}$$.
Łączny rozkład zmiennych $$(X,Y)$$ określimy jako $$P(X=x_i, Y=y_j) = p_{ij}$$.

**Hipoteza**: Określmy hipotezę zerową (niezależności), dla każdego $$i,j$$

$$
H_0: p_{ij} = p_{i.}p_{.j}
$$

Hipoteza alternatywna jest taka, że dla dowolnego $$i,j$$ ta równość nie zachodzi.


**Statystyka testowa**:

Statystyka testowa jest oparta o tablicę kontyngencji

|   | $$x_1$$ | $$x_2$$ |   | $$x_s$$ |
|---|---|---|---|---|
| $$y_1$$ | $$n_{11}$$ | $$n_{12}$$ | ... | $$n_{1s}$$ |
|   |  ... |   |   | ...  |
| $$y_r$$ | $$n_{r1}$$ | $$n_{r2}$$ | ... | $$n_{rs}$$ |


Ta tablica opisuje obserwowane w danych liczebności wystąpienia poszczególnych kombinacji wartości. Statystyka testowa porównuje te wartości z wartościami oczekiwanymi, przy założeniu prawdziwej hipotezy zerowej.

Zazwyczaj statystyka testowa w teście $$\chi^2$$ ma postać

$$
T = \sum_i \frac{(O_i - E_i)^2}{E_i}
$$

gdzie $$O$$ oznacza obserwowane liczebności, $$E$$ oczekiwane liczebności. 

Ta generyczna postać statystyki testowej, w tym konkretnym przypadku przyjmuje postać

$$
T = \sum_{i=1}^r \sum_{j=1}^s \frac{(n_{ij} - n_{i.}n_{.j}/n)^2}{n_{i.}n_{.j}/n}
$$


Ta statystyka testowa ma asymptotyczny rozkład $$\chi^2_{(r-1)(s-1)}$$.

Obszar odrzucenia jest najczęściej postaci $$[c, \infy]$$.

### Przykład

Rozważmy następującą tabelę liczebności. Opisuje ona występowanie różnych klas słów w różnych kadencjach Sejmu i Senatu.


```r
tab <- archivist::aread("pbiecek/Przewodnik/arepo/a3666b4084daa5db9251dc36e3286298")

tab
```

```
##         Sejm.I Sejm.II Sejm.III Sejm.IV Senat.II Senat.III Senat.IV
## adj    1024585 2860670  3105710 2418792   168513    533630  1006341
## adja      6343   11840     9709    9736      557      1834     2634
## adjp      3629    7926     8694    6550      595      2089     3816
## adv     157809  440723   480886  365356    28312     93336   162407
## aglt     34185   92739   107769   76358     6980     22453    37352
## bedzie   29057   79289    94534   82294     4855     16677    30702
## conj    266817  748578   843214  636675    47561    153433   285330
## depr     15025   39543    42896   34505     2105      6468    10929
## fin     430583 1159721  1329316 1042782    84210    264547   489205
## ger      25693   73680    74717   59390     4757     19149    36195
## ign     161108  403124   491159  395459    53843    150962   266662
## imps     12604   34062    36535   27918     1856      5582     9637
## impt     25546   69211    78764   59248     4554     14709    24513
## inf     125174  338322   372703  288808    22824     65253   109382
## interp     114     363      426     307    16682     54769    37473
## num      28279   73630    82055   59864     5346     17146    42238
## pact     50779  157181   167006  133150     8645     25637    52477
## pant       321     874     1035     797       43       185      332
## pcon     15249   41843    44303   34955     2353      6588    11911
## ppas    102684  305969   324264  256864    17487     59248   116860
## praet   170363  487832   562794  423838    32460    107166   204104
## pred     23772   60856    66753   49170     3940     11319    19492
## prep    103128  277207   300368  235394    17629     56216   106826
## qub     400309 1049368  1166979  903815    73178    230700   397547
## siebie    6399   15059    16918   13645     1185      3873     5921
## subst  2370523 6711350  7419553 5857298   392646   1242956  2341349
## winien   11847   30263    29070   19225     2031      5646     8347
##        Senat.V
## adj     514808
## adja      1475
## adjp      2178
## adv      86916
## aglt     18742
## bedzie   15630
## conj    141489
## depr      5987
## fin     244348
## ger      14624
## ign     155049
## imps      4902
## impt     10895
## inf      56425
## interp   41271
## num      22308
## pact     28757
## pant       185
## pcon      6148
## ppas     61925
## praet   102894
## pred      9384
## prep     53229
## qub     197916
## siebie    2874
## subst  1236893
## winien    3897
```

Aby przeprowadzić test $$\chi^2$$ można wykorzystać funkcję `chisq.test()`. Wyznacza ona zarówno macierz oczekiwanych częstości, statystykę testową jak i wartość p.


```r
wynik <- chisq.test(tab)

wynik$p.value
```

```
## [1] 0
```

```r
wynik$statistic
```

```
## X-squared 
##  940523.3
```

```r
wynik$expected
```

```
##              Sejm.I      Sejm.II    Sejm.III      Sejm.IV     Senat.II
## adj    1003173.3964 2788440.8776 3090526.362 2416135.3600 179998.25593
## adja      3805.3683   10577.4779   11723.388    9165.2000    682.79288
## adjp      3059.3512    8503.8339    9425.096    7368.4237    548.93589
## adv     156580.3667  435233.9255  482384.952  377122.6012  28095.03624
## aglt     34198.8157   95059.7136  105357.999   82367.5830   6136.25442
## bedzie   30444.1535   84623.1792   93790.824   73324.5081   5462.55967
## conj    269319.5760  748606.0911  829706.263  648654.1142  48323.70371
## depr     13578.3557   37742.6695   41831.518   32703.3645   2436.34884
## fin     435029.6187 1209217.0467 1340217.463 1047765.4693  78056.86727
## ger      26577.9897   73876.7129   81880.140   64012.8825   4768.85832
## ign     179141.1956  497944.4574  551889.224  431460.1828  32143.09997
## imps     11477.5040   31903.1001   35359.320   27643.4795   2059.39542
## impt     24787.3245   68899.3441   76363.548   59700.0793   4447.56131
## inf     118908.3591  330520.0580  366326.918  286389.8624  21335.59096
## interp   13056.3765   36291.7659   40223.431   31446.1818   2342.69072
## num      28532.1560   79308.5527   87900.437   68719.4769   5119.49214
## pact     53778.7670  149484.5385  165678.932  129525.7440   9649.46269
## pant       325.2776     904.1481    1002.099     783.4285     58.36418
## pcon     14086.4510   39154.9814   43396.833   33927.1081   2527.51580
## ppas    107388.2551  298498.5461  330836.358  258643.7812  19268.55187
## praet   180355.8124  501320.6307  555631.155  434385.5781  32361.03728
## pred     21100.4429   58651.2138   65005.188   50820.2533   3786.02834
## prep     99169.7358  275654.1852  305517.156  238849.5411  17793.91236
## qub     381141.5060 1059428.5687 1174201.664  917976.3670  68387.78480
## siebie    5680.6298   15789.9923   17500.600   13681.7528   1019.26890
## subst  2377714.2766 6609142.2559 7325143.069 5726706.4303 426630.55504
## winien    9513.9381   26445.1330   29310.064   22914.2463   1707.07504
##           Senat.III     Senat.IV      Senat.V
## adj     567953.9894 1042222.2914  544598.4677
## adja      2154.4372    3953.4936    2065.8420
## adjp      1732.0742    3178.4376    1660.8475
## adv      88649.1251  162675.3154   85003.6774
## aglt     19361.9108   35530.0173   18565.7063
## bedzie   17236.1812   31629.2034   16527.3914
## conj    152477.2569  279802.9400  146207.0555
## depr      7687.4858   14106.8982    7371.3594
## fin     246295.2151  451963.3073  236167.0122
## ger      15047.3242   27612.5478   14428.5450
## ign     101422.1041  186114.3328   97251.4034
## imps      6498.0732   11924.2701    6230.8581
## impt     14033.5259   25752.1803   13456.4364
## inf      67320.8412  123536.9109   64552.4596
## interp    7391.9635   13564.6008    7087.9897
## num      16153.6898   29642.7807   15489.4144
## pact     30447.2441   55872.1254   29195.1862
## pant       184.1583     337.9391     176.5853
## pcon      7975.1477   14634.7713    7647.1920
## ppas     60798.6497  111568.3826   58298.4750
## praet   102109.7684  187376.2290   97910.7893
## pred     11946.1708   21921.7854   11454.9179
## prep     56145.6746  103029.9544   53836.8405
## qub     215786.0641  395977.5799  206912.4649
## siebie    3216.1303    5901.7504    3083.8759
## subst  1346160.4084 2470267.6832 1290803.3211
## winien    5386.3860    9884.2717    5164.8859
```

```r
wynik$observed
```

```
##         Sejm.I Sejm.II Sejm.III Sejm.IV Senat.II Senat.III Senat.IV
## adj    1024585 2860670  3105710 2418792   168513    533630  1006341
## adja      6343   11840     9709    9736      557      1834     2634
## adjp      3629    7926     8694    6550      595      2089     3816
## adv     157809  440723   480886  365356    28312     93336   162407
## aglt     34185   92739   107769   76358     6980     22453    37352
## bedzie   29057   79289    94534   82294     4855     16677    30702
## conj    266817  748578   843214  636675    47561    153433   285330
## depr     15025   39543    42896   34505     2105      6468    10929
## fin     430583 1159721  1329316 1042782    84210    264547   489205
## ger      25693   73680    74717   59390     4757     19149    36195
## ign     161108  403124   491159  395459    53843    150962   266662
## imps     12604   34062    36535   27918     1856      5582     9637
## impt     25546   69211    78764   59248     4554     14709    24513
## inf     125174  338322   372703  288808    22824     65253   109382
## interp     114     363      426     307    16682     54769    37473
## num      28279   73630    82055   59864     5346     17146    42238
## pact     50779  157181   167006  133150     8645     25637    52477
## pant       321     874     1035     797       43       185      332
## pcon     15249   41843    44303   34955     2353      6588    11911
## ppas    102684  305969   324264  256864    17487     59248   116860
## praet   170363  487832   562794  423838    32460    107166   204104
## pred     23772   60856    66753   49170     3940     11319    19492
## prep    103128  277207   300368  235394    17629     56216   106826
## qub     400309 1049368  1166979  903815    73178    230700   397547
## siebie    6399   15059    16918   13645     1185      3873     5921
## subst  2370523 6711350  7419553 5857298   392646   1242956  2341349
## winien   11847   30263    29070   19225     2031      5646     8347
##        Senat.V
## adj     514808
## adja      1475
## adjp      2178
## adv      86916
## aglt     18742
## bedzie   15630
## conj    141489
## depr      5987
## fin     244348
## ger      14624
## ign     155049
## imps      4902
## impt     10895
## inf      56425
## interp   41271
## num      22308
## pact     28757
## pant       185
## pcon      6148
## ppas     61925
## praet   102894
## pred      9384
## prep     53229
## qub     197916
## siebie    2874
## subst  1236893
## winien    3897
```

## Jak weryfikować niezależność dwóch zmiennych binarnych?

Specyficzną wersją testu na niezależność dwóch zmiennych jakościowych jest test dla dwóch zmiennych binarnych. 
Zamiast wykorzystywać w tym przypadku asymptotyczny rozkład statystyki testowej można badań dokładny rozkład statystyki testowej. Stąd też nazwa testu - dokładny test Fishera.

Statystyka testowa jest oparta o tablicę kontyngencji

|   | $$x_1$$ | $$x_2$$ |
|---|---|---|
| $$y_1$$ | $$n_{11}$$ | $$n_{12}$$ | 
| $$y_2$$ | $$n_{21}$$ | $$n_{22}$$ | 

o rozkładzie hipotergeometrycznym.

### Przykład

Sprawdźmy czy jest zależność pomiędzy marką auta (Audi / Volkswagen) a kolorem auta (metalik / nie metalik).


```r
library(SmaterPoland)
```

```
## Error in library(SmaterPoland): there is no package called 'SmaterPoland'
```

```r
library(dplyr)

av <- auta2012 %>% 
  filter(Marka %in% c("Audi", "Volkswagen")) %>%
  mutate(metallic = grepl(Kolor, pattern="metallic"))


tab <- table(factor(av$Marka), av$metallic)
  
fisher.test(tab)
```

```
## 
## 	Fisher's Exact Test for Count Data
## 
## data:  tab
## p-value < 2.2e-16
## alternative hypothesis: true odds ratio is not equal to 1
## 95 percent confidence interval:
##  0.6849883 0.7543595
## sample estimates:
## odds ratio 
##  0.7188752
```

## Jak weryfikować niezależność dwóch zmiennych ilościowych?

### Dwuwymiarowy rozkład normalny

**Model**: Przyjmijmy, że obserwujemy dwuwymiarową zmienną losową z dwuwymiarowego rozkładu normalnego $$(X,Y) \sim \mathcal N(\mu, \Sigma)$$. 

**Hipoteza**: 

$$
H_0: \sigma_{12} = 0.
$$
$$
H_A: \sigma_{12} <> 0.
$$

**Statystyka testowa**:

Statystyka testowa oparta jest o współczynnik korelacji 

$$
\rho = \frac{\sum_i (x_{i} - \bar x)(y_i - \bar(y))}{\sqrt{\sum_i (x_{i} - \bar x)^2\sum_i (y_{i} - \bar y)^2}}
$$

Stosowane jest następujące przekształcenie

$$
T = \sqrt{n-2}\frac{\rho}{\sqrt{1 = \rho^2}},
$$

po takim przekształceniu statystyka $$T$$ ma rozkład $$t_{n-2}$$ i w oparciu o niego konstruowany jest obszar krytyczny.


Czasem weryfikowana jest też inna hipoteza zerowa.

**Hipoteza**: 

$$
H_0: \sigma_{12} = \rho_0.
$$
$$
H_A: \sigma_{12} <> \rho_0.
$$

**Statystyka testowa**:

W tym przypadku stosuje się inną transformację, tzw. transformację Fishera.

$$
U = 1/2 \ln(\frac{1+\rho}{1-\rho}).
$$

Przy prawdziwej hipotezie zerowej ta statystyka ma asymptotycznie rozkład normalny $$\mathcal N (1/2\ln(\frac{1+\rho_0}{1-\rho_0}) + \rho_0/(2(n-1)), 1/(n-2))$$

### Korelacja rang

Założenie o dwuwymiarowym rozkładzie normalnym jest silnie ograniczające. 
Dlatego często stosowanym testem dla zbioru hipotez jest test korelacji Spearmana.

**Model**: Przyjmijmy, że obserwujemy dwuwymiarową zmienną losową $$(X,Y)$$. 

Oznaczmy dodatkowo $$r_i = rank(X_i)$$, $$s_i = rank(Y_i)$$.

**Hipoteza**: 

$$
H_0: cor(r_i, s_i) = 0.
$$
$$
H_A: cor(r_i, s_i) <> 0.
$$

**Statystyka testowa**:

Statystyką testowa jest korelacja Pearsona ale liczona dla rang a nie oryginalnych obserwacji. 

$$
\rho = \frac{\sum_i (r_{i} - (n+1)/2)(s_i - (n+1)/2)}{\sqrt{\sum_i (r_{i} - (n+1)/2)^2\sum_i (s_{i} - (n+1)/2)^2}}
$$

Po prostych przekształceniach otrzymujemy

$$
\rho = 1 - \frac{6 \sum(r_i - s_i)^2}{n(n^2-1)}.
$$

Rozkład tej statystyki można tablicować dla małych n. Asymptotycznie ma ona rozkład normalny z wariancją $$1/(n-1)$$.
Ale w implementacji najczęściej stosuje się podobną transformację co w przypadku testu Pearsona, czyli

$$
T = \sqrt{n-2}\frac{\rho}{\sqrt{1-\rho^2}}.
$$

Asymptotycznie ta statystyka ma rozkład $$t_{n-2}$$.

