# Dlaczego R? 
 
Język R jest dialektem języka S, który opracował John Chambers w Bell Labs w okolicach roku 1976. Język S powstał z myślą o interaktywnej analizie danych i wiele rozwiązań zostało wprowadzonych w ten język po to by ułatwić pracę z danymi.

Pierwsza wersja R została napisana w roku 1991 przez Roberta Gentlemana i Rossa Ihake (znanych jako R\&R:) pracujących na Wydziale Statystyki Uniwersytetu w Auckland. Pakiet R początkowo służył jako pomoc dydaktyczna do uczenia statystyki na tym uniwersytecie. Jednocześnie, ponieważ był to projekt otwarty, bardzo szybko zyskiwał na popularności. Od roku 1997 rozwojem R kierował zespół ponad dwudziestu osób nazywanych *core team*. W zespole tym znaleźli się eksperci z różnych dziedzin (statystyki, matematyki, metod numerycznych oraz szeroko pojętej informatyki) z całego świata. Liczba osób rozwijających R szybko rosła, a aktualnie rozwojem projektu kieruje fundacja ,,The R Foundation for Statistical Computing'' licząca setki aktywnych uczestników. Ponadto w rozwój R mają wkład tysiące osób z całego świata publikujące własne biblioteki/pakiety najróżniejszych funkcji znajdujących zastosowania w wielu dziedzinach. Liczba bibliotek dostępnych dla użytkowników R szybko rośnie, przekraczając w poprzednim roku liczbę 7000 pakietów dostępnych w głównym repozytorium CRAN. Do tej liczby trzeba doliczyć tysiące pakietów prywatnych lub umieszczonych w innych repozytoriach.

Program R jest projektem GNU opartym o licencje GNU GPL, oznacza to, iż jest w zupełności darmowy zarówno do zastosowań edukacyjnych jak i biznesowych. Więcej o licencji GNU GPL można przeczytać pod adresem https://pl.wikipedia.org/wiki/GNU_General_Public_License. 
Platforma R wyposażona jest w świetną dokumentację, dostępną w postaci dokumentów pdf lub stron html. Aktualnie dokumentacja ta w większości jest angielskojęzyczna, niektóre pliki pomocy mają już swoje lokalizacje, w tym polską.

Od początku język R był tworzony i rozwijany pod statystyków, z tego też powodu przez informatyków często nie był traktowany jak pełnowartościowy język, ale jak język domenowy (DSL, ang. *Domain Specific Language*). Z czasem jednak możliwości R rosły, pojawiło się coraz więcej rozwiązań wykraczających poza analizę danych i dziś R jest jednych z popularniejszych języków programowania.

Świadczyć może o tym ranking przygotowany na podstawie głosów członków komitetu IEEE (ang. *Institute of Electrical and Electronics Engineers*). W tym rankingu R został w roku 2016 wymieniony na 5. miejscu wśród najpopularniejszych języków, wyprzedzając takie tuzy jak PHP czy JavaScript.

![Ranking IEEE 2016](figures/Mjc5MjI0Ng.png)

Jest wiele powodów tej popularności języka R. Poniżej przedstawię te subiektywnie wybrane za najważniejsze.

* Z uwagi na swoje elastyczność dzisiaj jest to podstawowy język wykorzystywany w nauczaniu statystyki i analizy danych, obecny na praktycznie każdej dobrej uczelni.
* Program R pozwala na tworzenie i upowszechnianie pakietów zawierających nowe funkcjonalności. Obecnie dostępnych jest przeszło 7000 pakietów do różnorodnych zastosowań, np. `rgl` do grafiki trójwymiarowej, `lima` do analizy danych mikromacierzowych, `seqinr` do analizy danych genomicznych, `psy` z funkcjami statystycznymi popularnie wykorzystywanymi w psychometrii, `geoR` z funkcjami geostatystycznymi, `Sweave` do generowania raportów w języku `LaTeX` i wiele, wiele innych. Każdy możne napisać swój własny pakiet i udostępnić go innym osobom.
* Program R pozwala na wykonywanie funkcji z bibliotek napisanych w innych językach (C, C++, Fortran) oraz na wykonywanie funkcji dostępnych w programie R z poziomu innych języków (Java, C, C++, pakiety Statistica, SAS i wiele innych). Dzięki temu możemy np. znaczną część programu napisać w Javie, a R wykorzystywać jako dużą zewnętrzną bibliotekę funkcji statystycznych.
* Program R jest w zupełności darmowy do wszelkich zastosowań zarówno prywatnych, naukowych jak i komercyjnych. Również większość pakietów napisanych dla R jest darmowych i dostępnych w ramach licencji GNU GPL lub GNU GPL 2.0. 
* W programie R można wykonać wykresy o wysokiej jakości, co jest bardzo istotne przy prezentacji wyników. Wykresy te nawet przy domyślnych ustawieniach wyglądają znacznie lepiej od podobnych wykresów przygotowanych w innych pakietach.

Więcej o historii i kierunkach rozwoju języka R można przeczytać na stronie http://bit.ly/2domniT.
