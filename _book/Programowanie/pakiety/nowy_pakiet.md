# Jak stworzyć nowy pakiet?

Nowy pakiet najwygodniej budować używając funkcji `create()` z biblioteki `devtools`.

Na potrzeby tego rozdziału stworzymy nowy pakiet `kupPanAuto`. Aby stworzyć pusty pakiet o takiej nazwie potrzebne jest wywołanie.

```r
library(devtools)
create("kupPanAuto")
```

```
## Creating package kupPanAuto in .
## No DESCRIPTION found. Creating with values:
## Package: kupPanAuto
## Title: What the Package Does (one line, title case)
## Version: 0.0.0.9000
## Authors@R: person("First", "Last", email = "first.last@example.com", role = c("aut", "cre"))
## Description: What the package does (one paragraph).
## Depends: R (>= 3.2.2)
## License: What license is it under?
## LazyData: true
## Adding RStudio project file to kupPanAuto
```

Pierwszym argumentem funkcji `check()` jest ścieżka, w której należy stworzyć nowy pakiet. Ostatni element tej ścieżki (tutaj jedyny) to nazwa pakietu. Powyższa instrukcja w aktualnym katalogu stworzy podkatalog o nazwie `kupPanAuto` z minimalną liczbą niezbędnych plików.

![Struktura nowo utworzonego pakietu kupPanAuto](grafika/pakiet1.png)


## Plik *.proj

Funkcja `create()` tworzy automatycznie plik konfiguracyjny projektu RStudio. Jest on zapisany do pliku `*.proj`. 

Otwarcie takiego pliku w programie `RStudio` spowoduje otwarcie projektu z automatycznie ustawionym katalogiem roboczym na katalog pakietu.


## Plik DESCRIPTION

Każdy pakietu musi mieć plik `DESCRIPTION`, opisujący podstawowe informacje takie jak nazwa, opis, informacja o autorach i zależnościach od innych pakietów.

Nowo stworzony pakiet ma generyczny plik `DESCRIPTION`. 
Pierwszą rzeczą, którą należy zrobić po zbudowaniu pakietu to uzupełnienie informacji w tym pliku. 

W sekcji `Package` uzupełniamy nazwę pakietu, w sekcji `Title` jednozdaniowy opis pakietu, w sekcji `Authors` informację o autorach oraz ich roli przy tworzeniu pakietów. W sekcji `Description` uzupełniamy szerszy opis pakietu.

Szczególnie istotne są sekcje `Imports` i `Suggests`, opisują one zależności od innych pakietów. 

* Sekcja `Imports` wskazuje pakiety niezbędne do działania Twojego pakietu. R będzie je instalował przy instalacji Twojego pakietu.
* Sekcja `Suggests` wskazuje pakiety dodatkowe, które mogą rozszerzać możliwości Twojego pakietu, ale nie są niezbędne do działania kluczowych funkcjonalności.


![Plik DESCRIPTION nowo utworzonego pakietu kupPanAuto](grafika/pakiet2.png)

## Jak ustawiać zależności

Jeżeli w naszym pakiecie, chcemy korzystać z funkcji lub danych z innych pakietów, powinniśmy dodać odpowiednią zależność do pliku `DESCRIPTION`.

Możemy w tym celu wykorzystać funkcję `use_package()`, która dodaje informacje o zależnościach od wskazanych pakietach.

```r
use_package(package = "PogromcyDanych", pkg = "kupPanAuto")

## Adding PogromcyDanych to Imports
## Refer to functions with PogromcyDanych::fun()

use_package(package = "dplyr", pkg = "kupPanAuto")

## Adding dplyr to Imports
## Refer to functions with dplyr::fun()
```

