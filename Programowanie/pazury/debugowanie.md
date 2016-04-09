# Jak debugować kod R? 

Często zdarza się, że kod R działa inaczej niż się spodziewamy.

Lub, że kiedyś działał tak jak chcieliśmy, ale na skutek zmiany jakiejś zależności przestał działać.

Czasem naprawdę trudno zrozumieć co jest przyczyną błędu, ponieważ nawet (wydawałoby się) podstawowe operacje mogą prowadzić do dziwnych zachowań.

Prześledźmy poniższy przykład. Czy nie widząc odpowiedzi, łatwo było przewidzieć jakie litery się wyświetlą na koniec?


```r
(sekwencja <- seq(0.7, 1, by=0.1))
```

```
## [1] 0.7 0.8 0.9 1.0
```

```r
(indeksy <- sekwencja*10 - 6)
```

```
## [1] 1 2 3 4
```

```r
LETTERS[indeksy]
```

```
## [1] "A" "A" "C" "D"
```

O co chodzi? Otóż nie należy indeksować wektorów liczbami rzeczywistymi, bo to igranie z precyzją numeryczną.


## Gdy coś pójdzie źle poza konsolą?

RStudio ułatwia debugowanie kodu. Ale co zrobić, jeżeli problem występuje w pracy z kodem zrównoleglonym, lub uruchomionym na jakimś serwerze HPC bez graficznego środowiska?

W takim przypadku użyteczną funkcją jest `dump.frames()`. W momencie uruchomienia zapisuje wszystkie otwarte ramki do pliku. 

Funkcja `option()` pozwala na określenie rożnych globalnych parametrów. Akurat parametr `error` opisuje co ma się wydarzyć, jeżeli interpreter R napotka na błąd. Poniższy przykład definiuje nowe zachowanie: jeżeli wystąpi błąd, wszystkie informacje o błędzie należy zapisać do pliku `errorDump`.


```r
options(error=quote(dump.frames("errorDump",TRUE)))
```

Poniższy przykład definiuje funkcje, która wygeneruje błąd jeżeli za argument podać napis.

```
funkcja <- function(x) {
  log(x)
}
funkcja("napis")
## log: Using log base e.
## Error in log(x) : Non-numeric argument to mathematical function
## Execution halted
```

Efektem ubocznym jest utworzenie pliku `errorDump.rda` z zapisanymi przestrzeniami nazw w chwili gdy wystąpił błąd. Te dane można wczytać funkcją `load()` a następnie funkcją `debugger()` można odtworzyć stan z chwili gdy wystąpił błąd.

```
load("errorDump.rda")
debugger(errorDump)
```

Aby wyczyścić instrukcje zapisujące przestrzeń nazw przy każdym błędzie wystarczy za argument `error` podać `NULL`.

```
options(error=NULL)
```

## Automatyczny start debuggera

Jeżeli pracujemy w trybie interaktywnym i każdy błąd lubimy przeanalizować, to wygodne będzie ustawienie funkcji `recover()` jako funkcji do wywołania po wystąpieniu błędu.

```
options(error = recover)
```

W najnowszych wersjach RStudio automatycznie pojawia się opcja włączenia interaktywnego debugera jeżeli tylko wystąpi jakiś błąd. Ale w starczych, lub gdy pracujemy na zdalnej konsoli, ta opcja jest wciąż przydatna.


## traceback()

Funkcja `traceback()` pozwala na analizę *post mortem*. Błąd się wydarzył, nasz program się przerwał, używając tej funkcji możemy wypisać listę ramek otwartych w chwili gdy pojawił się błąd.

## debug() / undebug()

Jeżeli funkcja nie generuje błędu, ale zachowuje się inaczej niż byśmy chcieli, to do prześledzenia jej wykonania krok po kroku można wykorzystać funkcję `debug()` (debugowanie wyłącza się funkcją `undebug()`). 

Funkcja `debug()` dodaje specjalny znacznik debugowania do funkcji. Za każdym razem gdy ta funkcja zostanie wywołana, włącza się interaktywne przetwarzanie linia po linii wybranej funkcji. 

```
funkcja2 <- function(x,y) {
  funkcja(x)
  funkcja(y)
}
debug(funkcja2)
funkcja2(1, "jeden")
```

## try() / tryCatch()

Wystąpienia błędu czasem nie sposób przewidzieć.
Ale to co można zrobić to określić jak ma wyglądać zachowanie R gdy błąd się pojawi.

Do tego celu można wykorzystać funkcję `try()` lub `tryCatch()`.

Jest ona wygodna, gdy np. uruchamiamy określony fragment kodu wielokrotni, np. równolegle, i liczymy się z tym, że któreś uruchomienie może zakończyć się błędem (pobieranie złej strony www).
Jeżeli nie chcemy by błąd przerywał całość obliczeń, to dobrym rozwiązaniem jest jego przechwycenie.

Można do tego wykorzystać funkcja `try()` i `tryCatch()`.

Poniższa instrukcja wywoła w sposób bezpieczny funkcję `funkcja2(1, "jeden")`. Argument `silent=TRUE` oznacza, że nawet jeżeli błąd wystąpi to należy go zignorować. W takim jednak przypadku wynikiem funkcji `try()` będzie obiekt klasy `try-error`.

```
try(funkcja2(1, "jeden"), silent=TRUE)
```

## browser()

Funkcję `browser()` można umieszczać w środku innych funkcji lub bloku kodu. Gdy zostanie uruchomiona w wyniku otworzy bieżące środowisko i pozwoli na odpytanie stanu zmiennych w nim.


## Debugowanie w RStudio

RStudio posiada rozbudowane wsparcie dla debugowania, czy to zwykłych skryptów czy np. aplikacji shiny. W dowolnej linii kodu R można założyć pułapkę, gdy interpreter przeczyta ten fragment kodu to przerwanie skryptu zostanie przerwane i użytkownik ma opcje by prześledzić co się dzieje w określonym miejscy.

Więcej o debugowaniu w RStudio można przeczytać w pliku https://support.rstudio.com/hc/en-us/articles/205612627-Debugging-with-RStudio

## Pokrycie testów

Dobrym sposobem na możliwie rzadkie używanie debuggera, jest pisanie dobrych i wielu testów jednostkowych.

Jak tworzyć testy - pisaliśmy to w rozdziale o pakietach. 

Aby sprawdzić jak dokładnie testy pokrywają kod pakietu, można wykorzystać pakiet `covr` i funkcje `package_coverage()`. Przedstawia ona tekstową analizę jaka część funkcji jest weryfikowana. Funkcje, które nie są wystarczająco pokryte testami warto uzupełnić.


```r
library(covr)
x <- package_coverage("~/GitHub/archivist")
x
```

```
## archivist Coverage: 40.46%
```

```
## R/addArchivistHooks.R: 0.00%
```

```
## R/addTagsRepo.R: 0.00%
```

```
## R/ahistory.R: 0.00%
```

```
## R/asession.R: 0.00%
```

```
## R/atags.R: 0.00%
```

```
## R/cache.R: 0.00%
```

```
## R/getTags.R: 0.00%
```

```
## R/restoreLibraries.R: 0.00%
```

```
## R/rmFromRepo.R: 0.00%
```

```
## R/shinySearchInLocalRepo.R: 0.00%
```

```
## R/extractData.R: 1.16%
```

```
## R/extractMiniature.R: 20.00%
```

```
## R/extractTags.R: 22.39%
```

```
## R/summaryRepo.R: 53.19%
```

```
## R/loadFromRepo.R: 56.25%
```

```
## R/getRemoteHook.R: 58.62%
```

```
## R/zipRepo.R: 60.00%
```

```
## R/splitTags.R: 72.22%
```

```
## R/asearch.R: 76.00%
```

```
## R/zzz.R: 76.47%
```

```
## R/alink.R: 79.49%
```

```
## R/showRepo.R: 80.00%
```

```
## R/deleteRepo.R: 81.25%
```

```
## R/copyToRepo.R: 83.72%
```

```
## R/magrittr.R: 88.71%
```

```
## R/saveToRepo.R: 88.89%
```

```
## R/searchInRepo.R: 91.30%
```

```
## R/setRepo.R: 94.12%
```

```
## R/aread.R: 94.44%
```

```
## R/createEmptyRepo.R: 94.74%
```

```
## R/archivistOptions.R: 100.00%
```

```
## R/createMDGallery.R: 100.00%
```
