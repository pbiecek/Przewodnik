# Jak budować pakiet?

Cykl życia pakietu składa się z kilku kroków:
  
1. Funkcje i zbiory danych do pakietu są dostępne jako katalog na dysku
2. Funkcje, zbiory danych i ich dokumentacja jest dostępna jako katalog na dysku
3. Pakiet jest dostępny jako plik źródłowy `tar.gz` lub binarny `zip/tgz`
4. Pakiet jest zainstalowany (w katalogu z bibliotekami R)
5. Pakiet włączony w aktualnej sesji R.

Opisy z poprzednich rozdziałów pozwalają na zbudowanie pakietu w stanie z punktu 1. Poniżej pokażemy, jak przejsć do kolejnych kroków.

## Budowanie dokumentacji (-> 2.)

Dodanie opisów dla zbiorów danych czy funkcji w pikach R to jeszcze nie koniec tworzenia dokumentacji.
Należy ją teraz przeformatować z postaci Roxygen do plików `Rd` zrozumiałych przez program R.

W tym celu można wykorzystać funkcję `document()` z pakietu `devools`. Tworzy ona  pliki `Rd` na podstawie opisów roxugenowych w plikach `R`. Argumentem tej funkcji jest ścieżka do pakietu.

```
document("kupPanAuto")
```
```
## Updating kupPanAuto documentation
## Loading kupPanAuto
## First time using roxygen2 5.0.1. Upgrading automatically...
```

Po wykonaniu tej instrukcji odpowiednie pliki `Rd` są dodawane do katalogu `man`.

## Budowanie pakietu do postaci źródłowej (-> 3.)

Aby zbudować katalog z wszystkimi cześciami pakietu do jedengo pliku - postaci źródłowej pakietu należy wykorzystać funkcję `build()` z pakietu `devtools`.

Parametrem funkcji `build()` jest katalog w którym znajduje się pakiet do zbudowania. Domyślnie jest to aktualny katalog roboczy.

Poniższa instrukcja stworzy plik `kupPanAuto_0.0.0.9000.tar.gz` (do nazwy pakietu dodawany jest automatycznie numer wersji) źródłowy z zawartością pakietu. 

```r
build("kupPanAuto")
```

```
'/Library/Frameworks/R.framework/Resources/bin/R'  \
  --no-site-file --no-environ --no-save  \
  --no-restore CMD build  \
  '/Users/pbiecek/GitHub/Przewodnik/inne/kupPanAuto'  \
  --no-resave-data --no-manual 

* checking for file ‘/Users/pbiecek/GitHub/Przewodnik/inne/kupPanAuto/DESCRIPTION’ ... OK
* preparing ‘kupPanAuto’:
* checking DESCRIPTION meta-information ... OK
* checking for LF line-endings in source and make files
* checking for empty or unneeded directories
* building ‘kupPanAuto_0.0.0.9000.tar.gz’

[1] "/Users/pbiecek/GitHub/Przewodnik/inne/kupPanAuto_0.0.0.9000.tar.gz"
```

## Instalacja pakietu  (-> 4.)

Pakiety instalowane są w katalogu z bibliotekami R. Ścieżkę do tych katalogów można odczytać używając funkcji `.libPaths()`.


```r
.libPaths() 
```

```
## [1] "/Library/Frameworks/R.framework/Versions/3.2/Resources/library"
```

Aby zainstalować pakiet z pliku źródłowego lub z katalogu, można wykorzystać polecenie `install`.

Parametrem funkcji install() jest katalog w którym znajduje się pakiet do zbudowania. Domyślnie jest to katalog roboczy.

```r
install("kupPanAuto")
```

```
Installing kupPanAuto
'/Library/Frameworks/R.framework/Resources/bin/R' --no-site-file --no-environ --no-save --no-restore CMD  \
  INSTALL '/Users/pbiecek/GitHub/Przewodnik/inne/kupPanAuto'  \
  --library='/Library/Frameworks/R.framework/Versions/3.2/Resources/library' --install-tests 

* installing *source* package ‘kupPanAuto’ ...
** R
** preparing package for lazy loading
** help
*** installing help indices
** building package indices
** testing if installed package can be loaded
* DONE (kupPanAuto)
Reloading installed kupPanAuto
```

Pakiety można instalować z repozytorium CRAN poleceniem `install.packages()` a z repozytoriów GitHub poleceniem `install_github()`.

Poniższa instrukcja zainstaluje pakiet `proton` ze strony https://github.com/BetaAndBit/PieczaraPietraszki

```r
install_github("BetaAndBit/PieczaraPietraszki/protonENG")
```

## Włączanie pakietu (-> 5.)

Aby skorzystać z danych lub funkcji pakietu należy pakiet włączyć poleceniem `require()` lub `library()`. Ewentualnie można wykorzystywać operator dostępu `::` (lub ::: dla funkcji, które nie są publiczne).

```
library(kupPanAuto)
```
