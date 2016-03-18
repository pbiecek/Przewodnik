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
