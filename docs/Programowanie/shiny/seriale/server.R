library(shiny)
library(ggvis)
library(dplyr)
library(PogromcyDanych)

shinyServer(function(input, output) {
  mySerial <- reactive({
    serialeIMDB[serialeIMDB$serial == input$serial, ]
  })
  
  etykieta <- function(data){
    if(is.null(data)) return(NULL)
    if (is.null(data$id)) return(NULL)
    df <- isolate(mySerial())
    df2 <- df[df$id == data$id, ]
    paste0("<b>",df2$nazwa, " (S",df2$sezon, "/", df2$odcinek,")</b>",
           "<br>ocena: ",as.character(df2$ocena))
  }
  
  mySerial %>%
    ggvis(x = ~id, y = ~ocena, fill = ~sezon) %>%
    #     ewentualnie group_by(sezon)
    layer_smooths(stroke:="grey", strokeDash:=2) %>%
    layer_points(size := 100,
                 size.hover := 240,
                 fillOpacity := 0.5,
                 fillOpacity.hover := 0.9,
                 key := ~id) %>%
    hide_legend("fill") %>%
    hide_axis("x") %>%
    set_options(width = 640,padding = padding(10, 10, 50, 50)) %>%
    add_axis("x", title = "Numer odcinka", 
             properties = axis_props(
               grid = list(stroke = "white")      
             )) %>%
    add_tooltip(etykieta,"hover") %>%
    layer_model_predictions(model = "lm") %>%    
    bind_shiny("serialPlot")
  #--------------------------------------------------------------------------------------------------------------------
  output$opis = renderUI({
    ser <- mySerial()
    napis <- paste0("http://www.imdb.com/title/",ser$imdbId[1],"/epdate?ref_=ttep_ql_4")
    wsp <- lm(ocena~id, ser)$coef
    HTML("Dane o ocenach serialu <b>",as.character(ser$serial[1]),"</b> można pobrać ze strony <br/> <a href='", napis, "'>",napis,"</a><br><br>",
         "Trend dla tego serialu opisuje prosta o równaniu: <b>", signif(wsp[1], 2), ifelse(wsp[2] > 0, " + ", " "), signif(wsp[2], 2),"*odcinek</b>")
  })
})