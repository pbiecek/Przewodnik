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
