# Jak pracować z potokami?

Przetwarzanie danych składa się najczęściej z wielu kroków. 
Wykonujemy operację A, później B, później C itp.

Ważne jest aby patrząc na kod R było łatwo zrozumieć
jakie operacje są wykonywane. 

Potoki to mechanizm wprowadzony niedawno do R,
ale który szybko zdobył wielu zwolenników,
ponieważ bardzo ułatwia pracę z przetwarzaniem danych.

## Problem cebulki

Aby przedstawić potoki rozpatrzy najpierw taką serię czterech instrukcji.


```r
library(dplyr)
library(PogromcyDanych)

# tylko volkswagen
tylkoVolkswagen <- filter(auta2012, 
                          Marka == "Volkswagen")
# posortowane
posortowaneVolkswagen <- arrange(tylkoVolkswagen, 
                                 Cena.w.PLN)
# tylko Golf VI
tylkoGolfIV <- filter(posortowaneVolkswagen, 
                      Model == "Golf", Wersja == "IV")
# tylko z małym przebiegiem
tylkoMalyPrzebieg <- filter(tylkoGolfIV, 
                            Przebieg.w.km < 50000)
```

W języku R można wynik jednej funkcji bezpośrednio przekazać jako argument kolejnej funkcji.
Z tego powodu, aby skrócić zapis często stosuje się zapis  ,,na wielką cebulkę''.

Mało czytelny, choć często spotykany zapis.


```r
tylkoMalyPrzebieg <- 
  filter(
    filter(
      arrange(
        filter(
          auta2012, 
          Marka == "Volkswagen"), 
        Cena.w.PLN), 
      Model == "Golf", Wersja == "IV"), 
    Przebieg.w.km < 50000)
```

Taką cebulkę czyta się od środka na zewnątrz. Najpierw wykonywane jest filtrowanie, później sortowanie, później jeszcze dwa razy sortowanie. 

Jednak taki zapis nie jest czytelny. Nazwy funkcji znajdują się z jednej strony a pozostałe argumenty po prawej stronie. Przy dłuższych cebulkach łatwo się pomylić, które argumenty są do których funkcji.

## Jak działa operator potoku?

Rozwiązaniem problemu cebulki jest stosowanie specjalnego operatora do przetwarzania potokowego `%>%`. Ten operator pochodzi z pakietu `magrittr`  (cytując z jego dokumentacji: *to be pronounced with a sophisticated french accent*)  i jest dostępny po włączeniu pakietu `dplyr`.

Instrukcja ` a %>% f(b) ` jest równoważna instrukcji` f(a, b)`.

Można też opisać go następująco: Operator przekazuje lewą stronę jako pierwszy argument funkcji wskazanej z prawej strony.

## Potoki w akcji

Cebulka, którą powyżej opisaliśmy powyżej może być zapisana równoważnie w następujący, znacznie bardziej czytelny, sposób.

Dla takich potoków, dodatkowo można zastosować operator przypisania `->` dzięki czemu kolejność czytania takiego potoku jest konsekwentnie od lewej do prawej.


```r
auta2012 %>%                                    # weź dane o autach
  filter(Marka == "Volkswagen") %>%             # pozostaw tylko Volkswageny
  arrange(Cena.w.PLN) %>%                       # posortuj malejąco po cenie
  filter(Model == "Golf", Wersja == "IV") %>%   # pozostaw tylko Golfy VI
  filter(Przebieg.w.km < 50000) ->              # pozostaw tylko auta o małym przebiegu
  tylkoMalyPrzebieg

head(tylkoMalyPrzebieg[,1:9])
```

```
##   Cena Waluta Cena.w.PLN Brutto.netto  KM  kW      Marka Model Wersja
## 1 4800    PLN       4800       brutto 150 110 Volkswagen  Golf     IV
## 2 7500    PLN       7500       brutto  75  55 Volkswagen  Golf     IV
## 3 8000    PLN       8000       brutto 100  74 Volkswagen  Golf     IV
## 4 8300    PLN       8300       brutto  NA  NA Volkswagen  Golf     IV
## 5 8500    PLN       8500       brutto  75  55 Volkswagen  Golf     IV
## 6 8500    PLN       8500       brutto 100  74 Volkswagen  Golf     IV
```

Funkcje z pakietu `dplyr` są tak zdefiniowane by pierwszym argumentem był zawsze zbiór danych. Przez to domyślne zachowanie operatora `%>%` pozwala na taki skrótowy zapis.

Dla funkcji, które zbiór danych przyjmują jako drugi lub kolejny argument można miejsce gdzie należy wstawić lewą stronę operatora `%>%` wskazać symbolem `.`.

W poniższym przykładzie zbiór danych `iris` zostanie wstawiony do jako argument `data=` ponieważ to miejsce wskazuje symbol `.`.


```r
iris %>%
  lm(Sepal.Length~Species, data=.) %>%
  coef
```

Wynikiem funkcji `lm()` jest model liniowy. Również on może być przekazany operatorem `%>%` dalej. 

Na powyższym przykładzie jest on przekazany do funkcji `coef()`. Jeżeli jest to jedyny argument tej funkcji, to można pominąć nawiasy, operatora `%>%` i tak będzie wiedział że należy tę funkcję wywołać.

