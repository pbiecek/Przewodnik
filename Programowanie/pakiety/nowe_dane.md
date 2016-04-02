# Jak dodawać zbiory danych do pakietu?

W pakietach możemy również przechowywać dane. Jest to wygodne, jeżeli chcemy jeden lub kilka zbiorów danych udostępnić współpracownikom, studentom lub całej reszcie świata.

Dane do pakietu dodać można na dwa sposoby:

* Aby dodać zbiór danych do pakietu, wystarczy zapisać ten zbiór danych z użyciem funkcji `save()` do pliku z rozszerzeniem `rda` lub `RData`. Następnie ten plik należy wkopiować do katalogu `data` w pakiecie.
* Inna możliwość to użycie funkcji `use_data()` z pakietu `devtools`. Poniższe linijki wyliczają wektor ze średnimi cenami różnych marek aut, a następnie zapisują ten wektor do pakietu `kupPanAuto`.

```
library(PogromcyDanych)
srednieCeny <- tapply(auta2012$Cena.w.PLN, auta2012$Marka, mean, na.rm = TRUE)

use_data(srednieCeny, pkg = "kupPanAuto")
```

## Publiczne / prywatne zbiory danych

Wszystkie obiekty zapisane w katalogu `data` są wczytywane do R wraz z załadowaniem pakietu. Są one widoczne dla wszystkich funkcji pakietu.

Obiekty zapisane w pliku `sysdata.rda` (w jednym pliku można zapisać więcej niż jeden obiekt) są widoczne wyłącznie dla funkcji wewnątrz pakietu. Są na swój sposób prywatne.

Wszystkie pozostałe obiekty będą widoczne globalnie.

## Jak dokumentować zbiory danych?

Umieszczenie zbioru danych w pakiecie to jedno, opisanie użytkownikowi jak z niego korzystać to drugie.

Aby dodać dokumentację zbioru danych należy przygotować plik o rozszerzeniu `Rd` w katalogu `man`. Ale zamiast robić to ręcznie, lepiej skorzystać z pakietu `roxygen2`, który na bazie meta-opisu wygeneruje nam poprawny plik `Rd`. 

Pakiet `roxygen2` wymaga, by odpowiedni opis pakietu umieścić w pliku o rozszerzeniu `R` w katalogu `R`, a więc tam gdzie znajdują się opisy funkcji.

Pierwsza linia opisu traktowana jest jako tytuł pliku pomocy. Aby zaznaczyć, że jest to opis zbioru z danymi należy dodać parametr `@docType data`. Parametr `@name` określa pod jakim hasłem należy szukać danego pliku pomocy, zazwyczaj jest to nazwa zbioru danych. Inne parametry pozwalają na określenie struktury danych i opisanie zawartości poszczególnych składowych.

Poniższa ilustracja przedstawia przykładową dokumentację funkcji.

![Dokumentacja zbioru z danymi](pakiet4.png)

