## Wprowadzenie do generatorów liczb pseudolosowych

Generowane przez komputer liczby nazywane są pseudolosowymi, ponieważ mają emulować losowość, ale są wyznaczane  w deterministyczny, choć często bardzo skomplikowany, sposób. Z uwagi na nieustannie rosnące zapotrzebowanie na dobre liczby pseudolosowe w literaturze opisanych jest wiele metod ich generowania, a nad nowymi metodami wciąż pracuje wiele osób.

W programie R mamy możliwość wyboru jednego z już zaimplementowanych algorytmów generujących liczby losowe lub napisania własnej funkcji do generowania tych liczb. Aktualnie w pakiecie `base` zaimplementowanych jest sześć algorytmów generowania liczb losowych. 

Zmienić generator liczb losowych można wywołując funkcję `RNGkind()` oraz podając za jej argumenty nazwy dwóch wybranych generatorów, odpowiednio dla rozkładu jednostajnego i dla rozkładu normalnego. Wynikiem tej funkcji są nazwy uprzednio używanych generatorów.

Do generowania liczb z rozkładu jednostajnego dostępne są następujące nazwy algorytmów: `"Wichmann-Hill"`, `"Marsaglia-Multicarry"`, `"Super-Duper"`, `"Mersenne-Twister"`, `"Knuth-TAOCP"`, `"Knuth-TAOCP-2002"`, `"user-supplied"`. Domyślnie stosowany jest `"Mersenne-Twister"`. 

Liczby losowe dla innych rozkładów można otrzymać z liczb losowych dla rozkładu jednostajnego wykorzystując np. metodę odwrotnej dystrybuanty. Nie ma więc potrzeby określania generatora dla każdego rozkładu oddzielnie. Wyjątkiem jest rozkład normalny, dla którego mamy możliwość wybrania metody generowania liczb losowych. Dostępne metody oznaczone są nazwami: 
`"Kinderman-Ramage"`, `"Buggy Kinderman-Ramage"`, `"Ahrens-Dieter"`, `"Box-Muller"`, `"Inversion"`, `"user-supplied"`. Domyślnie wykorzystywana jest metoda odwrotnej dystrybuanty `"Inversion"`. 


Ponieważ dystrybuanta rozkładu normalnego nie ma prostej postaci analitycznej, więc aby użyć metody odwrotnej dystrybuanty trzeba wykorzystać zaawansowane i wymagające obliczeniowo aproksymacje numeryczne, których opis można znaleźć w opisie funkcji `qnorm()`. Innym popularnym algorytmem generowania liczb z rozkładu normalnego, znacznie szybszym od metody odwrotnej dystrybuanty, jest algorytm Boxa-Mullera (`"Box-Muller"`). 

Więcej informacji o tym i innych generatorach przeczytać można w dokumentacji do funkcji `RNGkind()`.
Osoby zainteresowane tym tematem znajdą więcej informacji o generatorach w książce Roberta Wieczorkowskiego i Ryszarda Zielińskiego *Komputerowe generatory liczb losowych*. Poniżej przedstawiamy przykład użycia funkcji `RNGkind()` do zmiany generatora.

Wybieramy generator "Super-Duper" dla generowania liczb z rozkładu jednostajnego i metodę "Box-Muller" do generowania liczb z rozkładu normalnego, wynikiem funkcji RNGkind() są poprzednio stosowane generatory.


```r
(RNGkind("Super", "Box")) 
```

```
## [1] "Super-Duper"   "Ahrens-Dieter"
```

Można wybierać generatory podając tylko pierwsze znaki nazw.


```r
(RNGkind("Super", "Ahr"))
```

```
## [1] "Super-Duper" "Box-Muller"
```

Generator to funkcja deterministyczna. Do losowania kolejnych liczb wykorzystuje tzw. ziarno (ang. *seed*), całkowicie determinujące wartości kolejnych liczb pseudolosowych. Ziarno to wartość na podstawie której konstruowane będą kolejne liczby losowe.

Dla ustalonego generatora i ziarna generowane będą identyczne liczby losowe bez względu na system operacyjny, nazwę komputera, rasę użytkownika, czy temperaturę w pokoju. 

Tę właściwość programowych generatorów liczb pseudolosowych (istnieją też sprzętowe generatory, ale to osobny temat) można łatwo wykorzystać! Sterując wyborem ziarna umożliwiamy otrzymywanie identycznych ciągów liczb losowych na różnych komputerach. W ten sposób możemy powtarzać wyniki symulacji, odtwarzać te wyniki na innych komputerach lub kontynuować obliczenia przerwane w wyniku wystąpienia jakiegoś błędu. 

Ciekawe informacje dotyczące jakości generatorów liczb pseudolosowych znaleźć można w dokumentacji pakietu `RDieHarder` lub na stronie `http://dirk.eddelbuettel.com/code/rdieharder.html`.

Informacje o ziarnie i generatorze liczb losowych przechowywana jest w wektorze `.Random.seed`. Pierwszym elementem tego wektora jest informacja, który generator jest wykorzystywany, pozostałe elementy przechowują ziarno generatora. Dla generatora `Mersenne-Twister` ziarno jest wektorem 625 liczb całkowitych, dla pozostałych generatorów ziarno ma inną, zwykle krótszą, długość. Poniżej przykład zapisywania i odtwarzania ziarna generatora.



```r
.Random.seed[1:7]
```

```
## [1]         102  1592882403 -1087561527          NA          NA          NA
## [7]          NA
```

Zapisujemy ziarno generatora, losujemy 10 liczb losowych.


```r
save.seed <- .Random.seed
rnorm(9)
```

```
## [1]  0.3965513  1.1664325 -0.4613190 -1.5723750  0.5507826  1.8767068
## [7]  0.2104542 -0.3085643 -0.9558250
```

Odtwarzamy ziarno i losujemy 10 kolejnych liczb.


```r
.Random.seed <- save.seed 
rnorm(9)
```

```
## [1] -0.1022967 -1.1790798  1.0988424  1.0630586 -1.9116259  1.1782023
## [7] -1.9595778 -0.2884178  1.0447500
```

Pamiętanie ziarna złożonego z 625 liczb nie jest specjalnie wygodne. Do łatwej inicjacji ziarna zalecane jest korzystanie z funkcji `set.seed()`. Argumentem tej funkcji jest jedna liczba, która jest zamieniana na ziarno odpowiedniej długości. Poniżej przykład wywołania tej funkcji. Ustawiamy ziarno i generujemy liczby losowe.


```r
set.seed(1313)
runif(10)
```

```
##  [1] 0.27578588 0.06637362 0.82379757 0.52979504 0.91424061 0.51159113
##  [7] 0.94690240 0.56341309 0.61462777 0.54047574
```

Inicjujemy to samo ziarno.


```r
set.seed(1313)
runif(10)
```

```
##  [1] 0.27578588 0.06637362 0.82379757 0.52979504 0.91424061 0.51159113
##  [7] 0.94690240 0.56341309 0.61462777 0.54047574
```
