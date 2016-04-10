# Algorytm EM (ang. Expectation–maximization)

Algorytm EM ma wiele zastosowań, w sytuacji gdy bezpośrednia maksymalizacji funkcji log-wiarogodności $$l(\theta, Y)$$ jest trudna. W wielu sytuacjach, problem maksymalizacji można uprościć, jeżeli przestrzeń parametrów rozszerzy się o dodatkowe - nieobserwowane zmienne. 

Typowe przykłady takich sytuacji to uzupełnianie braków w danych oraz badanie mieszanin rozkładów.

Poniższy opis rozpoczniemy od ogólnego sformułowania algorytmu EM, a następnie przedstawimy konkretny przykład. Ostatni punkt to przedstawienie zastosowania algorytmu EM do maksymalizacji rozkładu *a-posteriori*.


## Ogólne sformułowanie problemu

Oznaczmy przez $$Y$$ obserwowaną zmienną losową (potencjalnie wielowymiarową) o rozkładzie $$F$$ z rodziny indeksowanej parametrem $$\phi$$. Bezpośrednia estymacja $$\phi$$ metodą największej wiarygodności jest trudna, więc rozszerzamy przestrzeń o zmienne ukryte/nieobserwowane $$Z$$.

Łączny wektor zmiennych losowych $$(Y, Z)$$ pochodzi z rodziny indeksowanej parametrem $$\theta \in \Theta$$. Gęstość tego rozkładu oznaczmy przez $$f(y, z; \theta)$$.

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




