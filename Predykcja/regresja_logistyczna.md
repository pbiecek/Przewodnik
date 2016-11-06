# Regresja logistyczna

## Jak to działa?

W regresji logistycznej modeluje się log-szansę jako funkcję liniową zmiennych $X_i$.

$$
\log (odds_i) =  X_i \beta
$$
Pozostaje tylko problem, jak estymować współczynniki $\beta$.

W przypadku metody regresji logistycznej stosuje się metodę maksymalnej wiarogodności. 

Jak pamiętamy $y_i \sim B(p_i, 1)$ a
$$
p_i = \frac{\exp(\log (odds_i))}{1+\exp(\log (odds_i))} = \frac{\exp(X_i \beta)}{1+\exp(X_i \beta)}
$$

Funkcja log-wiarogodności ma postać
$$
l(\beta) = \sum_{i=1}^N \log \left( p_i^{y_i} (1-p_i)^{(1-y_i)} \right)
$$
Rozpisujemy
$$
l(\beta) = \sum_{i=1}^N y_i \log p_i + (1-y_i)  \log (1-p_i) = \sum_{i=1}^N y_i x_i \beta  + \log (1 - \exp(x_i \beta)) 
$$
Policzmy pochodną z funkcji wiarogodności
$$
\frac{\delta}{\delta \beta_i}l(\beta) = \sum_{i=1}^N x_i \left(y_i - \frac{\exp (x_i \beta)}{1+\exp(x_i \beta)}\right)  = \sum_{i=1}^N x_i(y_i - \tilde{p_i}) 
$$
Nie znajdziemy zwartej analitycznej postaci na estymator największej wiarogodności w tym modelu.
Zazwyczaj stosuje się rozwiązanie numeryczne oparte o metodę ważonych najmniejszych kwadratów (Fisher Scoring) lub o metodę estymacji Newton-Raphson.

To metody iteracyjne, w których kolejne oceny $\beta^{(j)}$ wyznacza się jako

$$
\beta^{(j+1)} = \beta^{(j)} - {H^{(j)}}^{-1} u^{(j)}
$$
gdzie $u^{(j)}$ to gradient funkcji log wiarogodności, a $H^{(j)}$ to albo macierz drugich pochodnych (macierz Hessego, hesjan) funkcji log-wiarogodności (metoda Newton-Raphson) albo oczekiwana wartość tej macierzy (metoda Fisher Scoring).

## Jak to zrobić w R?

Przykłady regresji logistycznej przedstawimy na danych o przeżyciach z katastrofy statku Titanic. 


```r
library("Przewodnik")
head(titanic)
```

```
##   Survived Pclass    Sex Age    Fare Embarked
## 1        0      3   male  22  7.2500        S
## 2        1      1 female  38 71.2833        C
## 3        1      3 female  26  7.9250        S
## 4        1      1 female  35 53.1000        S
## 5        0      3   male  35  8.0500        S
## 6        0      3   male  NA  8.4583        Q
```

Funkcja `glm()` wyznacza współczynniki w modelu uogólnionych modeli liniowych (ang. Generalized Linear Models). Gdy wskażemy rodzinę rozkładów dwumianowych, otrzymamy model regresji logistycznej.


```r
rl <- glm(Survived~Sex+Pclass+Age+Fare, data=titanic, family = "binomial")
summary(rl)
```

```
## 
## Call:
## glm(formula = Survived ~ Sex + Pclass + Age + Fare, family = "binomial", 
##     data = titanic)
## 
## Deviance Residuals: 
##     Min       1Q   Median       3Q      Max  
## -2.7393  -0.6788  -0.3956   0.6486   2.4639  
## 
## Coefficients:
##               Estimate Std. Error z value Pr(>|z|)    
## (Intercept)  3.7225052  0.4645113   8.014 1.11e-15 ***
## Sexmale     -2.5185052  0.2082017 -12.096  < 2e-16 ***
## Pclass2     -1.2765903  0.3126370  -4.083 4.44e-05 ***
## Pclass3     -2.5415762  0.3277677  -7.754 8.89e-15 ***
## Age         -0.0367302  0.0077325  -4.750 2.03e-06 ***
## Fare         0.0005226  0.0022579   0.231    0.817    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 964.52  on 713  degrees of freedom
## Residual deviance: 647.23  on 708  degrees of freedom
##   (177 observations deleted due to missingness)
## AIC: 659.23
## 
## Number of Fisher Scoring iterations: 5
```
