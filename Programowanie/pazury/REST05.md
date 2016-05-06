# Co jeszcze warto wiedzieć o pakiecie opencpu?

## Serwis public.opencpu.org

Zdalne wykonanie funkcji można przećwiczyć na serwisie udostępnionym przez twórców tego pakietu na stronie  `https://public.opencpu.org`.

Oczywiście można korzystać tylko z funkcji w pakietach, które są tam zainstalowane. Poniżej przedstawiamy przykład dla funkcji `rexp()`.

```r
httr::POST("https://public.opencpu.org/ocpu/library/stats/R/rexp", 
           body = list(n = "2+12", rate= "1"))
```
```
Response [https://public.opencpu.org/ocpu/library/stats/R/rexp]
  Date: 2016-05-06 19:01
  Status: 201
  Content-Type: text/plain; charset=utf-8
  Size: 184 B
/ocpu/tmp/x047f51b820/R/.val
/ocpu/tmp/x047f51b820/stdout
/ocpu/tmp/x047f51b820/source
/ocpu/tmp/x047f51b820/console
/ocpu/tmp/x047f51b820/info
/ocpu/tmp/x047f51b820/files/DESCRIPTION
```

Wyniki można odczytać i wykorzystać jak w przypadku poprzednich analiz
`https://public.opencpu.org/ocpu/tmp/x047f51b820/R`.


## Jak wywołać większy fragment kodu?

Używając funkcji `identity()` możemy wywołać cały blok instrukcji, przekazując je jako parametr funkcji - identyczność.

```r
httr::POST("https://public.opencpu.org/ocpu/library/base/R/identity", 
           body = list(x = "coef(lm(speed~dist, data=cars))"))
```
```
Response [https://public.opencpu.org/ocpu/library/base/R/identity]
  Date: 2016-05-06 19:02
  Status: 201
  Content-Type: text/plain; charset=utf-8
  Size: 184 B
/ocpu/tmp/x0a403fa4ec/R/.val
/ocpu/tmp/x0a403fa4ec/stdout
/ocpu/tmp/x0a403fa4ec/source
/ocpu/tmp/x0a403fa4ec/console
/ocpu/tmp/x0a403fa4ec/info
/ocpu/tmp/x0a403fa4ec/files/DESCRIPTION
```

Wyniki można odczytać i wykorzystać jak w przypadku poprzednich analiz
`https://public.opencpu.org/ocpu/tmp/x0a403fa4ec/R`.


## Linki 

Instrukcja jak zainstalować pakiet `opencpu` na prawdziwym serwerze (tutaj pracowaliśmy z lokalną instalacją) znajduje się tutaj: https://www.opencpu.org/download.html.

Szersza dokumentacja pakietu `opencpu` dostępna jest na stronie projektu https://www.opencpu.org/api.html#api-root.

# Zadania

Na podstawie pakietu `PogromcyDanych` przygotować usługę SaaS, która:

A. Dla wskazanej marki samochodu wyznacza tempo spadku ceny w kolejnych latach rysuje tę zmianę na wykresie.
B. Dla wskazanego rocznika i przebiegu wyznacza średnią cenę aut o danych parametrach.
C. Dla wskazanej marki samochodu i rocznika wyznacza 5 najtańszych aut z danej marki i danego rocznika.

Po zbudowaniu takiej usługi, warto spróbować uruchomić ją zdalnie z innego komputera.


