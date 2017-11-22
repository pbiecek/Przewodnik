# Prawdopodobieństwo czy szansa?

W problemie klasyfikacji binarnej etykietę możemy opisać jako zmienną losową z rozkładu dwumianowego o prawdopodobieństwie sukcesu $p$.  

Dla $i$-tej obserwacji zapiszemy to jako

$$
y_i \sim B(p_i, 1)
$$

Interesuje nas opisanie prawdopodobieństwa $p_i$ jako funkcji wektora obserwacji $X$

$$
p_i = f(X_i).
$$
Ponieważ $X_i$ jest znane, gdybyśmy znali $f()$ moglibyśmy lepiej przewidywać wartości $y_i$.

Bezpośrednie modelowanie prawdopodobieństwa $p_i$ potrafi być trudne, z uwagi na to, że prawdopodobieństwo przyjmuje wartości na ograniczonym przedziale $(0,1)$. Dlatego w modelowaniu często zamiast prawdopodobieństwa modeluje się logarytm szansy.

## Szansa

Szansa wystąpienia zdarzenia to iloraz prawdopodobieństwa, że to zdarzenie wystąpi do prawdopodobieństwa, że nie wystąpi.

$$
odds_i = \frac{p_i}{1-p_i}
$$
Szansa przyjmuje wartości w przedziale $(0, \infty)$. Wartość 1 oznacza, że tak samo prawdopodobne jest wystąpienie i nie wystąpienie określonego zdarzenia.

## Log-szansa

Log-szansa to logarytm z szansy. 

$$
\log(odds_i) = \log\left(\frac{p_i}{1-p_i}\right) = \log p_i - \log (1-p_i)
$$
Log-szansa przyjmuje wartości w przedziale $(-\infty, \infty)$. Wartość 0 oznacza, że tak samo prawdopodobne jest wystąpienie i nie wystąpienie określonego zdarzenia.

## Szansa prawdopodobieństwo - prawdopodobieństwo szansa

Prawdopodobieństwo można jednoznacznie przekształcić na log-szanse.
$$
\log(odds_i) = \log\left(\frac{p_i}{1-p_i}\right) 
$$

Log-szanse można jednoznacznie przekształcić na prawdopodobieństwo.
$$
p_i = \frac{1}{1 + \exp(- \log ({odds}_i))}
$$
