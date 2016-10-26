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
