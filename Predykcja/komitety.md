# Komitety

W tym miejscu opiszemy metody konstrukcji reguł predykcyjnych oparte o komitety innych reguł (które będziemy nazywać mniejszymi regułami, przy czym słowo ,,mniejsze'' nie odnosi się do złożoności obliczeniowej ale do bycia częścią większej reguły).

Rozważymy dwa podejścia, oba związane są z tzw. *Bias-Variance Trade-off*. Błąd predykcji rozkłada się czynniki, z których dwa to obciążenie (bias) i wariancja (variance).

Mając to na uwadze, skonstruujemy metodę predykcji opartą o komitet innych metod, tak by:

* Bagging, łączenie mniejszych reguł w większą regułę decyzyjną ma na celu obniżenie wariancji reguły decyzyjnej. Najczęściej osiąga się to kosztem wprowadzenie obciążenia. Technika sprawdza się dla wyjściowych modeli o małym obciążeniu.

* Boosting, łączenie mniejszych reguł w większą regułę decyzyjną ma na celu obniżenie obciążenia. Najczęściej osiąga się to kosztem zwiększonej wariancji. Technika sprawdza się dla wyjściowych modeli o małej wariancji.

## Bagging

Bagging to skrót od *Bootstrap aggregating*. Ta technika polega na obniżeniu wariancji reguły przez uśrednianie wielu małych reguł decyzyjnych. Sprawdza się dla klasyfikatorów o niskim obciążeniu, które mają tendencje do przeuczania się. Takich jak drzewa decyzyjne, sieci neuronowe czy modele liniowe o dużej liczbie cech.

Technikę opisać można następująco.

1. Ze zbioru $(X, y)$ o wielkości $n$ wylosuj ze zwracaniem bootstrapową próbę $(X, y)^{b,*}$. 
2. Na próbie bootstrapowej zbuduj regułę decyzyjną $f(X)^{b, *}$
3. Powtórz kroki 1-2 wiele razy, np. B razy (np. B=1000),
4. Uśrednij / uzgodnij wyniki wszystkich B reguł decyzyjnych.

### Lasy losowe

Techniką wyrastającą z baggingu są lasy losowe, obecnie znacznie częściej stosowane niż standardowy bagging.
Nazwa lasy losowe jest znakiem towarowym zastrzeżonym przez Leo Breiman i Adele Cutler.

W ogólności bagging może być zastosowany do dowolnej reguły decyzyjnej, ale okazuje się, że dobre wyniki szybko można uzyskać bazując na drzewach decyzyjnych.

Algorytm lasów losowych jest następujący

1. Ze zbioru $(X, y)$ o wielkości $n$ wylosuj ze zwracaniem bootstrapową próbę $(X, y)^{b,*}$. 
2. Na próbie bootstrapowej zbuduj drzewo decyzyjne $D^{*, b}$. Proces budowania drzewa jest opisany w poprzednim rozdziale, jedyna modyfikacja polega na tym, że w każdym węźle losowane jest $r$ zmiennych i tylko te zmienne są rozpatrywane jako kandydaci do dzielenia. Autorzy sugerują wybieranie $r=\sqrt{p}$ dla problemów klasyfikacji i $r=p/3$ dla problemów regresji.
3. Powtórz kroki 1-2 B razy, np. B=1000 razy.
4. Uzgodnij (uśrednij) wyniki predykcji z użyciem $D^{*, b}$ drzew.

Lasy losowe, poza samą regułą decyzyjną, pozwalają na wyznaczenie kilku użytecznych współczynników.

1. Out-of-Bag error-rate (OOB). Ponieważ każda z prób bootstrapowych zawiera średnio $1-exp(-1) \approx 63.2\%$ obserwacji, pozostałe $36.8\%$ obserwacji można wykorzystać dla każdego drzewa do walidacji modelu. 

2. Variable importance - ważności zmiennych. Ważność zmiennych w lasach losowych można wyznaczać na kilka sposobów, najpopularniejsze są dwa:
  * Gini (MeanDecreaseGini), jako miarę ważności zmiennej $X_i$ wyznacza się sumę, po wszystkich węzłach wykorzystujących zmienną $X_i$, zmiany współczynnika Gini impurity. Gdzie dla węzła $r$ mamy $i(r) = 1-p_1^2 -p_2^2$. Zmiana tej miary to $I(r) = i(r) - p_L i(r_L) - p_R i(r_R)$.
  * Permutacyjny (MeanDecreaseAccuracy), jako miarę ważności zmiennej $X_i$ wyznacza się różnicę średniego błędu OOB pomiędzy lasem z wszystkimi zmiennymi a lasem zbudowanym na zbiorze danych gdzie $X_i$ zostało permutowane.

3. Proximities - podobieństwa. Mając wyuczony las losowy, można go wykorzystać by ocenić miarę podobieństwa obserwacji. Wyznacza się ją jako częstość węzłów w lesie, w których dane dwie obserwacje występują razem.

4. Imputacja wartości brakujących. Mając miarę podobieństwa pomiędzy obserwacjami, obserwacje brakujące są uzupełniane przez ważoną średnią z sąsiednich wierszy (sąsiednich w sensie proximities). 

5. Identyfikacja obserwacji odstających. Za obserwacje odstającą uznaje się obserwację o niskich wartościach podobieństwa (proximities) do innych obserwacji z danego klastra (klasy). Czyli 
$$
out(i) = \frac{n}{\sum_{d(k) = j}prox^2(m, k)}
$$
gdzie $j$ to klasa obserwacji $m$ a $n$ to liczba wszystkich obserwacji.


Więcej informacji o lasach losowych na stronie [Breiman](https://www.stat.berkeley.edu/~breiman/RandomForests/cc_home.htm).

## Boosting

Boosting to technika polegająca w połączeniu sekwencji reguł decyzyjnych (nawet słabych, ledwie lepszych niż losowe zgadywanie) w silną regułę. 
Termin 'silna reguła' oznacza tutaj regułę o małym błędzie na zbiorze uczącym.

Cel ten można zrealizować stosując następujący algorytm.

1. Zbuduj regułę $C_1$ na zbiorze uczącym. Dla każdej obserwacji określ reszty - funkcje straty związaną z daną obserwacją.
2. Na resztach zbuduj regułę $C_2$, dołącz ją do reguły $C_1$ tworząc ważoną kombinację $\alpha_1 C_1 + \alpha_2 C_2$. Dla każdej obserwacji określ reszty - funkcje straty związaną z daną obserwacją.
3. Powtarzaj krok 2 douczając za każdym razem nową regułę poprawiającą obecny stan predykcji.

Na algorytm ten można patrzeć jak na optymalizację po przestrzeni reguł decyzyjnych o zadanej strukturze. Znalezienie optymalnej nowej reguły decyzyjnej można porównać do optymalizacji gradientowej. Wzór na każdą nową regułę zależy od funkcji straty, ale w ogólności tzw. *gradient boosting* można opisać jako rozwiązanie problemu
$$
\hat \theta_m = \arg \min_\theta \sum_{i=1} L (y_i, f_{m-1}(x_i) + T(X_i, \theta))
$$
Czyli w każdym kroku szukamy optymalnego kroku $T(X,\theta)$ aby minimalizować funkcję straty $L()$.

### AdaBoost

Poniżej przedstawimy prawdopodobnie najbardziej znany algorytm z klasy boosting - AdaBoost (Robert Schapire 1990). Poniższe wyprowadzenie jest oparte o Elements of Statistical Learning, rozdział 10.

Przyjmijmy za funkcję straty tzw. wykładniczą funkcję straty, dla binarnej klasyfikacji z $y\in\{-1,1\}$. Zapisuje się tę funkcję jako 
$$
L(y, f(X)) = \exp(-y f(X))
$$

Przyjmijmy, że budowana reguła decyzyjna ma strukturę
$$
f(X) = \sum_{i=1}^k \alpha_i G_i(X)
$$
gdzie $G_i(X)$ to małe reguły decyzyjne a $\alpha_i$ to wagi z jakimi te reguły są składane. Funkcja $f(X)$ jest wyznaczana sekwencyjnie, w każdym kroku dodawany jest kolejny człon $\alpha_i G_i(X)$.

Sprowadza się to do rozwiązania zadania
$$
(\alpha_m, G_m) = \arg\min_{\alpha, G} \sum_{i=1}^n \exp [-y_i (f_{m-1}(X_i) + \alpha G(X_i))].
$$
Powyższy wzór można zapisać jako 
$$
(\alpha_m, G_m) = \arg\min_{\alpha, G} \sum_{i=1}^n w_i^{m} \exp [-y_i \alpha G(X_i)].
$$
gdzie $w_i^m$ to wartość funkcji straty dla modelu wyznaczonego w kroku $m-1$.

Zauważmy teraz, że ponieważ $y_i \in \{-1,1\}$ i $G(X_i) \in \{-1,1\}$ to dla każdego $\beta>0$ można wyznaczyć optymalne $G_m$ jako

$$
G_m = \arg\min_{G} \sum_{i=1}^n w_i^{m}  1_{y_i \neq G(X_i)}.
$$
Co już łatwo zrobić, to rozwiązaniem jest reguła decyzyjna minimalizująca błąd predykcji z zadanymi wagami $w_i$.

Z kolei mając $G_m$ pozostaje rozwiązać

$$
\alpha_m = \arg\min_{\alpha} \sum_{i=1}^n w_i^{m} \exp [-y_i \alpha G_m(X_i)]
$$
co można zapisać jako
$$
\alpha_m = \arg\min_{\alpha} 
\exp(-\alpha)\sum_{i:y_i = G_m(X_i)} w_i^{m} + \exp(\alpha) \sum_{i:y_i \neq G_m(X_i)} w_i^{m}.
$$
i dalej jako
$$
\alpha_m = \arg\min_{\alpha} 
\left(\exp(\alpha) - \exp(-\alpha)\right) \sum_{i=1}^n w_i^{m} 1_{y_i = G_m(X_i)} +  \exp(-\alpha) \sum_{i=1}^N w_i^{m}.
$$
oraz
$$
\alpha_m = \arg\min_{\alpha} 
\left(\exp(\alpha) - \exp(-\alpha)\right) \frac{\sum_{i=1}^n w_i^{m} 1_{y_i = G_m(X_i)}}{\sum_{i=1}^N w_i^{m}} +  \exp(-\alpha) .
$$


Taką funkcję jednej zmiennej $\alpha$ łatwo już rozwiązać. Oznaczając przez $res_i$
$$
res_i = \frac{\sum_{i=1}^n w_i^{m} 1_{y_i = G_m(X_i)}}{\sum_{i=1}^N w_i^{m}}
$$
mamy 
$$
\alpha_m  = \frac 12 \log \frac{1 - res_i}{res_i}
$$

Mamy już zarówno $\alpha_m$ jak i $G_m$, więc mamy i całą regułę decyzyjną. Warto zaznaczyć, że $G_m$ często szuka się wśród niewielkich drzew decyzyjnych (np. jedno-dwupoziomowych).

## Porównanie Baggingu i Boostingu

Bagging się łatwo zrównoleglą (każdą próbę bootstrapową można analizować niezależnie).

Bagging nie pomaga przy stabilnych modelach.

Boosting jest wrażliwy na obserwacje odstające.

Boosting buduje kolejne modele w sposób sekwencyjny.

Wiele osób, uznanych autorytetów w ML uważa, że boosting jest lepszy od baggingu. Asymptotycznie to może i prawda, ale w praktyce dla zwykłych prób bywa różnie.

# Jak to zrobić w R?

Stara ale wciąż jedna z najlepszych implementacji lasów losowych jest dostępna w pakiecie `randomForest`.


```r
library("Przewodnik")
library("randomForest")
rf <- randomForest(Survived~., data=na.omit(titanic))
rf
```

```
## 
## Call:
##  randomForest(formula = Survived ~ ., data = na.omit(titanic)) 
##                Type of random forest: classification
##                      Number of trees: 500
## No. of variables tried at each split: 2
## 
##         OOB estimate of  error rate: 19.47%
## Confusion matrix:
##     0   1 class.error
## 0 379  45   0.1061321
## 1  94 196   0.3241379
```

Metoda gradient boosting oparta o drzewa jest dostępna w `xgboost`.
Nie można jako argumenty podać formułę, trzeba samemu wyznaczyć ektor y i kolumnę X.

Również należy określić jak głębokie drzewa mają być generowane


```r
library("xgboost")
titanic2 <- na.omit(titanic)
y = titanic2$Survived == "1"
X = model.matrix(Survived~., titanic2)
gb <- xgboost(X, y,
              objective = "binary:logistic", 
              nrounds = 2,
              max.deph = 2)
```

```
## [0]	train-error:0.141457
## [1]	train-error:0.130252
```

```r
gb
```

```
## $handle
## <pointer: 0x11003c900>
## attr(,"class")
## [1] "xgb.Booster.handle"
## 
## $raw
##    [1] 00 00 00 80 09 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
##   [24] 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
##   [47] 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
##   [70] 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
##   [93] 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
##  [116] 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0f 00
##  [139] 00 00 00 00 00 00 62 69 6e 61 72 79 3a 6c 6f 67 69 73 74 69 63 06 00
##  [162] 00 00 00 00 00 00 67 62 74 72 65 65 02 00 00 00 00 00 00 00 09 00 00
##  [185] 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00 00 00
##  [208] 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
##  [231] 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
##  [254] 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
##  [277] 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
##  [300] 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
##  [323] 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00 23 00 00 00 00 00 00 00
##  [346] 00 00 00 00 09 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
##  [369] 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
##  [392] 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
##  [415] 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
##  [438] 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
##  [461] 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ff ff
##  [484] ff ff 01 00 00 00 02 00 00 00 03 00 00 80 00 00 28 b7 00 00 00 80 03
##  [507] 00 00 00 04 00 00 00 02 00 00 80 00 00 28 b7 00 00 00 00 05 00 00 00
##  [530] 06 00 00 00 04 00 00 80 00 00 d0 40 01 00 00 80 ff ff ff ff ff ff ff
##  [553] ff 00 00 00 00 64 de 04 3f 01 00 00 00 07 00 00 00 08 00 00 00 05 00
##  [576] 00 00 66 66 a6 41 02 00 00 80 09 00 00 00 0a 00 00 00 02 00 00 80 00
##  [599] 00 28 b7 02 00 00 00 0b 00 00 00 0c 00 00 00 05 00 00 80 66 26 d2 41
##  [622] 04 00 00 80 0d 00 00 00 0e 00 00 00 04 00 00 80 00 00 84 41 04 00 00
##  [645] 00 0f 00 00 00 10 00 00 00 04 00 00 80 00 00 b0 40 05 00 00 80 ff ff
##  [668] ff ff ff ff ff ff 00 00 00 00 b8 6d db 3e 05 00 00 00 11 00 00 00 12
##  [691] 00 00 00 05 00 00 00 9a 99 a6 41 06 00 00 80 13 00 00 00 14 00 00 00
##  [714] 04 00 00 80 00 00 58 41 06 00 00 00 15 00 00 00 16 00 00 00 05 00 00
##  [737] 00 33 33 d6 41 07 00 00 80 ff ff ff ff ff ff ff ff 00 00 00 00 9a 99
##  [760] 99 3e 07 00 00 00 17 00 00 00 18 00 00 00 04 00 00 80 00 00 12 42 08
##  [783] 00 00 80 ff ff ff ff ff ff ff ff 00 00 00 00 89 88 88 bd 08 00 00 00
##  [806] ff ff ff ff ff ff ff ff 00 00 00 00 0f 6b df be 0a 00 00 80 ff ff ff
##  [829] ff ff ff ff ff 00 00 00 00 ac aa aa 3e 0a 00 00 00 ff ff ff ff ff ff
##  [852] ff ff 00 00 00 00 58 6a a5 be 0b 00 00 80 ff ff ff ff ff ff ff ff 00
##  [875] 00 00 00 9a 99 19 3e 0b 00 00 00 ff ff ff ff ff ff ff ff 00 00 00 00
##  [898] f6 7b ee be 0c 00 00 80 19 00 00 00 1a 00 00 00 04 00 00 80 00 00 56
##  [921] 42 0c 00 00 00 1b 00 00 00 1c 00 00 00 05 00 00 00 c0 1b 51 42 0e 00
##  [944] 00 80 1d 00 00 00 1e 00 00 00 04 00 00 80 00 00 ac 41 0e 00 00 00 ff
##  [967] ff ff ff ff ff ff ff 00 00 00 00 e9 a2 8b be 15 00 00 80 ff ff ff ff
##  [990] ff ff ff ff 00 00 00 00 ec 51 b8
##  [ reached getOption("max.print") -- omitted 2445 entries ]
## 
## attr(,"class")
## [1] "xgb.Booster"
```
