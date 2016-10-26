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
