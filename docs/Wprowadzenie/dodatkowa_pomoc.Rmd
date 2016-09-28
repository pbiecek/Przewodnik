# Gdzie szukać dodatkowych informacji?

W dalszej części tej książki opiszemy biblioteki do transformacji danych, modelowania statystycznego oraz wizualizacji. 
Z pewnością jednak pojawią się pytania lub wątki, które nie będą tutaj opisane.
Gdzie szukać dodatkowych informacji?

Najłatwiej i najszybciej jest zapytać się kogoś, kto to wie i chce nam podpowiedzieć. W sytuacji, gdy nie mamy takiej osoby pod ręką R oferuje bogaty system pomocy.

Pierwszym źródłem pomocy są wbudowane funkcje R ułatwiające wyszukiwanie informacji. Oto lista najbardziej przydatnych:

* Funkcja 'help()' wyświetla stronę powitalną systemu pomocy R. Na tej stronie opisane są szczegółowo wymienione poniżej funkcje.
* Funkcje 'help("nazwaFunkcji")' i '?nazwaFunkcji' wyświetlają stronę z pomocą dla funkcji o nazwie 'nazwaFunkcji'. Zobacz też przykład przedstawiony poniżej. Format opisów funkcji jest ujednolicony, tak aby łatwo było z nich korzystać. Kolejne sekcje pomocy zawierają: zwięzły opis funkcji (sekcja 'Description'), deklaracje funkcji (sekcja 'Usage'), objaśnienie poszczególnych argumentów (sekcja 'Arguments'), szczegółowy opis funkcji (sekcja 'Details'), literaturę (sekcja 'References'), odnośniki do innych funkcji  (sekcja 'See Also') oraz przykłady użycia (sekcja 'Examples'). Jeżeli podamy argument 'package', to uzyskamy pomoc dotyczącą wskazanego pakietu. Przykładowo aby wyświetlić opis pakietu 'MASS' należy użyć polecenia\linebreak 'help(package=MASS)'.
* Funkcja 'args("nazwaFunkcji")' wyświetla listę argumentów 'nazwaFunkcji'.
* Funkcje 'apropos(slowo)' i 'find(slowo)' wypisują listę funkcji (oraz obiektów), które w swojej nazwie mają podciąg 'slowo'.
* Funkcja 'example("nazwaFunkcji")' uruchamia skrypt z przykładami dla funkcji 'nazwaFunkcji'. Dzięki przykładom można szybko zobaczyć jak korzystać z danej funkcji, a także jakich wyników się należy spodziewać. Na dobry początek warto sprawdzić wynik polecenia 'example(plot)'.
* Funkcja 'help.search("slowoKluczowe")' przegląda opisy funkcji znajdujących się w zainstalowanych pakietach i wyświetla te funkcje, w których znaleziono wskazane 'slowoKluczowe'. W tym przypadku 'slowoKluczowe' może oznaczać również kilka słów lub zwrot. W liście wyników znajduje się również informacja, w którym pakiecie znajdują się znalezione funkcje.


Poniżej przedstawiona jest przykładowa sesja w programie R. Poszukujemy informacji o funkcji 'plot()' oraz o funkcjach do testowania hipotez. W pierwszej linii wyświetlamy pomoc dotyczącą funkcji plot(), następnie przykłady użycia funkcji plot(). Kolejna linia wyświetla funkcje ze słowem '"test"' w nazwie a ostania wyświetla nazwy funkcji ze zwrotem '"normality test"' w opisie.

```
?plot           
example(plot)   
apropos("test") 
help.search("normality test") 
```

Funkcje przedstawione powyżej wyszukują informacje na zadany temat wśród pakietów, które są już zainstalowane na komputerze. Jeżeli to okaże się niewystarczające (a może się zdarzyć, że nie mamy zainstalowanego pakietu, w którym znajduje się potencjalnie interesująca nas funkcja), to możemy skorzystać z zasobów dostępnych w Internecie.
W szczególności warto wiedzieć gdzie znaleźć:

* Internetowy kurs w języku polskim *Pogromcy Danych* dostępny pod adresem http://pogromcydanych.icm.edu.pl. Kurs podzielony jest na kilkanaście krótkich bloków z zadaniami pozwalającymi na sprawdzenie poziomu opanowania omawianego materiału.
* Forum *StackExchange* z licznymi pytaniami i setkami osób chętnych by na te pytania odpowiedzieć dostępne pod adresem http://stats.stackexchange.com/. 
* Poradniki (podręczniki, ang. *manuals*), poświęcone różnym aspektom programowania w programie R lub analizy danych w programie R. Dostępne są bezpośrednio z menu 'Help' w programie R oraz w Internecie pod adresem  http://cran.r-project.org/manuals.html. 
* R-bloggers, czyli agregator blogów poświęconych programowi R, często źródło wielu ciekawych informacji http://www.r-bloggers.com.
* Książki poświęcone pakietowi R oraz o analizie danych z użyciem tego pakietu. Aktualizowana lista książek na ten temat znajduje się online pod adresem  http://www.r-project.org/doc/bib/R-books.html.
* Portale z pytaniami i odpowiedziami dotyczącymi statystyki, programowania. Np. http://stats.stackexchange.com (pytania dotyczące statystyki) lub http://stackoverflow.com/questions/tagged/r (pytania dotyczące programowania).

Powyższe źródła są bez wyjątku angielskojęzyczne. Poza nimi w Internecie można znaleźć też wiele materiałów polskojęzycznych. Jednym z pierwszych jest *,,Wprowadzenie do środowiska R''* Łukasza Komsty \cite{komsta}, ale co roku przybywa wiele kolejnych pozycji.

Bardzo dobrą książką do nauki języka S jest książka Johna Chambersa \cite{SLanguage} a do nauki funkcji statystycznych dostępnych w programie S polecam pozycję Briana Everitta \cite{Everitt}. Uzupełnieniem do licznych pozycji książkowych jest olbrzymia liczba stron internetowych oraz dokumentów elektronicznych szczegółowo przedstawiających rozmaite aspekty programu i języka R. 

Pod koniec roku 2007 ukazała się bardzo obszerna i godna polecenia książka Michaela Crawleya \cite{Crawley} przedstawiająca zarówno język R jak i wiele procedur statystycznych zaimplementowanych w programie R. Pojawiają się też i będą się pojawiały liczne książki poświęcone specjalistycznym zastosowaniom programu R, jak np. świetna pozycja przygotowana przez Paula Murrella poświęcona grafice \cite{Rgrafika}, książka autorstwa Juliana Farawaya poświęcona modelom liniowym \cite{Rstat3}, czy kolejna pozycja Briana Everitta przedstawiająca podstawy statystyki \cite{Rstat2}. 

Wydawca Springer ma w ofercie ponad 45 książek o programie R wydanych w serii 'Use R!', każda z tych pozycji traktuje o jednym wybranym zagadnieniu, takim jak analizy danych przestrzennych, wizualizacja danych, analizy danych socjologicznych, genetycznych itp. 

