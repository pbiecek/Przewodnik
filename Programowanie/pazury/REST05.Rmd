# Co jeszcze warto wiedzieć o pakiecie opencpu?

## Serwis public.opencpu.org

Zdalne wykonanie funkcji można przećwiczyć na serwisie udostępnionym przez twórców tego pakietu na stronie  `public.opencpu.org`.

Oczywiście można korzystać tylko z funkcji w pakietach, które są tam zainstalowane.

```r
httr::POST("https://public.opencpu.org/ocpu/library/stats/R/rexp", 
           body = list(n = "2+12", rate= "1"))

# Wyniki można odczytać i wykorzystać jak w przypadku poprzednich analiz
# https://public.opencpu.org/ocpu/tmp/x0efb038db9/R
```

## Jak wywołać większy fragment kodu?

Używając funkcji `identity()` możemy wywołać cały blok instrukcji, przekazując je jako parametr funkcji - identyczność.

```r
httr::POST("https://public.opencpu.org/ocpu/library/base/R/identity", 
           body = list(x = "coef(lm(speed~dist, data=cars))"))

# Wyniki można odczytać i wykorzystać jak w przypadku poprzednich analiz
# https://public.opencpu.org/ocpu/tmp/x044bc7b4f3/R
```

## Linki 

Instrukcja jak zainstalować pakiet `opencpu` na prawdziwym serwerze (tutaj pracowaliśmy z lokalną instalacją) znajduje się tutaj: https://www.opencpu.org/download.html.

Szersza dokumentacja pakietu `opencpu` dostępna jest na stronie projektu https://www.opencpu.org/api.html#api-root.

# Zadania

Na podstawie pakietu `PogromcyDanych` przygotować usługę SaaS, która:

A. Dla wskazanej marki samochodu wyznacza tempo spadku ceny w kolejnych latach rysuje tę zmianę na wykresie.
B. Dla wskazanego rocznika i przebiegu wyznacza średnią cenę aut o danych parametrach.
C. Dla wskazanej marki samochodu i rocznika wyznacza 5 najtańszych aut z danej marki i danego rocznika.

Po zbudowaniu takiej usługi, warto spróbować uruchomić ją zdalnie z innego komputera.

