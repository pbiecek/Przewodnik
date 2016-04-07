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






## Estymacja współczynników

Ponieważ dla wielu rodzin nie ma analitycznego rozwiązania, pozostają metody iteracyjnego szukania maksimum funkcji wiarogodności.

Można klasycznie, stosując np. metodę Newtona-Raphsona,

$$
\beta^{(i+1)} = \beta^{(i)} - H^{(-1)}(\beta^{(i)}) g(\beta^{(i)}),
$$

gdzie $$H(\beta^{(i)})$$ to macierz Hessego drugich pochodnych wyznaczona w punkcie $$\beta^{(i)}$$ a $$g(\beta^{(i)})$$ to gradient wyznaczony w tym punkcie.

Innym wariantem jest metoda Fisher Scoring, gdzie macierz Hessego zastępujemy macierzą informacji Fishera.

$$
\beta^{(i+1)} = \beta^{(i)} - H^{(-1)}(\beta^{(i)}) g(\beta^{(i)}),
$$


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



