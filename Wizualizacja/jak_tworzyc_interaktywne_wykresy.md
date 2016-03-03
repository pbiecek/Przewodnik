# Jak tworzyć interaktywne wykresy?

Najłatwiejszy sposób aby budować interaktywne wykresy w R, to skorzystanie z pakietu `rCharts` (http://rcharts.io/).

Pakiet rCharts tworzy stronę HTML z osadzonymi bibliotekami JavaScript. Można korzystać z bibliotek `NVD3`, `Highcharts`, `Leaflet` i innych. Pełna lista znajduje się na stronie pakietu.

Poniżej przedstawimy kilka wybranych przykładów.
Szczegółowa lista dostępnych opcji znajduje się na [tej stronie](http://www.rpubs.com/dnchari/rcharts).

## NVD3

Wykresy wykorzystujące bibliotekę NVD3 można wykonać używać funkcji `nPlot()`. 
Szeroki opis dostępnych wykresów w tej bibliotece znajduje się tutaj http://nvd3.org/.

## Wykres liniowy

Przedstawmy wykres liniowy na bazie danych o śmiertelności osób w różnych wieku. 
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

Przystępujemy do tworzenia wykresu. Po zbudowaniu go funkcją `nPlot()`, należy dookreślić szerokość i wysokość wykresy oraz nazwy osi. 
Następnie wykres jest gotowy do umieszczenia na stronie. Wykres sjest stroną html, można ją umieścić na innej stronie poleceniem `iframe`.


```r
library(rCharts)
p1 <- nPlot(mx ~ Age, group = "Gender", data = przezycia2009, type = "lineChart")
p1$chart(yScale = "#! d3.scale.log() !#")
p1$xAxis(axisLabel = 'Wiek')
p1$yAxis(axisLabel = 'Śmiertelność')
p1$set(width = 800, height = 600)
# p1$save("rCharts1.html", standalone=TRUE)
```

<iframe style="width:810px; height=610px" src="https://rawgit.com/pbiecek/Przewodnik/master/Wizualizacja/rCharts1.html">
<iframe>

http://www.rpubs.com/dnchari/rcharts


```r
library(SmarterPoland)

head(countries)
```

```
##                                 country birthrate deathrate population
## Afghanistan                 Afghanistan      34.1       7.7      30552
## Albania                         Albania      12.9       9.4       3173
## Algeria                         Algeria      24.3       5.7      39208
## Andorra                         Andorra       8.9       8.4         79
## Angola                           Angola      44.1      13.9      21472
## Antigua and Barbuda Antigua and Barbuda      16.5       6.8         90
##                     continent
## Afghanistan              Asia
## Albania                Europe
## Algeria                Africa
## Andorra                Europe
## Angola                 Africa
## Antigua and Barbuda  Americas
```

```r
rownames(countries) <- countries$country

p1 = rPlot(death.rate ~ birth.rate, data = countries, color = 'continent', type = 'point')
```

```
## Error in eval(expr, envir, enclos): object 'death.rate' not found
```

```r
library(tidyr)
eZycia <- przezycia %>%
  filter(Age == 0) %>%
  mutate(Year = as.character(Year)) %>%
  select(Year, Gender, ex) %>%
  spread(Gender, ex)
```

```
## Error in filter(., Age == 0): object 'Age' not found
```

```r
m1 = mPlot(x = 'Year', y = c('Female', 'Male'), type = 'Line',
  data = eZycia)
```

```
## Error in getLayer.default(...): object 'eZycia' not found
```

```r
m1$set(pointSize = 0, lineWidth = 1)
```

```
## Error in eval(expr, envir, enclos): object 'm1' not found
```

```r
m1
```

```
## Error in eval(expr, envir, enclos): object 'm1' not found
```

```r
p1 = nPlot(death.rate ~ birth.rate, group = "continent", data = countries, type = "scatterChart")
```

```
## Error in eval(expr, envir, enclos): object 'death.rate' not found
```

```r
p1$xAxis(axisLabel = 'death.rate')
p1$yAxis(axisLabel = 'birth.rate')
n1$chart(tooltipContent = "#! function(key, x, y){ 
  return 'x: ' + x + '  y: ' + y 
} !#")
```

```
## Error in eval(expr, envir, enclos): object 'n1' not found
```

```r
p1$print(include_assets=T)
```

```
## <link rel='stylesheet' href=/Library/Frameworks/R.framework/Versions/3.2/Resources/library/rCharts/libraries/nvd3/css/nv.d3.css>
## <link rel='stylesheet' href=/Library/Frameworks/R.framework/Versions/3.2/Resources/library/rCharts/libraries/nvd3/css/rNVD3.css>
## <script type='text/javascript' src=/Library/Frameworks/R.framework/Versions/3.2/Resources/library/rCharts/libraries/nvd3/js/jquery-1.8.2.min.js></script>
## <script type='text/javascript' src=/Library/Frameworks/R.framework/Versions/3.2/Resources/library/rCharts/libraries/nvd3/js/d3.v3.min.js></script>
## <script type='text/javascript' src=/Library/Frameworks/R.framework/Versions/3.2/Resources/library/rCharts/libraries/nvd3/js/nv.d3.min-new.js></script>
## <script type='text/javascript' src=/Library/Frameworks/R.framework/Versions/3.2/Resources/library/rCharts/libraries/nvd3/js/fisheye.js></script> 
##  <style>
##   .rChart {
##     display: block;
##     margin-left: auto; 
##     margin-right: auto;
##     width: 800px;
##     height: 600px;
##   }  
##   </style>
## <div id = 'chart703260b0a7ed' class = 'rChart nvd3'></div>
## <script type='text/javascript'>
##  $(document).ready(function(){
##       drawchart703260b0a7ed()
##     });
##     function drawchart703260b0a7ed(){  
##       var opts = {
##  "dom": "chart703260b0a7ed",
## "width":    800,
## "height":    600,
## "x": "Age",
## "y": "mx",
## "group": "Gender",
## "type": "lineChart",
## "id": "chart703260b0a7ed" 
## },
##         data = [
##  {
##  "Year": 2009,
## "Age": "0",
## "mx":         0.0051,
## "qx":        0.00507,
## "ax":           0.07,
## "lx": 100000,
## "dx": 507,
## "Lx": 99527,
## "Tx": 7991684,
## "ex":          79.92,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "1",
## "mx":        0.00032,
## "qx":        0.00032,
## "ax":            0.5,
## "lx": 99493,
## "dx": 32,
## "Lx": 99477,
## "Tx": 7892158,
## "ex":          79.32,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "2",
## "mx":        0.00018,
## "qx":        0.00018,
## "ax":            0.5,
## "lx": 99461,
## "dx": 18,
## "Lx": 99452,
## "Tx": 7792681,
## "ex":          78.35,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "3",
## "mx":        0.00018,
## "qx":        0.00018,
## "ax":            0.5,
## "lx": 99443,
## "dx": 18,
## "Lx": 99434,
## "Tx": 7693229,
## "ex":          77.36,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "4",
## "mx":        0.00016,
## "qx":        0.00016,
## "ax":            0.5,
## "lx": 99424,
## "dx": 16,
## "Lx": 99416,
## "Tx": 7593795,
## "ex":          76.38,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "5",
## "mx":          9e-05,
## "qx":          9e-05,
## "ax":            0.5,
## "lx": 99408,
## "dx": 9,
## "Lx": 99404,
## "Tx": 7494379,
## "ex":          75.39,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "6",
## "mx":        0.00015,
## "qx":        0.00015,
## "ax":            0.5,
## "lx": 99400,
## "dx": 15,
## "Lx": 99392,
## "Tx": 7394975,
## "ex":           74.4,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "7",
## "mx":        0.00015,
## "qx":        0.00015,
## "ax":            0.5,
## "lx": 99384,
## "dx": 15,
## "Lx": 99377,
## "Tx": 7295583,
## "ex":          73.41,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "8",
## "mx":        0.00014,
## "qx":        0.00014,
## "ax":            0.5,
## "lx": 99369,
## "dx": 14,
## "Lx": 99362,
## "Tx": 7196206,
## "ex":          72.42,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "9",
## "mx":          9e-05,
## "qx":          9e-05,
## "ax":            0.5,
## "lx": 99355,
## "dx": 9,
## "Lx": 99351,
## "Tx": 7096844,
## "ex":          71.43,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "10",
## "mx":        0.00012,
## "qx":        0.00012,
## "ax":            0.5,
## "lx": 99346,
## "dx": 12,
## "Lx": 99340,
## "Tx": 6997493,
## "ex":          70.44,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "11",
## "mx":        0.00011,
## "qx":        0.00011,
## "ax":            0.5,
## "lx": 99334,
## "dx": 11,
## "Lx": 99328,
## "Tx": 6898154,
## "ex":          69.44,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "12",
## "mx":        0.00013,
## "qx":        0.00013,
## "ax":            0.5,
## "lx": 99322,
## "dx": 13,
## "Lx": 99316,
## "Tx": 6798825,
## "ex":          68.45,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "13",
## "mx":         0.0002,
## "qx":         0.0002,
## "ax":            0.5,
## "lx": 99310,
## "dx": 20,
## "Lx": 99300,
## "Tx": 6699509,
## "ex":          67.46,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "14",
## "mx":        0.00023,
## "qx":        0.00023,
## "ax":            0.5,
## "lx": 99289,
## "dx": 23,
## "Lx": 99278,
## "Tx": 6600210,
## "ex":          66.47,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "15",
## "mx":        0.00022,
## "qx":        0.00022,
## "ax":            0.5,
## "lx": 99267,
## "dx": 22,
## "Lx": 99256,
## "Tx": 6500931,
## "ex":          65.49,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "16",
## "mx":        0.00022,
## "qx":        0.00022,
## "ax":            0.5,
## "lx": 99245,
## "dx": 21,
## "Lx": 99234,
## "Tx": 6401675,
## "ex":           64.5,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "17",
## "mx":        0.00026,
## "qx":        0.00026,
## "ax":            0.5,
## "lx": 99224,
## "dx": 26,
## "Lx": 99211,
## "Tx": 6302441,
## "ex":          63.52,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "18",
## "mx":        0.00028,
## "qx":        0.00028,
## "ax":            0.5,
## "lx": 99197,
## "dx": 27,
## "Lx": 99184,
## "Tx": 6203230,
## "ex":          62.53,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "19",
## "mx":        0.00027,
## "qx":        0.00027,
## "ax":            0.5,
## "lx": 99170,
## "dx": 27,
## "Lx": 99157,
## "Tx": 6104047,
## "ex":          61.55,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "20",
## "mx":        0.00023,
## "qx":        0.00023,
## "ax":            0.5,
## "lx": 99143,
## "dx": 23,
## "Lx": 99132,
## "Tx": 6004890,
## "ex":          60.57,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "21",
## "mx":        0.00024,
## "qx":        0.00024,
## "ax":            0.5,
## "lx": 99120,
## "dx": 24,
## "Lx": 99108,
## "Tx": 5905758,
## "ex":          59.58,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "22",
## "mx":        0.00026,
## "qx":        0.00026,
## "ax":            0.5,
## "lx": 99096,
## "dx": 26,
## "Lx": 99083,
## "Tx": 5806650,
## "ex":           58.6,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "23",
## "mx":        0.00025,
## "qx":        0.00025,
## "ax":            0.5,
## "lx": 99070,
## "dx": 25,
## "Lx": 99058,
## "Tx": 5707567,
## "ex":          57.61,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "24",
## "mx":         0.0003,
## "qx":         0.0003,
## "ax":            0.5,
## "lx": 99045,
## "dx": 30,
## "Lx": 99030,
## "Tx": 5608509,
## "ex":          56.63,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "25",
## "mx":         0.0002,
## "qx":         0.0002,
## "ax":            0.5,
## "lx": 99015,
## "dx": 20,
## "Lx": 99005,
## "Tx": 5509479,
## "ex":          55.64,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "26",
## "mx":         0.0003,
## "qx":         0.0003,
## "ax":            0.5,
## "lx": 98995,
## "dx": 30,
## "Lx": 98980,
## "Tx": 5410474,
## "ex":          54.65,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "27",
## "mx":        0.00026,
## "qx":        0.00026,
## "ax":            0.5,
## "lx": 98965,
## "dx": 26,
## "Lx": 98952,
## "Tx": 5311494,
## "ex":          53.67,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "28",
## "mx":        0.00038,
## "qx":        0.00038,
## "ax":            0.5,
## "lx": 98940,
## "dx": 38,
## "Lx": 98921,
## "Tx": 5212542,
## "ex":          52.68,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "29",
## "mx":        0.00035,
## "qx":        0.00035,
## "ax":            0.5,
## "lx": 98902,
## "dx": 34,
## "Lx": 98885,
## "Tx": 5113621,
## "ex":           51.7,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "30",
## "mx":        0.00042,
## "qx":        0.00042,
## "ax":            0.5,
## "lx": 98867,
## "dx": 42,
## "Lx": 98847,
## "Tx": 5014736,
## "ex":          50.72,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "31",
## "mx":        0.00043,
## "qx":        0.00043,
## "ax":            0.5,
## "lx": 98826,
## "dx": 42,
## "Lx": 98805,
## "Tx": 4915890,
## "ex":          49.74,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "32",
## "mx":        0.00047,
## "qx":        0.00047,
## "ax":            0.5,
## "lx": 98784,
## "dx": 47,
## "Lx": 98760,
## "Tx": 4817085,
## "ex":          48.76,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "33",
## "mx":        0.00047,
## "qx":        0.00047,
## "ax":            0.5,
## "lx": 98737,
## "dx": 46,
## "Lx": 98714,
## "Tx": 4718325,
## "ex":          47.79,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "34",
## "mx":        0.00052,
## "qx":        0.00052,
## "ax":            0.5,
## "lx": 98691,
## "dx": 51,
## "Lx": 98665,
## "Tx": 4619611,
## "ex":          46.81,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "35",
## "mx":        0.00066,
## "qx":        0.00065,
## "ax":            0.5,
## "lx": 98640,
## "dx": 65,
## "Lx": 98607,
## "Tx": 4520946,
## "ex":          45.83,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "36",
## "mx":         0.0007,
## "qx":         0.0007,
## "ax":            0.5,
## "lx": 98575,
## "dx": 69,
## "Lx": 98541,
## "Tx": 4422339,
## "ex":          44.86,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "37",
## "mx":        0.00062,
## "qx":        0.00062,
## "ax":            0.5,
## "lx": 98506,
## "dx": 61,
## "Lx": 98476,
## "Tx": 4323798,
## "ex":          43.89,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "38",
## "mx":        0.00088,
## "qx":        0.00088,
## "ax":            0.5,
## "lx": 98445,
## "dx": 87,
## "Lx": 98402,
## "Tx": 4225322,
## "ex":          42.92,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "39",
## "mx":          0.001,
## "qx":          0.001,
## "ax":            0.5,
## "lx": 98359,
## "dx": 98,
## "Lx": 98310,
## "Tx": 4126920,
## "ex":          41.96,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "40",
## "mx":        0.00107,
## "qx":        0.00107,
## "ax":            0.5,
## "lx": 98261,
## "dx": 105,
## "Lx": 98208,
## "Tx": 4028610,
## "ex":             41,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "41",
## "mx":        0.00129,
## "qx":        0.00129,
## "ax":            0.5,
## "lx": 98155,
## "dx": 127,
## "Lx": 98092,
## "Tx": 3930402,
## "ex":          40.04,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "42",
## "mx":        0.00126,
## "qx":        0.00126,
## "ax":            0.5,
## "lx": 98029,
## "dx": 124,
## "Lx": 97967,
## "Tx": 3832310,
## "ex":          39.09,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "43",
## "mx":        0.00145,
## "qx":        0.00145,
## "ax":            0.5,
## "lx": 97905,
## "dx": 142,
## "Lx": 97834,
## "Tx": 3734343,
## "ex":          38.14,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "44",
## "mx":        0.00158,
## "qx":        0.00158,
## "ax":            0.5,
## "lx": 97763,
## "dx": 154,
## "Lx": 97686,
## "Tx": 3636509,
## "ex":           37.2,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "45",
## "mx":        0.00187,
## "qx":        0.00187,
## "ax":            0.5,
## "lx": 97609,
## "dx": 183,
## "Lx": 97517,
## "Tx": 3538823,
## "ex":          36.26,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "46",
## "mx":        0.00212,
## "qx":        0.00212,
## "ax":            0.5,
## "lx": 97426,
## "dx": 206,
## "Lx": 97323,
## "Tx": 3441306,
## "ex":          35.32,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "47",
## "mx":        0.00225,
## "qx":        0.00225,
## "ax":            0.5,
## "lx": 97220,
## "dx": 219,
## "Lx": 97110,
## "Tx": 3343983,
## "ex":           34.4,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "48",
## "mx":        0.00266,
## "qx":        0.00266,
## "ax":            0.5,
## "lx": 97001,
## "dx": 258,
## "Lx": 96872,
## "Tx": 3246872,
## "ex":          33.47,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "49",
## "mx":        0.00289,
## "qx":        0.00288,
## "ax":            0.5,
## "lx": 96743,
## "dx": 279,
## "Lx": 96604,
## "Tx": 3150000,
## "ex":          32.56,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "50",
## "mx":        0.00327,
## "qx":        0.00326,
## "ax":            0.5,
## "lx": 96464,
## "dx": 315,
## "Lx": 96307,
## "Tx": 3053397,
## "ex":          31.65,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "51",
## "mx":        0.00368,
## "qx":        0.00368,
## "ax":            0.5,
## "lx": 96149,
## "dx": 354,
## "Lx": 95972,
## "Tx": 2957090,
## "ex":          30.76,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "52",
## "mx":        0.00396,
## "qx":        0.00395,
## "ax":            0.5,
## "lx": 95795,
## "dx": 379,
## "Lx": 95606,
## "Tx": 2861118,
## "ex":          29.87,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "53",
## "mx":        0.00424,
## "qx":        0.00423,
## "ax":            0.5,
## "lx": 95417,
## "dx": 404,
## "Lx": 95215,
## "Tx": 2765512,
## "ex":          28.98,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "54",
## "mx":        0.00476,
## "qx":        0.00475,
## "ax":            0.5,
## "lx": 95013,
## "dx": 451,
## "Lx": 94788,
## "Tx": 2670297,
## "ex":           28.1,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "55",
## "mx":          0.005,
## "qx":        0.00499,
## "ax":            0.5,
## "lx": 94562,
## "dx": 472,
## "Lx": 94326,
## "Tx": 2575509,
## "ex":          27.24,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "56",
## "mx":        0.00566,
## "qx":        0.00564,
## "ax":            0.5,
## "lx": 94090,
## "dx": 531,
## "Lx": 93825,
## "Tx": 2481183,
## "ex":          26.37,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "57",
## "mx":        0.00615,
## "qx":        0.00613,
## "ax":            0.5,
## "lx": 93559,
## "dx": 573,
## "Lx": 93273,
## "Tx": 2387359,
## "ex":          25.52,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "58",
## "mx":        0.00662,
## "qx":         0.0066,
## "ax":            0.5,
## "lx": 92986,
## "dx": 614,
## "Lx": 92679,
## "Tx": 2294086,
## "ex":          24.67,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "59",
## "mx":        0.00716,
## "qx":        0.00713,
## "ax":            0.5,
## "lx": 92372,
## "dx": 659,
## "Lx": 92043,
## "Tx": 2201407,
## "ex":          23.83,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "60",
## "mx":         0.0079,
## "qx":        0.00787,
## "ax":            0.5,
## "lx": 91713,
## "dx": 722,
## "Lx": 91352,
## "Tx": 2109364,
## "ex":             23,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "61",
## "mx":         0.0087,
## "qx":        0.00867,
## "ax":            0.5,
## "lx": 90991,
## "dx": 788,
## "Lx": 90597,
## "Tx": 2018012,
## "ex":          22.18,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "62",
## "mx":         0.0092,
## "qx":        0.00915,
## "ax":            0.5,
## "lx": 90203,
## "dx": 826,
## "Lx": 89790,
## "Tx": 1927414,
## "ex":          21.37,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "63",
## "mx":        0.00978,
## "qx":        0.00973,
## "ax":            0.5,
## "lx": 89377,
## "dx": 870,
## "Lx": 88942,
## "Tx": 1837624,
## "ex":          20.56,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "64",
## "mx":         0.0102,
## "qx":        0.01015,
## "ax":            0.5,
## "lx": 88507,
## "dx": 898,
## "Lx": 88058,
## "Tx": 1748682,
## "ex":          19.76,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "65",
## "mx":        0.01146,
## "qx":         0.0114,
## "ax":            0.5,
## "lx": 87609,
## "dx": 999,
## "Lx": 87110,
## "Tx": 1660624,
## "ex":          18.95,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "66",
## "mx":         0.0118,
## "qx":        0.01174,
## "ax":            0.5,
## "lx": 86611,
## "dx": 1016,
## "Lx": 86102,
## "Tx": 1573514,
## "ex":          18.17,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "67",
## "mx":        0.01278,
## "qx":         0.0127,
## "ax":            0.5,
## "lx": 85594,
## "dx": 1087,
## "Lx": 85051,
## "Tx": 1487411,
## "ex":          17.38,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "68",
## "mx":        0.01359,
## "qx":         0.0135,
## "ax":            0.5,
## "lx": 84508,
## "dx": 1141,
## "Lx": 83937,
## "Tx": 1402360,
## "ex":          16.59,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "69",
## "mx":        0.01524,
## "qx":        0.01513,
## "ax":            0.5,
## "lx": 83367,
## "dx": 1261,
## "Lx": 82737,
## "Tx": 1318423,
## "ex":          15.81,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "70",
## "mx":        0.01674,
## "qx":         0.0166,
## "ax":            0.5,
## "lx": 82106,
## "dx": 1363,
## "Lx": 81425,
## "Tx": 1235686,
## "ex":          15.05,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "71",
## "mx":        0.01848,
## "qx":        0.01831,
## "ax":            0.5,
## "lx": 80743,
## "dx": 1479,
## "Lx": 80004,
## "Tx": 1154262,
## "ex":           14.3,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "72",
## "mx":        0.02008,
## "qx":        0.01988,
## "ax":            0.5,
## "lx": 79265,
## "dx": 1576,
## "Lx": 78477,
## "Tx": 1074258,
## "ex":          13.55,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "73",
## "mx":        0.02275,
## "qx":        0.02249,
## "ax":            0.5,
## "lx": 77689,
## "dx": 1747,
## "Lx": 76815,
## "Tx": 995781,
## "ex":          12.82,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "74",
## "mx":        0.02619,
## "qx":        0.02585,
## "ax":            0.5,
## "lx": 75942,
## "dx": 1963,
## "Lx": 74960,
## "Tx": 918966,
## "ex":           12.1,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "75",
## "mx":        0.02952,
## "qx":        0.02909,
## "ax":            0.5,
## "lx": 73979,
## "dx": 2152,
## "Lx": 72903,
## "Tx": 844006,
## "ex":          11.41,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "76",
## "mx":        0.03332,
## "qx":        0.03277,
## "ax":            0.5,
## "lx": 71827,
## "dx": 2354,
## "Lx": 70650,
## "Tx": 771103,
## "ex":          10.74,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "77",
## "mx":        0.03731,
## "qx":        0.03663,
## "ax":            0.5,
## "lx": 69473,
## "dx": 2545,
## "Lx": 68200,
## "Tx": 700453,
## "ex":          10.08,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "78",
## "mx":         0.0433,
## "qx":        0.04238,
## "ax":            0.5,
## "lx": 66928,
## "dx": 2836,
## "Lx": 65510,
## "Tx": 632253,
## "ex":           9.45,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "79",
## "mx":          0.049,
## "qx":        0.04782,
## "ax":            0.5,
## "lx": 64092,
## "dx": 3065,
## "Lx": 62559,
## "Tx": 566743,
## "ex":           8.84,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "80",
## "mx":        0.05596,
## "qx":        0.05443,
## "ax":            0.5,
## "lx": 61026,
## "dx": 3322,
## "Lx": 59365,
## "Tx": 504184,
## "ex":           8.26,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "81",
## "mx":        0.06314,
## "qx":        0.06121,
## "ax":            0.5,
## "lx": 57705,
## "dx": 3532,
## "Lx": 55938,
## "Tx": 444819,
## "ex":           7.71,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "82",
## "mx":        0.07258,
## "qx":        0.07004,
## "ax":            0.5,
## "lx": 54172,
## "dx": 3794,
## "Lx": 52275,
## "Tx": 388880,
## "ex":           7.18,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "83",
## "mx":        0.08272,
## "qx":        0.07944,
## "ax":            0.5,
## "lx": 50378,
## "dx": 4002,
## "Lx": 48377,
## "Tx": 336605,
## "ex":           6.68,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "84",
## "mx":        0.09285,
## "qx":        0.08873,
## "ax":            0.5,
## "lx": 46376,
## "dx": 4115,
## "Lx": 44319,
## "Tx": 288228,
## "ex":           6.21,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "85",
## "mx":        0.10716,
## "qx":        0.10171,
## "ax":            0.5,
## "lx": 42261,
## "dx": 4299,
## "Lx": 40112,
## "Tx": 243909,
## "ex":           5.77,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "86",
## "mx":        0.12208,
## "qx":        0.11506,
## "ax":            0.5,
## "lx": 37963,
## "dx": 4368,
## "Lx": 35779,
## "Tx": 203797,
## "ex":           5.37,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "87",
## "mx":        0.13282,
## "qx":        0.12455,
## "ax":            0.5,
## "lx": 33595,
## "dx": 4184,
## "Lx": 31503,
## "Tx": 168018,
## "ex":              5,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "88",
## "mx":        0.14677,
## "qx":        0.13673,
## "ax":            0.5,
## "lx": 29411,
## "dx": 4021,
## "Lx": 27400,
## "Tx": 136515,
## "ex":           4.64,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "89",
## "mx":        0.17178,
## "qx":        0.15819,
## "ax":            0.5,
## "lx": 25389,
## "dx": 4016,
## "Lx": 23381,
## "Tx": 109115,
## "ex":            4.3,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "90",
## "mx":        0.17631,
## "qx":        0.16203,
## "ax":            0.5,
## "lx": 21373,
## "dx": 3463,
## "Lx": 19641,
## "Tx": 85734,
## "ex":           4.01,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "91",
## "mx":        0.19959,
## "qx":        0.18148,
## "ax":            0.5,
## "lx": 17910,
## "dx": 3250,
## "Lx": 16285,
## "Tx": 66093,
## "ex":           3.69,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "92",
## "mx":        0.23311,
## "qx":        0.20878,
## "ax":            0.5,
## "lx": 14660,
## "dx": 3061,
## "Lx": 13129,
## "Tx": 49808,
## "ex":            3.4,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "93",
## "mx":        0.25201,
## "qx":        0.22381,
## "ax":            0.5,
## "lx": 11599,
## "dx": 2596,
## "Lx": 10301,
## "Tx": 36679,
## "ex":           3.16,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "94",
## "mx":        0.29327,
## "qx":        0.25577,
## "ax":            0.5,
## "lx": 9003,
## "dx": 2303,
## "Lx": 7852,
## "Tx": 26378,
## "ex":           2.93,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "95",
## "mx":        0.30448,
## "qx":        0.26425,
## "ax":            0.5,
## "lx": 6700,
## "dx": 1771,
## "Lx": 5815,
## "Tx": 18526,
## "ex":           2.76,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "96",
## "mx":        0.33312,
## "qx":        0.28556,
## "ax":            0.5,
## "lx": 4930,
## "dx": 1408,
## "Lx": 4226,
## "Tx": 12711,
## "ex":           2.58,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "97",
## "mx":        0.36304,
## "qx":        0.30727,
## "ax":            0.5,
## "lx": 3522,
## "dx": 1082,
## "Lx": 2981,
## "Tx": 8485,
## "ex":           2.41,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "98",
## "mx":        0.39406,
## "qx":         0.3292,
## "ax":            0.5,
## "lx": 2440,
## "dx": 803,
## "Lx": 2038,
## "Tx": 5504,
## "ex":           2.26,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "99",
## "mx":        0.42596,
## "qx":        0.35117,
## "ax":            0.5,
## "lx": 1637,
## "dx": 575,
## "Lx": 1349,
## "Tx": 3466,
## "ex":           2.12,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "100",
## "mx":        0.45849,
## "qx":        0.37299,
## "ax":            0.5,
## "lx": 1062,
## "dx": 396,
## "Lx": 864,
## "Tx": 2117,
## "ex":           1.99,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "101",
## "mx":        0.49138,
## "qx":        0.39446,
## "ax":            0.5,
## "lx": 666,
## "dx": 263,
## "Lx": 535,
## "Tx": 1253,
## "ex":           1.88,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "102",
## "mx":        0.52434,
## "qx":        0.41542,
## "ax":            0.5,
## "lx": 403,
## "dx": 167,
## "Lx": 319,
## "Tx": 718,
## "ex":           1.78,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "103",
## "mx":        0.55709,
## "qx":        0.43572,
## "ax":            0.5,
## "lx": 236,
## "dx": 103,
## "Lx": 184,
## "Tx": 399,
## "ex":           1.69,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "104",
## "mx":        0.58935,
## "qx":        0.45521,
## "ax":            0.5,
## "lx": 133,
## "dx": 61,
## "Lx": 103,
## "Tx": 214,
## "ex":           1.61,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "105",
## "mx":        0.62086,
## "qx":        0.47378,
## "ax":            0.5,
## "lx": 72,
## "dx": 34,
## "Lx": 55,
## "Tx": 112,
## "ex":           1.54,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "106",
## "mx":        0.65138,
## "qx":        0.49135,
## "ax":            0.5,
## "lx": 38,
## "dx": 19,
## "Lx": 29,
## "Tx": 56,
## "ex":           1.48,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "107",
## "mx":        0.68071,
## "qx":        0.50786,
## "ax":            0.5,
## "lx": 19,
## "dx": 10,
## "Lx": 14,
## "Tx": 28,
## "ex":           1.42,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "108",
## "mx":        0.70867,
## "qx":        0.52326,
## "ax":            0.5,
## "lx": 10,
## "dx": 5,
## "Lx": 7,
## "Tx": 13,
## "ex":           1.38,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "109",
## "mx":        0.73514,
## "qx":        0.53755,
## "ax":            0.5,
## "lx": 5,
## "dx": 2,
## "Lx": 3,
## "Tx": 6,
## "ex":           1.34,
## "Gender": "Female" 
## },
## {
##  "Year": 2009,
## "Age": "0",
## "mx":        0.00608,
## "qx":        0.00605,
## "ax":           0.06,
## "lx": 100000,
## "dx": 605,
## "Lx": 99432,
## "Tx": 7148455,
## "ex":          71.48,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "1",
## "mx":        0.00034,
## "qx":        0.00034,
## "ax":            0.5,
## "lx": 99395,
## "dx": 34,
## "Lx": 99379,
## "Tx": 7049023,
## "ex":          70.92,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "2",
## "mx":        0.00026,
## "qx":        0.00026,
## "ax":            0.5,
## "lx": 99362,
## "dx": 26,
## "Lx": 99349,
## "Tx": 6949644,
## "ex":          69.94,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "3",
## "mx":        0.00015,
## "qx":        0.00015,
## "ax":            0.5,
## "lx": 99336,
## "dx": 15,
## "Lx": 99328,
## "Tx": 6850296,
## "ex":          68.96,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "4",
## "mx":        0.00012,
## "qx":        0.00012,
## "ax":            0.5,
## "lx": 99320,
## "dx": 12,
## "Lx": 99314,
## "Tx": 6750968,
## "ex":          67.97,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "5",
## "mx":        0.00021,
## "qx":        0.00021,
## "ax":            0.5,
## "lx": 99308,
## "dx": 21,
## "Lx": 99298,
## "Tx": 6651653,
## "ex":          66.98,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "6",
## "mx":        0.00014,
## "qx":        0.00014,
## "ax":            0.5,
## "lx": 99288,
## "dx": 14,
## "Lx": 99280,
## "Tx": 6552355,
## "ex":          65.99,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "7",
## "mx":        0.00013,
## "qx":        0.00013,
## "ax":            0.5,
## "lx": 99273,
## "dx": 12,
## "Lx": 99267,
## "Tx": 6453075,
## "ex":             65,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "8",
## "mx":        0.00019,
## "qx":        0.00019,
## "ax":            0.5,
## "lx": 99261,
## "dx": 19,
## "Lx": 99251,
## "Tx": 6353808,
## "ex":          64.01,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "9",
## "mx":        0.00013,
## "qx":        0.00013,
## "ax":            0.5,
## "lx": 99242,
## "dx": 13,
## "Lx": 99235,
## "Tx": 6254557,
## "ex":          63.02,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "10",
## "mx":        0.00016,
## "qx":        0.00016,
## "ax":            0.5,
## "lx": 99229,
## "dx": 16,
## "Lx": 99220,
## "Tx": 6155321,
## "ex":          62.03,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "11",
## "mx":        0.00012,
## "qx":        0.00012,
## "ax":            0.5,
## "lx": 99212,
## "dx": 12,
## "Lx": 99206,
## "Tx": 6056101,
## "ex":          61.04,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "12",
## "mx":        0.00018,
## "qx":        0.00018,
## "ax":            0.5,
## "lx": 99200,
## "dx": 18,
## "Lx": 99191,
## "Tx": 5956894,
## "ex":          60.05,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "13",
## "mx":        0.00015,
## "qx":        0.00015,
## "ax":            0.5,
## "lx": 99183,
## "dx": 15,
## "Lx": 99175,
## "Tx": 5857703,
## "ex":          59.06,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "14",
## "mx":        0.00032,
## "qx":        0.00032,
## "ax":            0.5,
## "lx": 99168,
## "dx": 31,
## "Lx": 99152,
## "Tx": 5758528,
## "ex":          58.07,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "15",
## "mx":        0.00041,
## "qx":        0.00041,
## "ax":            0.5,
## "lx": 99136,
## "dx": 41,
## "Lx": 99116,
## "Tx": 5659376,
## "ex":          57.09,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "16",
## "mx":        0.00043,
## "qx":        0.00043,
## "ax":            0.5,
## "lx": 99096,
## "dx": 43,
## "Lx": 99074,
## "Tx": 5560260,
## "ex":          56.11,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "17",
## "mx":        0.00067,
## "qx":        0.00067,
## "ax":            0.5,
## "lx": 99053,
## "dx": 66,
## "Lx": 99020,
## "Tx": 5461185,
## "ex":          55.13,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "18",
## "mx":        0.00101,
## "qx":          0.001,
## "ax":            0.5,
## "lx": 98987,
## "dx": 99,
## "Lx": 98937,
## "Tx": 5362166,
## "ex":          54.17,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "19",
## "mx":        0.00103,
## "qx":        0.00103,
## "ax":            0.5,
## "lx": 98887,
## "dx": 101,
## "Lx": 98837,
## "Tx": 5263229,
## "ex":          53.22,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "20",
## "mx":        0.00117,
## "qx":        0.00117,
## "ax":            0.5,
## "lx": 98786,
## "dx": 116,
## "Lx": 98728,
## "Tx": 5164392,
## "ex":          52.28,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "21",
## "mx":         0.0011,
## "qx":         0.0011,
## "ax":            0.5,
## "lx": 98670,
## "dx": 108,
## "Lx": 98616,
## "Tx": 5065664,
## "ex":          51.34,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "22",
## "mx":        0.00115,
## "qx":        0.00115,
## "ax":            0.5,
## "lx": 98562,
## "dx": 113,
## "Lx": 98505,
## "Tx": 4967048,
## "ex":           50.4,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "23",
## "mx":        0.00113,
## "qx":        0.00113,
## "ax":            0.5,
## "lx": 98449,
## "dx": 112,
## "Lx": 98393,
## "Tx": 4868542,
## "ex":          49.45,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "24",
## "mx":        0.00102,
## "qx":        0.00102,
## "ax":            0.5,
## "lx": 98337,
## "dx": 100,
## "Lx": 98287,
## "Tx": 4770149,
## "ex":          48.51,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "25",
## "mx":        0.00109,
## "qx":        0.00109,
## "ax":            0.5,
## "lx": 98237,
## "dx": 107,
## "Lx": 98184,
## "Tx": 4671862,
## "ex":          47.56,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "26",
## "mx":        0.00113,
## "qx":        0.00113,
## "ax":            0.5,
## "lx": 98130,
## "dx": 111,
## "Lx": 98075,
## "Tx": 4573679,
## "ex":          46.61,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "27",
## "mx":        0.00113,
## "qx":        0.00113,
## "ax":            0.5,
## "lx": 98019,
## "dx": 111,
## "Lx": 97964,
## "Tx": 4475604,
## "ex":          45.66,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "28",
## "mx":        0.00112,
## "qx":        0.00112,
## "ax":            0.5,
## "lx": 97909,
## "dx": 110,
## "Lx": 97854,
## "Tx": 4377640,
## "ex":          44.71,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "29",
## "mx":        0.00119,
## "qx":        0.00119,
## "ax":            0.5,
## "lx": 97799,
## "dx": 116,
## "Lx": 97741,
## "Tx": 4279786,
## "ex":          43.76,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "30",
## "mx":        0.00145,
## "qx":        0.00145,
## "ax":            0.5,
## "lx": 97683,
## "dx": 141,
## "Lx": 97612,
## "Tx": 4182046,
## "ex":          42.81,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "31",
## "mx":         0.0015,
## "qx":         0.0015,
## "ax":            0.5,
## "lx": 97541,
## "dx": 147,
## "Lx": 97468,
## "Tx": 4084434,
## "ex":          41.87,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "32",
## "mx":        0.00157,
## "qx":        0.00156,
## "ax":            0.5,
## "lx": 97395,
## "dx": 152,
## "Lx": 97318,
## "Tx": 3986966,
## "ex":          40.94,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "33",
## "mx":        0.00167,
## "qx":        0.00167,
## "ax":            0.5,
## "lx": 97242,
## "dx": 162,
## "Lx": 97161,
## "Tx": 3889647,
## "ex":             40,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "34",
## "mx":        0.00184,
## "qx":        0.00184,
## "ax":            0.5,
## "lx": 97080,
## "dx": 179,
## "Lx": 96991,
## "Tx": 3792486,
## "ex":          39.07,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "35",
## "mx":        0.00218,
## "qx":        0.00218,
## "ax":            0.5,
## "lx": 96901,
## "dx": 211,
## "Lx": 96796,
## "Tx": 3695496,
## "ex":          38.14,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "36",
## "mx":          0.002,
## "qx":        0.00199,
## "ax":            0.5,
## "lx": 96690,
## "dx": 193,
## "Lx": 96594,
## "Tx": 3598700,
## "ex":          37.22,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "37",
## "mx":        0.00242,
## "qx":        0.00242,
## "ax":            0.5,
## "lx": 96497,
## "dx": 233,
## "Lx": 96381,
## "Tx": 3502106,
## "ex":          36.29,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "38",
## "mx":        0.00265,
## "qx":        0.00264,
## "ax":            0.5,
## "lx": 96264,
## "dx": 254,
## "Lx": 96137,
## "Tx": 3405725,
## "ex":          35.38,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "39",
## "mx":        0.00315,
## "qx":        0.00314,
## "ax":            0.5,
## "lx": 96010,
## "dx": 302,
## "Lx": 95859,
## "Tx": 3309588,
## "ex":          34.47,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "40",
## "mx":        0.00323,
## "qx":        0.00323,
## "ax":            0.5,
## "lx": 95708,
## "dx": 309,
## "Lx": 95553,
## "Tx": 3213730,
## "ex":          33.58,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "41",
## "mx":        0.00386,
## "qx":        0.00385,
## "ax":            0.5,
## "lx": 95399,
## "dx": 367,
## "Lx": 95215,
## "Tx": 3118176,
## "ex":          32.69,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "42",
## "mx":        0.00416,
## "qx":        0.00415,
## "ax":            0.5,
## "lx": 95032,
## "dx": 395,
## "Lx": 94834,
## "Tx": 3022961,
## "ex":          31.81,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "43",
## "mx":        0.00411,
## "qx":         0.0041,
## "ax":            0.5,
## "lx": 94637,
## "dx": 388,
## "Lx": 94443,
## "Tx": 2928126,
## "ex":          30.94,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "44",
## "mx":        0.00471,
## "qx":         0.0047,
## "ax":            0.5,
## "lx": 94249,
## "dx": 443,
## "Lx": 94027,
## "Tx": 2833684,
## "ex":          30.07,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "45",
## "mx":        0.00534,
## "qx":        0.00533,
## "ax":            0.5,
## "lx": 93806,
## "dx": 500,
## "Lx": 93556,
## "Tx": 2739657,
## "ex":          29.21,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "46",
## "mx":        0.00571,
## "qx":         0.0057,
## "ax":            0.5,
## "lx": 93306,
## "dx": 532,
## "Lx": 93040,
## "Tx": 2646101,
## "ex":          28.36,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "47",
## "mx":         0.0067,
## "qx":        0.00668,
## "ax":            0.5,
## "lx": 92775,
## "dx": 620,
## "Lx": 92465,
## "Tx": 2553060,
## "ex":          27.52,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "48",
## "mx":        0.00724,
## "qx":        0.00721,
## "ax":            0.5,
## "lx": 92155,
## "dx": 665,
## "Lx": 91823,
## "Tx": 2460595,
## "ex":           26.7,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "49",
## "mx":        0.00771,
## "qx":        0.00768,
## "ax":            0.5,
## "lx": 91490,
## "dx": 703,
## "Lx": 91139,
## "Tx": 2368772,
## "ex":          25.89,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "50",
## "mx":        0.00898,
## "qx":        0.00894,
## "ax":            0.5,
## "lx": 90787,
## "dx": 811,
## "Lx": 90382,
## "Tx": 2277634,
## "ex":          25.09,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "51",
## "mx":        0.00955,
## "qx":        0.00951,
## "ax":            0.5,
## "lx": 89976,
## "dx": 855,
## "Lx": 89548,
## "Tx": 2187252,
## "ex":          24.31,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "52",
## "mx":        0.01028,
## "qx":        0.01023,
## "ax":            0.5,
## "lx": 89121,
## "dx": 912,
## "Lx": 88665,
## "Tx": 2097703,
## "ex":          23.54,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "53",
## "mx":         0.0115,
## "qx":        0.01144,
## "ax":            0.5,
## "lx": 88209,
## "dx": 1009,
## "Lx": 87705,
## "Tx": 2009038,
## "ex":          22.78,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "54",
## "mx":        0.01234,
## "qx":        0.01226,
## "ax":            0.5,
## "lx": 87200,
## "dx": 1069,
## "Lx": 86666,
## "Tx": 1921334,
## "ex":          22.03,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "55",
## "mx":         0.0133,
## "qx":        0.01321,
## "ax":            0.5,
## "lx": 86131,
## "dx": 1138,
## "Lx": 85562,
## "Tx": 1834668,
## "ex":           21.3,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "56",
## "mx":        0.01451,
## "qx":         0.0144,
## "ax":            0.5,
## "lx": 84993,
## "dx": 1224,
## "Lx": 84381,
## "Tx": 1749106,
## "ex":          20.58,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "57",
## "mx":        0.01598,
## "qx":        0.01585,
## "ax":            0.5,
## "lx": 83769,
## "dx": 1328,
## "Lx": 83105,
## "Tx": 1664725,
## "ex":          19.87,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "58",
## "mx":        0.01753,
## "qx":        0.01738,
## "ax":            0.5,
## "lx": 82441,
## "dx": 1432,
## "Lx": 81725,
## "Tx": 1581620,
## "ex":          19.18,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "59",
## "mx":        0.01814,
## "qx":        0.01797,
## "ax":            0.5,
## "lx": 81009,
## "dx": 1456,
## "Lx": 80281,
## "Tx": 1499894,
## "ex":          18.52,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "60",
## "mx":           0.02,
## "qx":         0.0198,
## "ax":            0.5,
## "lx": 79553,
## "dx": 1575,
## "Lx": 78765,
## "Tx": 1419613,
## "ex":          17.84,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "61",
## "mx":        0.02111,
## "qx":        0.02089,
## "ax":            0.5,
## "lx": 77978,
## "dx": 1629,
## "Lx": 77163,
## "Tx": 1340848,
## "ex":           17.2,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "62",
## "mx":        0.02293,
## "qx":        0.02267,
## "ax":            0.5,
## "lx": 76349,
## "dx": 1731,
## "Lx": 75483,
## "Tx": 1263685,
## "ex":          16.55,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "63",
## "mx":        0.02481,
## "qx":         0.0245,
## "ax":            0.5,
## "lx": 74618,
## "dx": 1828,
## "Lx": 73704,
## "Tx": 1188201,
## "ex":          15.92,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "64",
## "mx":        0.02554,
## "qx":        0.02522,
## "ax":            0.5,
## "lx": 72790,
## "dx": 1836,
## "Lx": 71872,
## "Tx": 1114498,
## "ex":          15.31,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "65",
## "mx":        0.02901,
## "qx":        0.02859,
## "ax":            0.5,
## "lx": 70954,
## "dx": 2029,
## "Lx": 69939,
## "Tx": 1042626,
## "ex":          14.69,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "66",
## "mx":        0.02885,
## "qx":        0.02844,
## "ax":            0.5,
## "lx": 68925,
## "dx": 1960,
## "Lx": 67945,
## "Tx": 972687,
## "ex":          14.11,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "67",
## "mx":        0.03107,
## "qx":        0.03059,
## "ax":            0.5,
## "lx": 66965,
## "dx": 2049,
## "Lx": 65941,
## "Tx": 904742,
## "ex":          13.51,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "68",
## "mx":        0.03353,
## "qx":        0.03298,
## "ax":            0.5,
## "lx": 64917,
## "dx": 2141,
## "Lx": 63846,
## "Tx": 838801,
## "ex":          12.92,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "69",
## "mx":        0.03706,
## "qx":        0.03638,
## "ax":            0.5,
## "lx": 62776,
## "dx": 2284,
## "Lx": 61634,
## "Tx": 774955,
## "ex":          12.34,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "70",
## "mx":        0.03929,
## "qx":        0.03854,
## "ax":            0.5,
## "lx": 60492,
## "dx": 2331,
## "Lx": 59326,
## "Tx": 713321,
## "ex":          11.79,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "71",
## "mx":        0.04205,
## "qx":        0.04118,
## "ax":            0.5,
## "lx": 58161,
## "dx": 2395,
## "Lx": 56963,
## "Tx": 653995,
## "ex":          11.24,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "72",
## "mx":        0.04507,
## "qx":        0.04407,
## "ax":            0.5,
## "lx": 55766,
## "dx": 2458,
## "Lx": 54537,
## "Tx": 597031,
## "ex":          10.71,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "73",
## "mx":        0.04896,
## "qx":        0.04779,
## "ax":            0.5,
## "lx": 53308,
## "dx": 2548,
## "Lx": 52034,
## "Tx": 542495,
## "ex":          10.18,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "74",
## "mx":        0.05285,
## "qx":        0.05149,
## "ax":            0.5,
## "lx": 50760,
## "dx": 2614,
## "Lx": 49453,
## "Tx": 490461,
## "ex":           9.66,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "75",
## "mx":         0.0575,
## "qx":        0.05589,
## "ax":            0.5,
## "lx": 48147,
## "dx": 2691,
## "Lx": 46801,
## "Tx": 441007,
## "ex":           9.16,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "76",
## "mx":        0.06104,
## "qx":        0.05923,
## "ax":            0.5,
## "lx": 45455,
## "dx": 2692,
## "Lx": 44109,
## "Tx": 394206,
## "ex":           8.67,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "77",
## "mx":        0.06791,
## "qx":        0.06568,
## "ax":            0.5,
## "lx": 42763,
## "dx": 2809,
## "Lx": 41359,
## "Tx": 350097,
## "ex":           8.19,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "78",
## "mx":        0.07426,
## "qx":         0.0716,
## "ax":            0.5,
## "lx": 39954,
## "dx": 2861,
## "Lx": 38524,
## "Tx": 308738,
## "ex":           7.73,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "79",
## "mx":         0.0806,
## "qx":        0.07748,
## "ax":            0.5,
## "lx": 37094,
## "dx": 2874,
## "Lx": 35657,
## "Tx": 270214,
## "ex":           7.28,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "80",
## "mx":        0.08884,
## "qx":        0.08506,
## "ax":            0.5,
## "lx": 34220,
## "dx": 2911,
## "Lx": 32764,
## "Tx": 234558,
## "ex":           6.85,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "81",
## "mx":        0.09869,
## "qx":        0.09405,
## "ax":            0.5,
## "lx": 31309,
## "dx": 2945,
## "Lx": 29836,
## "Tx": 201794,
## "ex":           6.45,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "82",
## "mx":        0.10686,
## "qx":        0.10144,
## "ax":            0.5,
## "lx": 28364,
## "dx": 2877,
## "Lx": 26925,
## "Tx": 171957,
## "ex":           6.06,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "83",
## "mx":        0.11814,
## "qx":        0.11155,
## "ax":            0.5,
## "lx": 25487,
## "dx": 2843,
## "Lx": 24065,
## "Tx": 145032,
## "ex":           5.69,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "84",
## "mx":        0.13008,
## "qx":        0.12214,
## "ax":            0.5,
## "lx": 22644,
## "dx": 2766,
## "Lx": 21261,
## "Tx": 120966,
## "ex":           5.34,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "85",
## "mx":        0.14014,
## "qx":        0.13096,
## "ax":            0.5,
## "lx": 19878,
## "dx": 2603,
## "Lx": 18576,
## "Tx": 99705,
## "ex":           5.02,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "86",
## "mx":        0.15525,
## "qx":        0.14407,
## "ax":            0.5,
## "lx": 17275,
## "dx": 2489,
## "Lx": 16030,
## "Tx": 81129,
## "ex":            4.7,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "87",
## "mx":        0.17796,
## "qx":        0.16342,
## "ax":            0.5,
## "lx": 14786,
## "dx": 2416,
## "Lx": 13578,
## "Tx": 65099,
## "ex":            4.4,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "88",
## "mx":        0.18052,
## "qx":        0.16557,
## "ax":            0.5,
## "lx": 12370,
## "dx": 2048,
## "Lx": 11346,
## "Tx": 51521,
## "ex":           4.17,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "89",
## "mx":         0.2123,
## "qx":        0.19193,
## "ax":            0.5,
## "lx": 10322,
## "dx": 1981,
## "Lx": 9331,
## "Tx": 40175,
## "ex":           3.89,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "90",
## "mx":        0.20301,
## "qx":        0.18431,
## "ax":            0.5,
## "lx": 8341,
## "dx": 1537,
## "Lx": 7572,
## "Tx": 30844,
## "ex":            3.7,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "91",
## "mx":        0.22513,
## "qx":        0.20236,
## "ax":            0.5,
## "lx": 6803,
## "dx": 1377,
## "Lx": 6115,
## "Tx": 23272,
## "ex":           3.42,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "92",
## "mx":        0.26177,
## "qx":        0.23148,
## "ax":            0.5,
## "lx": 5427,
## "dx": 1256,
## "Lx": 4799,
## "Tx": 17157,
## "ex":           3.16,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "93",
## "mx":        0.28815,
## "qx":        0.25186,
## "ax":            0.5,
## "lx": 4171,
## "dx": 1050,
## "Lx": 3645,
## "Tx": 12359,
## "ex":           2.96,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "94",
## "mx":        0.33475,
## "qx":        0.28676,
## "ax":            0.5,
## "lx": 3120,
## "dx": 895,
## "Lx": 2673,
## "Tx": 8714,
## "ex":           2.79,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "95",
## "mx":        0.32189,
## "qx":        0.27726,
## "ax":            0.5,
## "lx": 2225,
## "dx": 617,
## "Lx": 1917,
## "Tx": 6041,
## "ex":           2.71,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "96",
## "mx":        0.34527,
## "qx":        0.29444,
## "ax":            0.5,
## "lx": 1608,
## "dx": 474,
## "Lx": 1372,
## "Tx": 4124,
## "ex":           2.56,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "97",
## "mx":        0.36943,
## "qx":        0.31183,
## "ax":            0.5,
## "lx": 1135,
## "dx": 354,
## "Lx": 958,
## "Tx": 2752,
## "ex":           2.43,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "98",
## "mx":        0.39426,
## "qx":        0.32933,
## "ax":            0.5,
## "lx": 781,
## "dx": 257,
## "Lx": 652,
## "Tx": 1794,
## "ex":            2.3,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "99",
## "mx":        0.41964,
## "qx":        0.34686,
## "ax":            0.5,
## "lx": 524,
## "dx": 182,
## "Lx": 433,
## "Tx": 1142,
## "ex":           2.18,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "100",
## "mx":        0.44546,
## "qx":        0.36432,
## "ax":            0.5,
## "lx": 342,
## "dx": 125,
## "Lx": 280,
## "Tx": 709,
## "ex":           2.07,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "101",
## "mx":        0.47158,
## "qx":         0.3816,
## "ax":            0.5,
## "lx": 217,
## "dx": 83,
## "Lx": 176,
## "Tx": 429,
## "ex":           1.97,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "102",
## "mx":        0.49785,
## "qx":        0.39862,
## "ax":            0.5,
## "lx": 134,
## "dx": 54,
## "Lx": 108,
## "Tx": 253,
## "ex":           1.88,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "103",
## "mx":        0.52414,
## "qx":         0.4153,
## "ax":            0.5,
## "lx": 81,
## "dx": 34,
## "Lx": 64,
## "Tx": 146,
## "ex":            1.8,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "104",
## "mx":        0.55029,
## "qx":        0.43155,
## "ax":            0.5,
## "lx": 47,
## "dx": 20,
## "Lx": 37,
## "Tx": 82,
## "ex":           1.73,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "105",
## "mx":        0.57617,
## "qx":        0.44731,
## "ax":            0.5,
## "lx": 27,
## "dx": 12,
## "Lx": 21,
## "Tx": 45,
## "ex":           1.66,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "106",
## "mx":        0.60164,
## "qx":        0.46251,
## "ax":            0.5,
## "lx": 15,
## "dx": 7,
## "Lx": 11,
## "Tx": 24,
## "ex":            1.6,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "107",
## "mx":        0.62656,
## "qx":         0.4771,
## "ax":            0.5,
## "lx": 8,
## "dx": 4,
## "Lx": 6,
## "Tx": 12,
## "ex":           1.54,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "108",
## "mx":        0.65084,
## "qx":        0.49104,
## "ax":            0.5,
## "lx": 4,
## "dx": 2,
## "Lx": 3,
## "Tx": 6,
## "ex":            1.5,
## "Gender": "Male" 
## },
## {
##  "Year": 2009,
## "Age": "109",
## "mx":        0.67435,
## "qx":        0.50431,
## "ax":            0.5,
## "lx": 2,
## "dx": 1,
## "Lx": 2,
## "Tx": 3,
## "ex":           1.46,
## "Gender": "Male" 
## } 
## ]
##   
##       if(!(opts.type==="pieChart" || opts.type==="sparklinePlus" || opts.type==="bulletChart")) {
##         var data = d3.nest()
##           .key(function(d){
##             //return opts.group === undefined ? 'main' : d[opts.group]
##             //instead of main would think a better default is opts.x
##             return opts.group === undefined ? opts.y : d[opts.group];
##           })
##           .entries(data);
##       }
##       
##       if (opts.disabled != undefined){
##         data.map(function(d, i){
##           d.disabled = opts.disabled[i]
##         })
##       }
##       
##       nv.addGraph(function() {
##         var chart = nv.models[opts.type]()
##           .width(opts.width)
##           .height(opts.height)
##           
##         if (opts.type != "bulletChart"){
##           chart
##             .x(function(d) { return d[opts.x] })
##             .y(function(d) { return d[opts.y] })
##         }
##           
##          
##         chart
##   .yScale( d3.scale.log() )
##           
##         chart.xAxis
##   .axisLabel("death.rate")
## 
##         
##         
##         chart.yAxis
##   .axisLabel("birth.rate")
##       
##        d3.select("#" + opts.id)
##         .append('svg')
##         .datum(data)
##         .transition().duration(500)
##         .call(chart);
## 
##        nv.utils.windowResize(chart.update);
##        return chart;
##       });
##     };
## </script>
```

```r
#n general, any chart method chart.x(y) translates to n1$chart(x = y) in rCharts, with y being decorated with tags if required.
```


