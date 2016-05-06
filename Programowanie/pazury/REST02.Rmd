# Jak pracować z opencpu?

Po uruchomieniu serwera można przez zapytania GET/POST wykonywac różne akcje. 

* Przez uchwyt `http://localhost:4348/ocpu/library/stats/` można sprawdzać obiekty udostępnia określony pakiet.
* Prez uchwyt `http://localhost:4348/ocpu/library/stats/R` można sprawdzać jakie funkcje udostępnia pakiet.
* Prez uchwyt `http://localhost:4348/ocpu/library/stats/data` można sprawdzać jakie zbiory danych udostępnia pakiet.


Komunikację z serwerem `opencpu` można przeprowadzić na wiele sposobów. Dla nas najciekawsze są trzy opcje.

* z użyciem przeglądarki internetowej (np. przez podane testowe API), 
* używajac programu `curl` z linii poleceń, wywołując np. polecenie 
`curl http://localhost:4348/ocpu/library/stats/data/`
* używając R i np funkcji `GET()` i `POST()` z pakietu `httr`

Ta ostatnia opcja pozwala nam tworzyć zarówn klienta jak i serwer w programie R.

Poniższy przykład wykorzystuje funkcję `httr::GET` aby sprawdzić listę dostępnych danych i a następnie pobrać źródło funkcji zainstalowanych na serwerze.

```
library(httr)
httr::GET("http://localhost:4348/ocpu/library/stats/data")
httr::GET("http://localhost:4348/ocpu/library/stats/R/rnorm")
httr::GET("http://localhost:4348/ocpu/library/proton/R/dcode")
```

## Formatowanie danych

Wyniki zdalnych wywołań mogą być obiektami różnych typów.  Server `opencpu` automatycznie konwertuje wynik na różne formaty, w zależności od wskaznaego sufixu.

Przykładowy zbiór danych o kotach i ptakach z pakietu `PogromcyDanych`  można przekonwertować na format json lub csv lub binarny rda korzystając z następujących uchwytów.

Wszystkie te uchwyty reagują na metodę GET.

* `http://localhost:4348/ocpu/library/PogromcyDanych/data/koty_ptaki/print`
* `http://localhost:4348/ocpu/library/PogromcyDanych/data/koty_ptaki/json`
* `http://localhost:4348/ocpu/library/PogromcyDanych/data/koty_ptaki/csv`
* `http://localhost:4348/ocpu/library/PogromcyDanych/data/koty_ptaki/rda`

## Formatowanie funkcji

Dla funkcji można w podony sposób odpytac dokumentacje funkcji lub pobrać ciało funkcji. Poniższe uchwyty reagują na metodę GET.

* `http://localhost:4348/ocpu/library/stats/R/rnorm`
* `http://localhost:4348/ocpu/library/stats/man/rnorm/`
* `http://localhost:4348/ocpu/library/stats/man/rnorm/text`
* `http://localhost:4348/ocpu/library/stats/man/rnorm/html`
* `http://localhost:4348/ocpu/library/stats/man/rnorm/pdf`
