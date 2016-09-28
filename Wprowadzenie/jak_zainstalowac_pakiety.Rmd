## Jak zainstalować dodatkowe pakiety?


Po zainstalowaniu podstawowego środowiska R mamy już dostęp do wielu użytecznych funkcjonalności.
Prawdziwa potęga kryje się jednak w tysiącach dodatkowych pakietów, w których znajdują się kolejne tysiące funkcji. 

Aby skorzystać z dodatkowych pakietów należy wykonać dwa kroki:
  
  1. Zainstalować nowy pakiet na dysku. Ten krok wystarczy wykonać raz, skopiuje on niezbędne pliki do katalogu z pakietami. Ścieżkę do katalogu z pakietami można sprawdzić używając polecenia `.libPaths()`.
2. Włączyć zainstalowany pakiet w działającej sesji R. Ten krok należy wykonać po każdym uruchomieniu środowiska R. Spowoduje on, że w aktualnej sesji będzie można korzystać z funkcji i zbiorów danych dostępnych w pakiecie.

Instalować pakiety można na kilka sposobów, zależnie od tego czy instalujemy pakiet z pliku czy też z jednego z ogólnie dostępnych repozytoriów. 
Najczęściej pakiety instaluje się z oficjalnego repozytorium CRAN (ang. *The Comprehensive R Archive Network*). To można zrobić funkcją `install.packages()`. 

Przykładowo, poniższe polecenie instaluje pakiet `ggplot2` wraz z pakietami zależnymi, bezpośrednio z repozytorium CRAN. Pakiet `ggplot2` zawiera zbiór funkcji do tworzenia wykresów statystycznych, jest to bardzo popularny pakiet a jednak nie ma go w podstawowym środowisku i musimy go na początku doinstalować.

```
install.packages("ggplot2")
```

Nowy pakiet można też zainstalować wybierając z menu opcję `Tools/Install packages...`. 

Niektórych pakietów nie ma w repozytorium CRAN, lub są w starszej wersji. 
Przykładowo, jeden z wymogów stawianych przed pakietami na CRAN jest ograniczenie wielkości pakietu do nie więcej niż 10 MB. 
Większe pakiety oraz pakiety w wersjach roboczych są często instalowane z repozytorium GitHub. 
Do instalacji pakietów z tego repozytorium można wykorzystać funkcję `install_github{devtools}`.

Przykładowo, aby zainstalować pakiet `PogromcyDanych` z repozytorium użytkownika `pbiecek` z GitHuba można wykorzystać instrukcję 

```
devtools::install_github("pbiecek/PogromcyDanych")
```

Poza tymi dwoma repozytoriami istnieje też wiele innych specjalistycznych. 
Przykładowo wiele pakietów wykorzystywanych w analizach bioinformatycznych znajduje się w repozytorium `Bioconductor` (https://www.bioconductor.org/).

Po zainstalowaniu nowego pakietu, pliki z danymi, funkcjami i plikami pomocy znajdą się na dysku twardym komputera. 
Ale aby móc skorzystać z wybranych funkcji należy przed pierwszym użyciem załadować (włączyć) odpowiedni pakiet.
Po każdym uruchomieniu platformy R ładowane są pakiety podstawowe takie jak: `base`, `graphics`, `stats`, itp. Aby skorzystać z dodatkowych funkcji lub zbiorów danych, należy załadować (włączyć) pakiet, w którym się one znajdują (zakładamy, że pakiety te zostały już zainstalowane). Pakiety włącza się poleceniem `library()`.

Poniższa instrukcja włącza pakiet `devtools`. Po włączeniu pakietu można używać funkcji z tego pakietu bez konieczności dodawania prefixu `devtools::`.

```
library("devtools")
```

Jak już pisaliśmy, aktualnie dostępnych jest ponad 7000 pakietów, które możemy dodatkowo zainstalować. W tak dużym zbiorze trudno czasem odnaleźć pakiet z interesującą nas funkcjonalnością. 

Dlatego, przedstawiając nowe funkcje będziemy korzystać z notacji `nazwaPakietu::nazwaFunkcji()`. Zapis `ggplot2::qplot()` oznacza, że funkcja `qplot()` znajduje się w pakiecie `ggplot2`. Ten prefix pomijamy dla pakietów `base`, `stats`, `utils` i `graphics`, których nie trzeba dodatkowo włączać, są automatycznie włączane z chwilą startu środowiska R. W skorowidzu, znajdującym się na końcu książki, funkcje są wymienione zarówno w kolejności alfabetycznej jak i po pogrupowaniu w pakiety.

Jeżeli znamy nazwę funkcji i chcemy dowiedzieć się w jakim pakiecie ta funkcja się znajduje a nie mamy tej książki pod ręką, to możemy wykorzystać funkcją `help.search()`. Przeszuka ona wszystkie zainstalowane pakiety w poszukiwaniu funkcji o wskazanej nazwie lub funkcji, w których opisie wystąpiło zadane słowo kluczowe. Więcej o tej funkcji i innych sposobach wyszukiwania informacji o funkcjach napiszemy w kolejnym podrozdziale.

Po załadowaniu odpowiedniego pakietu możemy korzystać z dostępnych w nim funkcji podając ich nazwę. Możemy też ręcznie wskazać, z którego pakietu funkcję chcemy uruchomić, co jest przydatne, gdy funkcje o identycznych nazwach znajdują się w kilku załadowanych pakietach. Przykładowo zarówno w pakiecie `epitools` jak i `vcd` znajduje się funkcja `oddsratio()` o tej samej nazwie ale innym działaniu. Aby wskazać, z którego pakietu chcemy wybrać funkcję należy użyć  operatora `::` lub `:::`.

Operator `::` pozwala na odnoszenie się wyłącznie do publicznych funkcji z pakietu, podczas gdy operator `:::` umożliwia odnoszenie się również do funkcji prywatnych.

Oba poniższe wywołania dotyczą funkcji `seq()` z pakietu `base`, drugi sposób jest szczególnie przydatny, gdy występuje kolizja nazw funkcji z różnych pakietów.

```
seq(10)
base::seq(10)
```

Jeżeli nie użyjemy tego operatora, a funkcja o danej nazwie występuje w kilku różnych pakietów, to program R użyje funkcji z ostatnio załadowanego pakietu.

