library(shiny)
library(PogromcyDanych)

nazwySeriali <- sort(levels(serialeIMDB$serial))

shinyUI(fluidPage(
  titlePanel("Oceny kolejnych odcinków seriali"),
  sidebarLayout(
    sidebarPanel(
      selectInput("wybranySerial", 
                  label = "Wybierz serial do analizy",
                  choices = nazwySeriali,
                  selected = "Friends"),
      checkboxInput("liniaTrendu",
                    "Czy zaznaczyć linię trendu?",
                    value = TRUE)
    ),
    mainPanel(
      plotOutput("trend"),
      verbatimTextOutput("model")
    )
  )
))
