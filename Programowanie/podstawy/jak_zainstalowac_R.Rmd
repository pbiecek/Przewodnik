# Co trzeba zainstalować aby pracować z R?

Aby wygodnie pracować z programem R potrzebujemy wykonać trzy kroki.

Pierwszy krok, to zainstalowanie podstawowego środowiska R, na które składa się interpreter i podstawowy zbiór pakietów.
Już ten zestaw już ma potężne możliwości w większości przypadków wystarczające do analizy danych, rysowania wykresów i wykonywania innych typowych zadań. 

Drugi krok, to instalacja edytora RStudio, narzędzia, które bardzo ułatwia prace z programem R. Nie jest to jedyny edytor dla R, ale z obecnych dzisiaj na rynku jest najlepszym rozwiązaniem. Podobnie jak R również ten edytor w wersji podstawowej jest dostępny bezpłatnie.

Trzeci i ostatni krok, to doinstalowanie dodatkowych pakietów z przydatnymi funkcjami. Aktualnie dostępnych jest ponad siedem tysięcy  pakietów! Nie ma jednak potrzeby instalowania ich wszystkich od razu. Z reguły w miarę używania okazuje się, że przydałaby się nam jakaś dodatkowa funkcja, która jest już dostępna w pewnym pakiecie i dopiero wtedy warto taki pakiet doinstalować.

Poniżej znajduje się krótka informacja jak łatwo przebrnąć przez oba etapy instalacji.

## Instalacja podstawowego środowiska R

Dla większości systemów operacyjnych, w tym wszystkich dystrybucji Linuxa, Unixa, dla wersji Windowsa począwszy od Windowsa 95 i dla MacOSa, pakiet R jest dostępny w postaci źródłowej lub skompilowanej na określony system. 

Obecnie aktualna wersja R to 3.3.1. Co roku w kwietniu wypuszczana jest kolejna duża wersja 3.x, czyli niedługo będziemy cieszyć się wersją 3.4.0. W trakcie roku w miarę potrzeb wypuszczane są podwersje. Program R szybko się rozwija i warto przynajmniej raz do roku aktualizować go do najnowszej dostępnej wersji. 

Instalacja jest prosta, wystarczy otworzyć stronę `https://cran.r-project.org/`, wybrać system operacyjny i pobrać plik binarny do instalacji.
Instalacja sprowadza się do klikania przycisku *Next, next, next*.
Można mieć zainstalowanych jednocześnie kilka różnych wersji R. Przechowywanie starszych wersji programu R może być wygodne, jeżeli chcemy mieć prostą możliwość odtworzenia w przyszłości dokładnie tych samych wyników co na wersji obecnej.

W przypadku instalacji na nietypowych platformach można posiłkować się szczegółową instrukcją instalacji dostępną na stronie https://cran.r-project.org/doc/manuals/R-admin.html.

> Wygodną właściwością środowiska R jest to, że można je uruchamiać bez instalowania. Można więc skopiować środowisko R na płytę CD, na pendrive lub dysk przenośny i uruchamiać na dowolnym komputerze bez potrzeby instalacji.

Trudno jest podać minimalne wymagania sprzętowe niezbędne do działania R. Wersję podstawową można bez problemu zainstalować na wieloletnich maszynach z 256MB RAM, procesorach klasy Pentium lub wyższej i kilkadziesiąt MB miejsca na dysku twardym.
O ile jednak wersja podstawowa jest lekka, to instalacja dodatkowych pakietów może wymagać kilku GB pamięci RAM lub miejsca na dysku. Szczególnie pakiety z dużymi danymi genomicznymi potrafią dużo ważyć.

> Osoby używające programu R do bardzo wymagających obliczeniowo analiz powinny raczej używać OSXowej, Linuxowej lub Unixowej wersji R. W tych systemach operacyjnych zarządzanie pamięcią jest wydajniejsze przez co R działa  (odrobinę) szybciej. Dla unixów dostępne są też dodatkowe narzędzia pozwalające na wykorzystanie wielowątkowości i innych mechanizmów systemowych (np. funkcji `fork()`).

![Strona https://cran.r-project.org/ z której można pobrać program R skompilowany dla najpopularniejszych systemów operacyjnych.](figures/Rbase.png)


## Jak zainstalować RStudio?

RStudio jest narzędziem ułatwiającym pracę z R. Jest to edytor, manager wersji, narzędzie wspierające debugowanie, tworzenie pakietów, aplikacji czy raportów. Można żyć bez tej nakładki, ale co to za życie.

Najnowszą wersję RStudio Desktop można pobrać ze strony http://www.rstudio.com/products/rstudio/download/.

Nie musimy pamiętać tego adresu, wystarczy wpisać w Google *R Studio download* a powyższy adres będzie pierwszym linkiem.

Praca z RStudio jest znacznie przyjemniejsza gdy nauczymy  się kilku podstawowych skrótów klawiszowych. Pełną listę skrótów można znaleźć pod adresem: 
https://www.rstudio.com/wp-content/uploads/2016/01/rstudio-IDE-cheatsheet.pdf

Najprzydatniejsze skróty to:

* Ctrl+1-9, przełączanie pomiędzy oknami aplikacji
* Ctrl/Cmd+UP, historia komend
* Ctrl+L, czyści konsolę
* Tab, uzupełnianie kodu
* Ctrl/Cmd+Shift+C, komentowanie linii lub zbioru linii kodu
* Ctrl/Cmd+ENTER, wykonanie zaznaczonego kodu w konsoli.


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

