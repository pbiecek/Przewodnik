# Jak tworzyć interaktywne wykresy?

Najłatwiejszy sposób aby budować interaktywne wykresy w R, to skorzystanie z pakietu `rCharts` (http://rcharts.io/).

Pakiet rCharts tworzy stronę HTML z osadzonymi bibliotekami JavaScript. Można korzystać z bibliotek `NVD3`, `Highcharts`, `Leaflet` i innych. Pełna lista znajduje się na stronie pakietu `rCharts`.

Poniżej przedstawimy kilka wybranych przykładów.
Szczegółowa lista dostępnych opcji znajduje się na [tej stronie](http://www.rpubs.com/dnchari/rcharts).

# Biblioteka `NVD3`

Wykresy wykorzystujące bibliotekę NVD3 można wykonać używać funkcji `nPlot()`. 
Szeroki opis dostępnych wykresów w tej bibliotece znajduje się tutaj http://nvd3.org/.

## Wykres liniowy

Przedstawmy wykres liniowy na bazie danych o śmiertelności osób w różnych wieku. 
Dane pochodzą ze strony http://www.mortality.org/. Szczegółowy opis co znajduje się w której kolumnie znajduje się na [na tej stronie](http://www.mortality.org/Public/ExplanatoryNotes.php#CompleteDataSeries).


Wybierzemy tylko dane z roku 2009 i pokażemy wyniki dla obu płci.
Zacznijmy od wczytania danych.


```r
przezycia <- archivist::aread("pbiecek/Przewodnik/arepo/609491e5ec491f240cbeafe377743e21")  
head(przezycia)
```

```
##   Year Age      mx      qx   ax     lx   dx    Lx      Tx    ex Gender
## 1 1958   0 0.06562 0.06249 0.24 100000 6249 95231 6863376 68.63 Female
## 2 1958   1 0.00474 0.00472 0.50  93751  443 93530 6768146 72.19 Female
## 3 1958   2 0.00173 0.00173 0.50  93308  162 93228 6674616 71.53 Female
## 4 1958   3 0.00119 0.00119 0.50  93147  111 93091 6581388 70.66 Female
## 5 1958   4 0.00085 0.00085 0.50  93036   79 92996 6488297 69.74 Female
## 6 1958   5 0.00071 0.00071 0.50  92957   66 92924 6395301 68.80 Female
```

```r
przezycia2009 <- przezycia[przezycia$Year == 2009 &
                             przezycia$Age != "110+",]
```

Przystępujemy do tworzenia wykresu. 

Po zbudowaniu wykresu funkcją `nPlot()`, należy dookreślić szerokość i wysokość wykresy oraz nazwy osi. 


```r
library(rCharts)
p1 <- nPlot(mx ~ Age, group = "Gender", data = przezycia2009, type = "lineChart")
p1$chart(yScale = "#! d3.scale.log() !#")
p1$xAxis(axisLabel = 'Wiek')
p1$yAxis(axisLabel = 'Śmiertelność')
p1$set(width = 750, height = 590)
# p1$save("rCharts1.html", standalone=TRUE)
```

Następnie wykres jest gotowy do umieszczenia na stronie www. 
Wykres jest stroną html, można ją umieścić na innej stronie poleceniem `iframe`.

<iframe style="width:780px; height:620px" src="https://rawgit.com/pbiecek/Przewodnik/master/Wizualizacja/rCharts1.html">
</iframe>

## Wykres punktowy

Ta sama funkcja może być użyta do zbudowania wykresu punktowego. Wystarczy jako typ wskazać `type="scatterChart"`.

Na poniższym przykładzie pracujemy z danymi o współczynniku liczby zgonów i urodzin na 1000 mieszkańców w różnych krajach. 
Dodatkowo pokazane jest jak można modyfikować informację o etykiecie.


```r
library(SmarterPoland)
head(countries)
```

```
##               country birth.rate death.rate population continent
## 1         Afghanistan       34.1        7.7      30552      Asia
## 2             Albania       12.9        9.4       3173    Europe
## 3             Algeria       24.3        5.7      39208    Africa
## 4             Andorra        8.9        8.4         79    Europe
## 5              Angola       44.1       13.9      21472    Africa
## 6 Antigua and Barbuda       16.5        6.8         90  Americas
```

```r
p2 <- nPlot(death.rate ~ birth.rate, group = "continent", data = countries, type = "scatterChart")
p2$xAxis(axisLabel = 'Zgonów na 1000 osób')
p2$yAxis(axisLabel = 'Urodzin na 1000 osób')
p2$chart(tooltipContent = "#! function(key, x, y, e){ 
  return 'Kraj: ' + e.point.country 
} !#")
p2$set(width = 750, height = 590)
# p2$save("rCharts2.html", standalone=TRUE)
```

<iframe style="width:780px; height:620px" src="https://rawgit.com/pbiecek/Przewodnik/master/Wizualizacja/rCharts2.html">
</iframe>

# Biblioteka `MorrisJS`

Biblioteka MorrisJS udostępnia inne ciekawe wykresy, głównie liniowe i słupkowe. Przegląd wykresów z tej biblioteki znajduje się na stronie http://morrisjs.github.io/morris.js/


```r
library(tidyr)
eZycia <- przezycia %>%
  dplyr::filter(Age == 0) %>%
  dplyr::mutate(Year = as.character(Year)) %>%
  dplyr::select(Year, Gender, ex) %>%
  spread(Gender, ex)
head(eZycia)
```

```
##   Year Female  Male
## 1 1958  68.63 63.03
## 2 1959  68.34 62.62
## 3 1960  70.63 64.81
## 4 1961  70.81 64.86
## 5 1962  70.54 64.55
## 6 1963  71.52 65.41
```

```r
m1 <- mPlot(x = 'Year', y = c('Female', 'Male'), type = 'Line',
  data = eZycia, pointSize = 0, lineWidth = 1)
m1$set(width = 750, height = 590)
# m1$save("rCharts3.html", standalone=TRUE)
```

<iframe style="width:780px; height:620px" src="https://rawgit.com/pbiecek/Przewodnik/master/Wizualizacja/rCharts3.html">
</iframe>

# Biblioteka `Leaflet`

Biblioteka `Leaflet` jest świetnym narzędzie do przedstawiania danych na mapach. 

Wystarczy skazać współrzędne początkowego widoku, dodać markery i można pokazywać interaktywną mapę.


```r
map1 = Leaflet$new()
map1$setView(c(52.22, 21), zoom = 12)
map1$marker(c(52.22223, 21.00728), bindPopup = "Politechnika Warszawska, MiNI")
map1$marker(c(52.21167, 20.9815), bindPopup = "Uniwersytet Warszawski, MIM")
map1$marker(c(52.23925, 21.01742), bindPopup = "Uniwersytet Warszawski, Centrala")
# map1$save("rCharts4.html", standalone=TRUE)
```

<iframe style="width:780px; height:620px" src="https://rawgit.com/pbiecek/Przewodnik/master/Wizualizacja/rCharts4.html">
</iframe>

# Więcej

Kompletna lista wykresów wspieranych przez pakiet rCharts znajduje się na stronie http://www.rpubs.com/dnchari/rcharts.

