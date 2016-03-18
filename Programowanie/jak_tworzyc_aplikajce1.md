## Jak umieszczać wyniki analiz w aplikacji?

W poprzedniej części zobaczyliśmy jak wygląda struktura aplikacji. Jednak aplikacja, którą zbudowaliśmy nie nic ciekawego. 

Zbudujmy teraz aplikację, która coś liczy i wyświetla to coś na ekranie. W przypadku poniższej aplikacji wynikiem będą dwa elementy: wykres i opis modelu liniowego. 

Opisaną poniżej aplikację można zobaczyć pod adresem http://mi2.mini.pw.edu.pl:8080/Przewodnik/shiny1/. Kody źródłowe dostępne są pod adresem https://github.com/pbiecek/Przewodnik/tree/master/Programowanie/shiny/shiny1/.

Dodanie wyników do aplikacji wymaga zmiany obu części deklaracji aplikacji. W pliku `ui.R` należy określić gdzie ma zostać umieszczony określony wynik, a w pliku `server.R` należy określić jak ma być liczony.

Zacznijmy od pliku `ui.R`. 

Poniżej wklejamy uaktualnioną treść tego pliku. W miejscu gdzie tworzony jest prawy panel znalazły się wywołania dwóch funkcji 

* `plotOutput()`, wskazującej gdzie ma zostać umieszczony wykres o nazwie `trend`,
* `verbatimTextOutput()`, wskazującej gdzie ma zostać umieszczone opis obiektu o nazwie `model`.

Funkcje osadzające obiekty w interface html mają nazwy określające co jest osadzane (wykres, tabela, opis obiektu, strona html) i kończące się słowem `Output`.

```
library(shiny)

shinyUI(fluidPage(
  titlePanel("Oceny kolejnych odcinków serialu 'Przyjaciele'"),
  sidebarLayout(
    sidebarPanel(
      p("Tutaj jest lewy panel")
    ),
    mainPanel(
      plotOutput("trend"),
      verbatimTextOutput("model")
    )
  )
))
```

W pliku `server.R` muszą znaleźć się instrukcje tworzące obiekty `trend` i `model`. 

Treść tego pliku przedstawiona jest poniżej. Istotne deklaracje doklejane są do listy `output$`. W przypadku obiektu `trend` jest on produkowany przez wyrażenie przekazane do funkcji `renderPlot()`. To wyrażenie tworzy wykres z użyciem pakietu `ggplot2`.

W przypadku modelu liniowego jest on tworzony wewnątrz funkcji `renderPrint()`. 

```
library(PogromcyDanych)
library(ggplot2)

shinyServer(function(input, output) {
  output$trend = renderPlot({
    przyjaciele <- serialeIMDB[serialeIMDB$serial == "Friends", ]
    
    ggplot(przyjaciele, aes(id, ocena, size=glosow, color=sezon)) +
      geom_point() + xlab("Numer odcinka")
  })
  
  output$model = renderPrint({
    przyjaciele <- serialeIMDB[serialeIMDB$serial == "Friends", ]
    
    summary(lm(ocena~id, przyjaciele))
  })
})
```

