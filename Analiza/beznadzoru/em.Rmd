# Dlaczego algorytm EM działa (ang. Expectation–maximization)?

Algorytm EM ma wiele zastosowań, w sytuacji gdy bezpośrednia maksymalizacji funkcji log-wiarogodności $$l(\theta, Y)$$ jest trudna. W wielu sytuacjach, problem maksymalizacji można uprościć, jeżeli przestrzeń parametrów rozszerzy się o dodatkowe - nieobserwowane zmienne. 

Typowe przykłady takich sytuacji to uzupełnianie braków w danych oraz badanie mieszanin rozkładów.

Poniższy opis rozpoczniemy od ogólnego sformułowania algorytmu EM, a następnie przedstawimy konkretny przykład. Ostatni punkt to przedstawienie zastosowania algorytmu EM do maksymalizacji rozkładu *a-posteriori*.


## Ogólne sformułowanie problemu

Oznaczmy przez $$Y$$ obserwowaną zmienną losową (potencjalnie wielowymiarową) o rozkładzie $$F$$ z rodziny indeksowanej parametrem $$\phi$$. Bezpośrednia estymacja $$\phi$$ metodą największej wiarygodności jest trudna, więc rozszerzamy przestrzeń o zmienne ukryte/nieobserwowane $$Z$$.

Łączny wektor zmiennych losowych $$(Y, Z)$$ pochodzi z rodziny indeksowanej parametrem $$\theta \in \Theta$$. Gęstość tego rozkładu oznaczmy przez $$f(y, z; \theta)$$.


## Algorytm EM

Algorytm EM jest następujący:

1. Wybierz początkową wartość wektora parametrów $$\hat\theta^{(1)}$$

2. Krok E (Expectation). Wyznacz wartość warunkową dla aktualnego $$\hat\theta^{(j)}$$, gdzie $$j$$ to numer iteracji. 
$$
Q(\theta, \hat\theta^{(j)}) = E(l(\theta; Z, Y) | Y, \hat\theta^{(j)}).
$$
To jest funkcja po $$\theta$$.

3. Krok M (Maximization). Wyznacz kolejną wartość $$\hat\theta^{(j+1)}$$, taką która maksymalizuje $$Q(\theta, \hat\theta^{(j)})$$ po  $$\theta$$.

4. Powtarzaj kroki 2-3 do spełnienia określonego warunku stop.


## Dlaczego to działa?

Pytanie, na które musimy odpowiedzieć to dlaczego optymalizacja $$Q(\theta, \hat\theta^{(j)})$$ pomaga w maksymalizacji funkcji wiarygodności.

Zacznijmy od rozkładu warunkowego
$$
P(Z|Y; \theta) = \frac{ P(Z, Y; \theta) }{ P(Y; \theta) }
$$
a więc 
$$
P(Y; \theta) = \frac{P(Z,Y; \theta)}{P(Z|Y; \theta)}.
$$

Interesuje nas funkcja log-wiarogodności. Korzystając z powyższego, można ją wyrazić jako
$$
l(\theta; Y) = l_0(\theta; Z, Y) - l_1(\theta; Z|Y).
$$
Zauważmy, że funkcje wiarygodności $$l()$$, $$l_0()$$ i $$l_1()$$ dotyczą różnych zmiennych, stąd różne oznaczenia.

Nałóżmy teraz obustronnie warunkową wartość oczekiwaną $$E(. | Y, \theta')$$. Parametr $$\theta'$$ będziemy w przyszłości wykorzystywali jako ustalony, roboczy, suboptymalny wektor parametrów. Otrzymujemy 
$$
l(\theta; Y) = E(l_0(\theta; Z, Y) | Y, \theta') - E(l_1(\theta; Z|Y) | Y, \theta')
$$

Aby uprościć zapis poniżej, przyjmijmy takie standardowe oznaczenia.
$$
l(\theta; Y) = Q(\theta, \theta') - R(\theta, \theta')
$$

Rozłożyliśmy funkcję log-wiarogodności, którą chcielibyśmy maksymalizować po $$\theta$$ na dwa człony. Algorytm EM będzie bezpośrednio maksymalizował $$Q(\theta, \theta')$$. 

Funkcja $$R(\theta, \theta')$$ ma swoje maksimum gdy wartość oczekiwana jest warunkowana tym samym rozkładem co będąca pod nią funkcja wiarygodności (funkcja wiarygodności jest wypukła, więc można skorzystać z nierówności Jensena. Pośrednie kroki są opisane w ćwiczeniu 8.2 *Elements of Statistical Learning*). 

A więc 
$$R(\theta, \theta') \leq R(\theta', \theta')$$,
co z kolei oznacza, że jeżeli jesteśmy w stanie znaleźć $$\theta$$, które zwiększy $$Q(\theta, \theta')$$ to z pewnością zwiększymy też $$l(\theta; Y)$$.

## A może tak policzyć cos na palcach?

Ogólne sformułowanie algorytmu EM umożliwia stosowanie go do rozmaitych sytuacji, ale aby wyrobić sobie intuicję przeliczmy jeden prosty przykład, jednowymiarowej mieszaniny dwóch rozkładów normlanych różniących się tylko średnią. Dla większej liczby składowych, wymiarów i parametrów obliczenia są według tego samego schematu, jest tylko więcej symboli.

Model mieszaniny. Dwie składowe 
$$
Y_1 \sim \mathcal N(\mu_1, \sigma^2),
$$
$$
Y_2 \sim \mathcal N(\mu_2, \sigma^2),
$$
rozkład mieszający
$$
Z \sim B(1, \pi),
$$
i mieszanina 
$$
Y = (1-Z) Y_1 + Z Y_2.
$$

Mieszanina to w $$\pi$$ rozkład zmiennej $$Y_1$$ a w $$1-\pi$$ rozkład zmiennej $$Y_2$$. Gęstość tego rozkładu można opisać jako
$$
f_Y(x) = (1-\pi) \phi_1(x) + \pi \phi_2(x).
$$

Nasz wektor parametrów to $$\theta=(\pi, \mu_1, \mu_2, \sigma)$$ a funkcja log-wiarogodności ma postać
$$
l(\theta, y) = \sum_i \log [(1-\pi)\phi_1(y_i) + \pi \phi_2(y_i)].
$$
Optymalizacja takiej sumy logarytmów sum nie jest prosta. 

Zgodnie z duchem EM ułatwimy sobie zadanie dodając do modelu zmienne ukryte $$Z$$. Funkcja wiarogodności w takim modelu ma postać
$$
l(\theta, y, z) = \sum_i [(1-z_i) \log \phi_1 (y_i) + z_i \log \phi_2 (y_i)] + 
\sum_i [(1-z_i) \log \pi + z_i \log (1-\pi) ].
$$

Tę funkcję będzie nam łatwiej maksymalizować. Przyjrzyjmy się krokom w algorytmie EM.

### Krok E

Chcemy wyznaczyć warunkową wartość oczekiwaną funkcji $$l(\theta, y, z)$$ po $$y, theta^{(i)}$$. Człony funkcji wiarogodności zawierające $$y_i$$ się nei zmienią, musimy jedynie policzyć co stanie się z członem $$z_i$$.

$$
E(Z_i | Y; \theta^{(i)}) = Pr(Z_i = 1 | Y; \theta^{(i)}) = \frac{Pr(Z_i = 1, Y; \theta^{(i)})}{Pr(Y; \theta^{(i)})}
$$
a więc
$$
E(Z_i | Y; \theta^{(i)}) = \frac{\hat \pi^{(i)} \phi_2(y_i) }{(1-\hat \pi^{(i)}) \phi_1(y_i) + \hat \pi^{(i)} \phi_2(y_i) } = \eta_i.
$$

Wyliczone wartości oczekiwane wstawiamy w miejsce $$z_i$$.

### M

Funkcja $$Q(\theta, \hat \theta^{(i)})$$ jest już funkcją parametrów $$(\mu_1, \mu_2, \sigma, \pi)$$. Z uwagi na jej postać, można każdy z parametrów maksymalizować niezależnie wyznaczając pochodna i przyrównując do zera.

Otrzymamy

$$
\hat \mu_1^{(j+1)} = \frac{\sum_i (1-\eta_i)y_i}{\sum_i (1-\eta_i)},
$$
$$
\hat \mu_2^{(j+1)} = \frac{\sum_i \eta_i y_i}{\sum_i \eta_i},
$$
$$
\hat \sigma_2^{2, (j+1)} = [\sum_i (1-\eta_i) (y_i - \hat\mu_1^{(j)})^2 + \sum_i \eta_i (y_i - \hat\mu_2^{(j)})^2]/n,
$$
$$
\hat \pi^{(j+1)} = \sum_i \eta_i / n.
$$


Kroki E i M należy powtarzać aż nie uzyska się przyzwoitej zbieżności.






