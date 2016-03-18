## Jak umieszczać elementy kontrolujące w aplikacji?

Największą zaletą aplikacji Shiny jest ich responsywność. A więc nie tylko możemy oglądać wyniki raz zadeklarowanych analiz, ale ustawiając określone parametry aplikacji możemy oglądać wyniki dla różnych wariantów parametrów.

Przedstawimy to na przykładzie dwóch dodatkowych kontrolek w naszej aplikacji. 
Jedna kontrolka będzie opisywała który serial ma być analizowany, a druga określi czy ma być dorysowywana linia trendu dla poszczególnych sezonów.

Opisaną poniżej aplikację można zobaczyć pod adresem [Przewodnik/shiny2](http://mi2.mini.pw.edu.pl:8080/Przewodnik/shiny2). Kody źródłowe dostępne są pod adresem [github/shiny2](https://github.com/pbiecek/Przewodnik/tree/master/Programowanie/shiny/shiny2/).


Dodanie obsługi kontrolek również wymaga zmian w obu częściach opisujących aplikację. W pliku `ui.R` należy wskazać gdzie mają znaleźć się kontrolki i jakie wartości mogą one przyjmować. W pliku `server.R` nalży określić jak zachowanie aplikacji ma zależeć od wskazań użytkownika.


Zacznijmy do pliku `ui.R`. W poniższej deklaracji do lewego panelu dodano wywołania dwóch funkcji. 

* Funkcja `selectInput()` tworzy rozwijaną listę wyboru. W takiej liście należy określać jakie wartości są możliwe do wskazania (`choices`), jaka wartość powinna być domyślnie wybrana (`selected`) oraz do jakiego obiektu ma być zapisany wybór użytkownika (`inputId`).
* Funkcja `checkboxInput()` tworzy przycisk wyboru. Należy określić w nim jaka ma być początkowa wartość przycisku (`value`) oraz do jakiego obiektu ma być zapisany wybór użytkownika (`inputId`).

```
library(shiny)
library(PogromcyDanych)

nazwySeriali <- sort(levels(serialeIMDB$serial))

shinyUI(fluidPage(
  titlePanel("Oceny kolejnych odcinków seriali'"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "wybranySerial", 
                  label = "Wybierz serial do analizy",
                  choices = nazwySeriali,
                  selected = "Friends"),
      checkboxInput(inputId = "liniaTrendu",
                    label = "Czy zaznaczyć linię trendu?",
                    value = TRUE)
    ),
    mainPanel(
      plotOutput("trend"),
      verbatimTextOutput("model")
    )
  )
))
```

W pliku `server.R, wewnątrz funkcji `*Output` można odwoływać się do wartości kontrolki poprzez listę `input`. I tak `input$wybranySerial` będzie napisem określającym jaki serial użytkownik wybrał a `input$liniaTrendu` będzie wartością logiczną TRUE/FALSE określającą czy przycisk jest zaznaczony czy odznaczony.

Wewnątrz funkcji `*Output` można dowolnie odwoływać się do wartości kontrolek. Za każdym razem gdy użytkownik zmieni wartość kontrolki zostanie wykonane wszystkie funkcje, zawierające w swojej treści odwołania do zmienionej kontrolki. Wyniki tych funkcji zostaną przeliczone na nowo i uaktualnione w oknie aplikacji.

```
library(PogromcyDanych)
library(ggplot2)

shinyServer(function(input, output) {
  output$trend = renderPlot({
    serial <- serialeIMDB[serialeIMDB$serial == input$wybranySerial, ]
    
    pl <- ggplot(serial, aes(id, ocena, size=glosow, color=sezon)) +
      geom_point() + xlab("Numer odcinka")
    if (input$liniaTrendu) {
      pl <- pl + geom_smooth(se=FALSE, method="lm", size=3)
    }
    pl
  })
  
  output$model = renderPrint({
    serial <- serialeIMDB[serialeIMDB$serial == input$wybranySerial, ]
    
    summary(lm(ocena~id, serial))
  })
})
```

Przykład działania takiej aktualizacji można zobaczyć na stronie http://mi2.mini.pw.edu.pl:8080/Przewodnik/shiny2.

