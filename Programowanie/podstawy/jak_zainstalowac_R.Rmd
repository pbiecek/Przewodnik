# Jak zainstalować R / RStudio / rozpocząć pracę z R Studio?

Aby wygodnie pracować w R powinniśmy 

1. Zainstalować R,
2. Zainstalować wygodny edytor, np. RStudio,
3. Zainstalować niezbędne biblioteki dodatkowe.

## Jak zainstalować R?

Obecnie aktualna wersja R to 3.2.4. Co roku w kwietniu wypuszczana jest kolejna wersja 3.x, czyli niedługo będziemy cieszyć się 3.3.0 (którą można już instalować, przy czym na razie ma status 'deweloperska'). W trakcie roku w miarę potrzeb wypuszczane są podwersje.

Najnowszą wersję R najlepiej zainstalować ze strony https://cran.r-project.org/. 
Instalacja sprowadza się do klikania *next, next, next*.

Program R jest całkowicie bezpłatny do wszelkich zastosowań, edukacyjnych, przemysłowych, biznesowych, komercyjnych i hobbystycznych. Program R jest dostępny na licencji [GNU GPL](https://pl.wikipedia.org/wiki/GNU_General_Public_License).

## Jak zainstalować RStudio?

Najnowszą wersję RStudio Desktop można pobrać ze strony http://www.rstudio.com/products/rstudio/download/.

Nie musimy pamiętać tego adresu, wystarczy wpisać w Google *R Studio download* a powyższy adres będzie pierwszym linkiem.

## Jak zainstalować dodatkowe pakiety?

Po zainstalowaniu R i RStudio mamy dostęp do podstawowych funkcjonalności. Olbrzymia siła R tkwi w tysiącach dodatkowych bibliotek / pakietów, rozwijanych przez tysiące deweloperów na całym świecie.

Aby zainstalować nowy pakiet z oficjalnego repozytorium CRAN należy użyć funkcji `install.packages()`. Jej wywołanie zainstaluje na dysku wskazany pakiet i wszystkie pakiety zależne. 

Aby włączyć dany pakiet w obecnej sesji R, tak by wykorzystywać dostępne w nim funkcje, należy użyć funkcji `library`.

Przykłady w kolejnych rozdziałach w znakomitej większości są oparte o pakiet `PogromcyDanych`.

```
# Wywołaj tylko raz aby zainstalować pakiet i zależności
install.packages("PogromcyDanych")

# Włącz za każdym razem gdy na nowo uruchamiasz R, jeżeli chcesz skorzystać z funkcji/zbiorów danych z tego pakietu.
library(PogromcyDanych)
```

Jeżeli nie CRAN to co?

Poza oficjalnym repozytorium kodu na serwerach CRAN, wiele pakietów jest dostępnych w wersji deweloperskiej np. na serwerach GitHub (lub innych, ale GitHub jest najpopularniejszy).

Aby zainstalować pakiet z GitHuba można wykorzystać funkcję `install_github()` z pakietu `devtools`.

```
library(devtools)

install_github("pbiecek/PogromcyDanych")
```
