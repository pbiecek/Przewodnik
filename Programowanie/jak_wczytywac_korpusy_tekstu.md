# Jak wczytywać korpusy tekstu?

Dane nie zawsze mają strukturę tabeli. Czasem jedyną opcją jest wczytanie pliku jako wektora napisów - linia po linii. Do tego celu można użyc funkcji `readLines()`, która potrafi wczytać dane zarówno z lokalnego pliku jaki bezpośrendnio z adresu URL w internecie.

Wykorzystajmy tę funkcję, aby z projektu Gutenberg www.gutenberg.org wczytać treść ksiażki Juliusza Verne, ,,W 80 dni dookoła świata'' (http://www.gutenberg.org/cache/epub/103/pg103.txt).

```
# W 80 dni dookoła świata
w80dni <- readLines("http://www.gutenberg.org/cache/epub/103/pg103.txt")

# Kilka pierwszych linii
head(w80dni)
```

```
## [1] "The Project Gutenberg EBook of Around the World in 80 Days, by Jules Verne"
## [2] ""                                                                          
## [3] "This eBook is for the use of anyone anywhere at no cost and with"          
## [4] "almost no restrictions whatsoever.  You may copy it, give it away or"      
## [5] "re-use it under the terms of the Project Gutenberg License included"       
## [6] "with this eBook or online at www.gutenberg.net"
```

Zobaczmy jakie słowa sa najczęściej uzywane w tej powieści.

```
# rozbicie linii na słowa
slowa <- unlist(strsplit(w80dni, split="[^A-Za-z0-9]+"))
# liczba słów i charakterystyki
length(slowa)
```

```
## [1] 68460

```
# Najczęstsze słowa
head(sort(table(slowa), decreasing = TRUE), 50)
```

```
## slowa
##          the          and           of           to            a 
##         4312         1896         1876         1720         1281 
##           in          was                       his           he 
##          997          995          966          807          773 
##         Fogg           at         with          not          The 
##          608          583          553          519          518 
##         that           on          had        which          for 
##          514          504          494          442          433 
##           it           as Passepartout           Mr           by 
##          418          403          398          389          377 
##            I          him           is           be          you 
##          368          321          320          316          308 
##         were         from         this            s        would 
##          307          304          300          283          270 
##         have          but          Fix           an      Phileas 
##          262          248          245          225          220 
##           He          who           or         said         they 
##          217          200          191          191          184 
##          her           It          are         been          all 
##          171          171          170          169          167
```

## Inne przydatne narzędzia

Pakiet Rpoppler https://cran.r-project.org/web/packages/Rpoppler/index.html umożliwia korzystanie z funkcjonalności biblioteki poppler http://poppler.freedesktop.org/ do pracy z dokumentami pdf. Między innymi umożliwia ekstrakcje tekstu z dokumentów pdf.



