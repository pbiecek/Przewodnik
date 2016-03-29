## Jak zbudować pierwszą aplikację

Aplikacja Shiny składają się z dwóch części, które zazwyczaj opisuje się w dwóch osobnych plikach. Jedna część opisuje interface użytkownika (plik `ui.R`), druga opisuje sposób przetwarzania danych (plik `server.R`). 

Zacznijmy od określenia pierwszej prostej aplikacji. Jej działanie można zobaczyć na stronie [Przewodnik/shiny0](http://mi2.mini.pw.edu.pl:8080/Przewodnik/shiny0/). Nie robi ona nic poza wyświetleniem tytułu i dwóch napisów.

Źródła tej aplikacji są dostępne pod adresem  [github/shiny0](https://github.com/pbiecek/Przewodnik/tree/master/Programowanie/shiny/shiny0) oraz przedstawione są poniżej.

Plik `ui.R` wygląda następująco. Zagnieżdżona struktura funkcji odpowiada zagnieżdżeniu elementów HTML w aplikacji. Funkcja `titlePanel()` odpowiada za określenie tytułu. Funkcja `sidebarLayout()` odpowiada za stworzenie podziału strony na lewy i prawy panel. Funkcja `p()` i `br()` tworzą następnie HTMLowe tagi `<p></p>` oraz `<br/>`.

```
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
```

Ta aplikacja nie wymaga przetwarzana żadnych danych, dlatego też treść pliku `server.R` jest krótka, zawiera tylko pustą deklaracje utworzenia serwera Shiny.

```
shinyServer(function(input, output) {
})
```

Aby odtworzyć tę aplikacje na własnym komputerze należy w katalogu stworzyć dwa pliki `ui.R` i `server.R` a następnie przekopiować do nich powyżej przedstawione treści. Po otwarciu tych plików w programie RStudio w prawym górnym rogu powinna pojawić się ikonka `Run App`, której kliknięcie uruchomi aplikację. Inną możliwością uruchomienia aplikacji jest wywołanie funkcji `shiny::runApp()` ze wskazaniem katalogu w którym znajdują się oba pliki.

Uruchomienie aplikacji przez program RStudio spowoduje, że działa ona na lokalnym komputerze. Wgranie obu plików na serwer, na którym zainstalowana jest aplikacja [Shiny Server](https://www.rstudio.com/products/shiny/shiny-server2/) spowoduje, że będziemy mogli tę aplikację udostępnić również innym użytkownikom.

Więcej o podstawowej strukturze aplikacji Shiny, oraz o tym jak stworzyć i uruchomić pierwszą aplikację, przeczytać można na stronie 
http://shiny.rstudio.com/tutorial/lesson1/.
