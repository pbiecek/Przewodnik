library(shiny)

shinyUI(fluidPage(
  titlePanel("Moja pierwsza aplikacja"),
  sidebarLayout(
    sidebarPanel(
      p("Tutaj jest lewy panel")
    ),
    mainPanel(
      br(),
      p("Tutaj jest prawy panel")
    )
  )
))
