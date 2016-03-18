## Jak tworzyć reaktywne elementy w aplikacji?

W poprzednich dwóch częściach pokazaliśmy jak umieszczać w aplikacji Shiny wykresy, tabele i inne wyniki, których treść w sposób interaktywny zmienia się po modyfikacji wartości kontrolek. 

Ale aplikacje Shiny mogą zawierać też rozmaite inne rozwiązania, takie jak panele, dodatkowe menu, elementy które pojawią się jedynie w określonych warunkach, wartości kontrolek zależne od wartości innych kontrolek. Na prawdę bardzo różne rozwiązania są możliwe przez co aplikacja Shiny pozwala na zbudowane rozbudowanego portalu analitycznego.

Poniżej przedstawimy wybrane ciekawsze rozwiązania oferowane przez Shiny, które wykraczały zakresem poza aplikację przedstawioną w poprzednim rozdziale.

Opisaną poniżej aplikację można zobaczyć pod adresem [Przewodnik/shiny3](http://mi2.mini.pw.edu.pl:8080/Przewodnik/shiny3). Kody źródłowe dostępne są pod adresem [github/shiny3](https://github.com/pbiecek/Przewodnik/tree/master/Programowanie/shiny/shiny3/).

Poniższy plik `ui.R` zawiera następujące rozszerzenia.

* Wywołanie funkcji `tags$head` pozwala na określenie jakie elementy mają się znaleźć dodatkowo w nagłówku strony HTML. Można tam umieścić odwołania do bibliotek JavaScript, można też umieścić pliki stylu CSS. Pozwala to całkowicie kontrolować wygląd aplikacji, można ją dowolnie dostosować do własnych potrzeb.
* Jeżeli chcemy by kontrolka aplikacji miała wartości zależne od innych kontrolek, możemy ją dynamicznie tworzyć za pomocą funkcji `htmlOutput()`. Typowym zastosowaniem jest lista wyboru, z elementami zależnymi od innej listy wyboru. Tutaj to lista nazw odcinków, która zależy od tego który serial jest wybrany.
* Wyniki są przedstawiane w różnych panelach. Zbiór paneli tworzy się funkcją `tabsetPanel()`, a zawartość poszczególnych paneli jest określana funkcją `tabPanel()`.


```
library(shiny)
library(PogromcyDanych)

nazwySeriali <- sort(levels(serialeIMDB$serial))

shinyUI(fluidPage(
  tags$head(tags$style(HTML("
                            .well {
                            background-color: #dd9999!important;
                            width: 200px;
                            }
                            "))),
  titlePanel("Oceny kolejnych odcinków seriali"),
  sidebarLayout(
    sidebarPanel(
      selectInput("wybranySerial", 
                  label = "Wybierz serial do analizy",
                  choices = nazwySeriali,
                  selected = "Friends"),
      checkboxInput("liniaTrendu",
                    "Czy zaznaczyć linię trendu?",
                    value = TRUE),
      htmlOutput("listaOdcinkow")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Wykres", 
                 p("Tak wyglądają oceny kolejnych odcinków serialu"), 
                 plotOutput("trend")),
        tabPanel("Model",
         p("Wyniki dpasowania modelu liniowego dla tego serialu."),
         verbatimTextOutput("model")
        )    
      )
    )
  )
))
```

Do pliku `erver.R` dodaliśmy następujące rozszerzenia. 

* Funkcja `reactive()` pozwala na budowanie tzw. reaktywnych wyrażeń. Takie wyrażenie może być użyte w różnych funkcjach `render*`. Korzyścią z używania reaktywnych wyrażeń jest to, że jego wartość jest liczona tylko raz, a następnie poszczególne funkcje korzystają z uprzednio policzonej wartości. Jeżeli więc różne wyniki korzystają z tych samych czasochłonnych wyliczeń, to dobrze je wcześniej wyłuskać z przez reaktywne wyrażenie.
* Funkcja `renderUI()` generuje automatycznie wartość listy wyboru. W tym przypadku wartości w tej liście wyboru zależą od wartości `input$wybranySerial`.

```
library(PogromcyDanych)
library(ggplot2)

shinyServer(function(input, output, session) {
  tylkoWybranySerial <- reactive({
    serialeIMDB[serialeIMDB$serial == input$wybranySerial, ]
  })
  
  output$listaOdcinkow <- renderUI({ 
    serial <- tylkoWybranySerial()

    selectInput("odcinki", "Odcinki w serialu", as.character(serial$nazwa) )
  })

  output$trend = renderPlot({
    serial <- tylkoWybranySerial()
    
    pl <- ggplot(serial, aes(id, ocena, size=glosow, color=sezon)) +
      geom_point() + xlab("Numer odcinka")
    if (input$liniaTrendu) {
      pl <- pl + geom_smooth(se=FALSE, method="lm", size=3)
    }
    pl
  })
  
  output$model = renderPrint({
    serial <- tylkoWybranySerial()
    
    summary(lm(ocena~id, serial))
  })
})
```

