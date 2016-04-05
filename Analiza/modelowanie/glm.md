# Jak budować Uogólnione Modele Liniowe (ang. Generalized Linear Models)?

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

