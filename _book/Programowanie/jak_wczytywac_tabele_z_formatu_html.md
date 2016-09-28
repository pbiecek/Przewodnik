# Jak wczytywać tabele z formatu HTML?

Bardzo często, dane które chcemy wczytać do R są dostępne w postaci tabeli na stronie HTML.

Takie dane można odczytać na różne sposoby. Poniżej przedstawimy dwa najczęstsze.

## Poprawnie sformatowana tabela HTML

Jeżeli tabela HTML jest poprawnie sformatowana, to najwygodniej jest wykorzystać funkcję `readHTMLTable` z pakietu `XML`. Wczytuje ona całą stronę internetową do R, następnie ją analizuje tak by wyłuskać z niej tabele. Wynikiem działania tej funkcji jest lista z tabelami znalezionymi na stronie.

Prześledźmy działanie tej funkcji na przykładzie czytania danych z strony Wikipedii, ze strony o liście meczów reprezentacji Polski w piłce nożnej
https://pl.wikipedia.org/wiki/Lista_mecz%C3%B3w_reprezentacji_Polski_w_pi%C5%82ce_no%C5%BCnej. 
Stronę HTML odczytujemy i pobieramy funkcją `getURL()`. Na tej przykłądowej stronie znajduje się wiele tabel. Funkcja `readHTMLTable` wczyta je wszystkie a jako wynik zwróci listę tabel.


```r
library(XML)
library(RCurl)
link <- "https://pl.wikipedia.org/wiki/Lista_mecz%C3%B3w_reprezentacji_Polski_w_pi%C5%82ce_no%C5%BCnej"
xData <- getURL(link)
tabele <- readHTMLTable(xData, stringsAsFactors = FALSE)
length(tabele)
```

```
## [1] 9
```

Wszystkich tabel jest 9. 

Pierwsza z nich to tabela ze statystykami meczów.


```r
statystyki <- tabele[[1]]
head(statystyki)
```

```
##    Lp.  Data         Miejsce  Gospodarz    –    Gość     Wynik
## 1 2001  <NA>            <NA>       <NA> <NA>    <NA>      <NA>
## 2 594. 28.02 *Larnaka (Cypr) Szwajcaria    –  Polska 0:4 (0:2)
## 3 595. 24.03            Oslo   Norwegia    –  Polska 2:3 (0:2)
## 4 596. 28.03        Warszawa     Polska    – Armenia 4:0 (2:0)
## 5 597. 25.04       Bydgoszcz     Polska    – Szkocja 1:1 (0:0)
## 6 598. 02.06         Cardiff      Walia    –  Polska 1:2 (1:1)
##                                                           Bramki dla Polski
## 1                                                                      <NA>
## 2         Emmanuel Olisadebe, Bartosz Karwan, Tomasz Hajto, Jacek Krzynówek
## 3                                 eMŚ, Emmanuel Olisadebe 2, Bartosz Karwan
## 4 eMŚ, Michał Żewłakow, Emmanuel Olisadebe, Marcin Żewłakow, Bartosz Karwan
## 5                                                          Radosław Kałużny
## 6                               eMŚ, Emmanuel Olisadebe, Paweł Kryszałowicz
```

## Skubanie strony HTML

Jeżeli dane nie są w poprawnej tabeli HTML, ale są formatowane np. jako elementy `div`, to alternatywny sposób pobierania danych polega na wczytaniu całej strony HTML a następnie wyrażeniami regularnymi wydzieraniu poszczególnych elementów strony.

W poniższym przykładzie to skubanie jest rozłożone na kilka etapów. Najpierw odczytujemy treść strony internetowej.


```r
link <- "https://pl.wikipedia.org/wiki/Lista_mecz%C3%B3w_reprezentacji_Polski_w_pi%C5%82ce_no%C5%BCnej"
html <- readLines(link)
html <- paste(html, collapse="")
```

Następnie wyrażeniem regularnym wycinamy fragment z interesującą nas tabelą.


```r
tmp1 <- strsplit(html, split="Lata 2001–2010")[[1]][5]
tabelaZeStatystykami <- strsplit(tmp1, split="Uwagi")[[1]][1]
```

Tabele dzielimy na wiersze (znaczniki tr) a wiersze na komórki (znaczniki td)


```r
tmp3 <- strsplit(tabelaZeStatystykami, split="<tr>")[[1]]
komorki <- strsplit(tmp3, split="<.?td>")
```

Następnie z każdego wiersza wyłuskujemy wartości z 7 kolumny, czyli wynik meczu.


```r
mecze <- sapply(komorki, function(x) x[14])
mecze <- gsub(mecze, pattern=" .*$", replacement="")
```

I tak po kilku krokach możemy wykonywać kolejne analizy na tak wyłuskanych statystykach.


```r
table(mecze)
```

```
## < table of extent 0 >
```

