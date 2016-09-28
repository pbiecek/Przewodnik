library(shiny)
library(ggvis)
library(PogromcyDanych)

seriale <- sort(levels(serialeIMDB$serial))

shinyUI(fluidPage(
  tags$head(tags$style(HTML("
                            .ggvis-output-container {
                            margin-left: auto ;
                            margin-right: auto ;
                            width: 500px;
                            }
                            .shiny-html-output {
                            margin-left: auto ;
                            margin-right: auto ;
                            width: 500px;
                            }
                            .selectize-control {
                            margin-left: auto ;
                            margin-right: auto ;
                            width: 500px;
                            }
                            .control-label {
                            margin-left: auto ;
                            margin-right: auto ;
                            width: 500px;
                            }
                            .shiny-input-container {
                            margin-left: auto ;
                            margin-right: auto ;
                            width: 500px!important;
                            }
                            "))),
  fluidRow(selectInput("serial", "Jak wygląda popularność ulubionego serialu?", 
                       choices = seriale, 
                       selected = "Friends")),
  fluidRow(ggvisOutput("serialPlot")),
  fluidRow(htmlOutput("opis"))
  )
)
