# Jak budować Uogólnione Modele Liniowe (ang. Generalized Linear Models)?

## Modelowanie wartości oczekiwanej

Uogólnione modele liniowe służą do opisywania wartości oczekiwanych zmiennych losowych pochodzących z wykładniczych rodzin rozkładów prawdopodobieństwa.

Wartość oczekiwaną objaśnianej zmiennej $$y$$ opisujemy przez przekształconą liniową kombinację zmiennych objaśniających $$X \beta$$. 

Ponieważ nośnik zmiennej objaśnianej $$y$$ jest różny dla różnych rozkładów (dla Poissona jest to $$[0, \infty)$$, dla rozkładu dwumianowego $$[0,1]$$, dla rozkładu normlanego $$(-\infty, \infty)$$), dlatego potrzebujemy funkcji, która sprowadzi liniowy predyktor $$X \beta$$ do nośnika zmiennej $$y$$.

Zakładamy więc następującą zależność.

$$
E(y) = \mu = g^{-1}(X \beta)
$$

gdzie $$g()$$ to tzw. funkcja łącząca.

W wielu rodzinach wykładniczych wariancja jest funkcją wartości oczekiwanej. Oznaczmy tę funkcję jako $$V$$.

$$
Var (y) = V( \mu ) = V( g^{-1}(X \beta) )
$$



## Funkcje łączące

Dla określonej rodziny wykładniczej można wybierać różne funkcje łączące. 

Poniżej przedstawiamy kanoniczne funkcje łączące (wyrażające średnią w terminach parametrów kanonicznych).


### Rozkład normalny 

Funkcja identycznosciowa.

$$
X \beta = \mu
$$


### Rozkład Poissona 

Logarytm

$$
X \beta = \ln (\mu)
$$

$$
\exp( X \beta) = \mu
$$

### Rozkład Dwumianowy 

Funkcja Logit

$$
X \beta = \ln (\frac{\mu}{1 - \mu})
$$

$$
\frac{\exp(X \beta)}{1 + \exp(X \beta)} = \mu
$$







## Estymacja współczynników

Ponieważ dla wielu rodzin nie ma analitycznego rozwiązania, pozostają metody iteracyjnego szukania maksimum funkcji wiarogodności.

Można klasycznie, stosując np. metodę Newtona-Raphsona,

$$
\beta^{(i+1)} = \beta^{(i)} - H^{(-1)}(\beta^{(i)}) g(\beta^{(i)}),
$$

gdzie $$H(\beta^{(i)})$$ to macierz Hessego drugich pochodnych wyznaczona w punkcie $$\beta^{(i)}$$ a $$g(\beta^{(i)})$$ to gradient wyznaczony w tym punkcie.

Innym wariantem jest metoda Fisher Scoring, gdzie macierz Hessego zastępujemy macierzą informacji Fishera (wartość oczekiwana macierzy drugich pochodnych).

$$
\beta^{(i+1)} = \beta^{(i)} - H^{(-1)}(\beta^{(i)}) g(\beta^{(i)}),
$$


IRLS - iteratively re-weighted least squares

Okazuje się, że problem estymacji sprowadza się do

$$
\beta^{(i+1)} = (X^T W^{(i)} X)^{-1} X^T W^{(i)} z^{(i)},
$$




## Testy


### Test Walda

$$
\hat \beta \to \mathcal N(\beta, I^{-1}(\beta))
$$

gdzie

$$
I(\beta) = \phi^{-1} X^T W X
$$

Macierz kowariancji jest z dokładnością do $$\phi$$ wyznaczana w algorytmie IWLS.

Znając rozkład asymptotyczny $$\hat \beta$$ można zbudować test w oparciu o statystykę Walda.


### Test ilorazu wiarogodności

Alternatywą do testu Walda opartego o asymptotyczny normalny rozkład estymatora $$\beta$$ jest wykorzystanie testu ilorazu wiarogodności. 

Rozważmy dwa modele $$M_2$$ i zagnieżdżony w nim $$M_1$$ (zagnieżdżenie oznacza tutaj zawieranie macierzy $$X$$). 

Statystyka testowa -2 logarytmy ilorazu wiarogodności wyraża się przez przeskalowaną różnicę dewiancji

$$
- 2 \log \lambda = \frac{D(M_1) - D(M_2)}{\phi}.
$$

Asymptotyczny rozkład testu ilorazu wiarogodności to $$\chi^2_{p}$$ gdzie $$p = p_2 - p_1$$ to różnica w liczbie parametrów pomiędzy rozważanymi modelami.


## Wykładnicza rodzina rozkładów

Rodzinę rozkładów nazywamy wykładniczą rodziną rozkładów, jeżeli gęstość można zapisać w postaci

$$
f(y|\theta) = h(y) \exp(b(\theta) T (y) - A(\theta))
$$


## Przykładowe wykładnicze rodziny rozkładów

### Rozkład Poissona

Funkcja gęstości rozkładu Poissona

$$
f(y|\lambda) = \frac{\exp(-y)\lambda^y}{y!} 
$$

można ją przekształcić do

$$
\frac{1}{y!}\exp(y (\log(\lambda) - 1)) 
$$

w tej postaci łatwiej zauważyć, że jest to rodzina wykładnicza.


### Rozkład Dwumianowy

Funkcja gęstości rozkładu dwumianowego

$$
f(y|\pi) = \left(n \over y\right) \pi^y (1-\pi)^{n-y} 
$$

można ją przekształcić do

$$
\left(n \over y\right) \exp(y \log \frac{\pi}{1-\pi} + n \log \frac{1}{1-\pi})
$$

a więc to też wykładnicza rodzina rozkładów.

### Rozkład Normalny

Funkcja gęstości rozkładu normalnego to 

$$
\frac{1}{\sqrt{2\pi} \sigma } \exp( - \frac{(y-\mu)^2}{2\sigma^2} )
$$

można ją opisać jako 

$$
\frac{1}{\sqrt{2\pi} \sigma } \exp( - \frac{y^2}{2\sigma^2} + \frac{y*\mu}{\sigma^2} - \frac{\mu^2}{2\sigma^2} )
$$

a więc to też wykładnicza rodzina rozkładów.




