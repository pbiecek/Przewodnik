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


