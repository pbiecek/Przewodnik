# Liniowa i kwadratowa klasyfikacja

## Jak to działa?

Podobnie jak w przypadku klasyfikatora Naiwny Bayes, interesuje nas modelowanie rozkładu $y|X$. Z twierdzenia Bayesa mamy
$$
P(y_i = 1| X_i = x_i) = \frac{P(X_i = x_i | y_i = 1)P(y_i = 1)}{\sum_k P(X_i = x_i | y_i = k)P(y_i = k)}
$$

Log-szansa ma postać
$$
\log (odds_i) = \log \frac{P(X_i = x_i | y_i = 1)P(y_i = 1)}{P(X_i = x_i | y_i = 0)P(y_i = 0)}  
$$
W przypadku Liniowej Analizy Dyskryminacyjnej (LDA, ang. Linear Discriminant Analysis), zakłada się, że
$$
X_i | (y_i = k) \sim \mathcal N (\mu_k, \Sigma)
$$
A więc log szansę można wyrazić jako 

$$
\log (odds_i) = \log \frac{(2\pi)^{-1/2} |\Sigma|^{-1/2} \exp\left(-\frac 12 (x_i - \mu_1)^T\Sigma^{-1}(x_i - \mu_1)\right) P(y_i = 1)}{(2\pi)^{-1/2} |\Sigma|^{-1/2} \exp\left(-\frac 12 (x_i - \mu_0)^T\Sigma^{-1}(x_i - \mu_0)\right) P(y_i = 0)}  
$$
Kilka prostych przekształceń i mamy
$$
\log (odds_i) =  
 x_i^T\Sigma^{-1} (\mu_1 - \mu_0)
-\frac 12 \mu_1^T\Sigma^{-1}\mu_1 + \frac 12 \mu_0^T\Sigma^{-1}\mu_0+
\log \frac{ P(y_i = 1)}{ P(y_i = 0)} =
x_i^T A + c
$$
Jak widzimy, szansa w przypadku metody LDA wyraża się liniową funkcją zmiennych $x_i$. Macierz współczynników $A$ i $c$ wyznacza się na bazie ocen $\hat\mu_k$ i $\hat\Sigma$.

Metoda kwadratowa różni się od liniowej tylko tym, że dla każdej klasy estymuje się osobną macierz kowariancji.

$$
X_i | (y_i = k) \sim \mathcal N (\mu_k, \Sigma_k)
$$

Gdy dla takiej gęstości policzymy log szansę to okaże się, że jest ona kwadratową funkcją $x_i$.

Gdy klas jest dużo, estymacja macierzy kowariancji o rozmiarach $pxp$ jest obarczona dużym błędem. Dlatego rozważa się też regularyzowaną estymację macierzy kowariancji w grupach, tak że
$$
\Sigma_k^r = \alpha \Sigma + (1-\alpha) \Sigma_k.
$$


## Jak to zrobić w R?

Ponieważ metoda LDA i QDA oparta jest o założenie wielowymiarowej normalności zmiennej $X$, dlatego sensownie jest ją stosować dla zmiennych ilościowych.

Poniżej przedstawimy przykład dla funkcji `MASS::lda()` i `MASS::qda()`.


```r
library("MASS")
ml <- lda(Survived~Age+Fare, data=titanic)
ml
```

```
## Call:
## lda(Survived ~ Age + Fare, data = titanic)
## 
## Prior probabilities of groups:
##         0         1 
## 0.5938375 0.4061625 
## 
## Group means:
##        Age     Fare
## 0 30.62618 22.96546
## 1 28.34369 51.84321
## 
## Coefficients of linear discriminants:
##              LD1
## Age  -0.02597135
## Fare  0.01907920
```

```r
mq <- qda(Survived~Age+Fare, data=titanic)
mq
```

```
## Call:
## qda(Survived ~ Age + Fare, data = titanic)
## 
## Prior probabilities of groups:
##         0         1 
## 0.5938375 0.4061625 
## 
## Group means:
##        Age     Fare
## 0 30.62618 22.96546
## 1 28.34369 51.84321
```
Można też wykorzystać funkcję `predict()` aby wyznaczać predykcje dla nowych wartości $X$.

