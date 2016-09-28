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
