# Jak wczytywać korpusy tekstu?

Dane nie zawsze mają strukturę tabeli. Czasem jedyną opcją jest wczytanie pliku jako wektora napisó∑ - linia po linii. Do tego celu można użyc funkcji `readLines()`, która potrafi wczytać dane zarówno z lokalnego pliku jaki bezpośrendnio z adresu URL w internecie.

Wykorzystajmy tę funkcję, aby z projektu Gutenberg www.gutenberg.org wczytać treść ksiażki Juliusza Verne, ,,W 80 dni dookoła świata'' (http://www.gutenberg.org/cache/epub/103/pg103.txt).


```r
# W 80 dni dookoła świata
w80dni <- readLines("http://www.gutenberg.org/cache/epub/103/pg103.txt")
```

```
## Warning in readLines("http://www.gutenberg.org/cache/epub/103/pg103.txt"):
## incomplete final line found on 'http://www.gutenberg.org/cache/epub/103/
## pg103.txt'
```

```r
# Kilka pierwszych linii
head(w80dni)
```

```
## [1] "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML+RDFa 1.0//EN\" \"http://www.w3.org/MarkUp/DTD/xhtml-rdfa-1.dtd\">"
## [2] "<html xmlns=\"http://www.w3.org/1999/xhtml\">"                                                              
## [3] ""                                                                                                           
## [4] ""                                                                                                           
## [5] "<head>"                                                                                                     
## [6] "<style type=\"text/css\">"
```

Zobaczmy jakie słowa sa najczęściej uzywane w tej powieści.


```r
# rozbicie linii na słowa
slowa <- unlist(strsplit(w80dni, split="[^A-Za-z0-9]+"))
# liczba słów i charakterystyki
length(slowa)
```

```
## [1] 1758
```

```r
## [1] 68460
# Najczęstsze słowa
head(sort(table(slowa), decreasing = TRUE), 50)
```

```
## slowa
##                    td         tr         en       lang         id 
##        254         84         52         50         48         33 
##         th        div        xml      class       type      title 
##         32         28         26         25         24         21 
##          a    content       name       meta     button  Gutenberg 
##         20         18         18         17         16         16 
##  recaptcha    Project       href          p    captcha     search 
##         16         15         14         14         13         13 
##       icon      input        www  gutenberg        org       text 
##         12         12         12         11         11         11 
##        var     ebooks       http      table     dialog     jquery 
##         11         10         10         10          8          8 
##     script       span      value          w      audio       form 
##          8          8          8          8          7          7 
##         if      image javascript       only   property   question 
##          7          7          7          7          7          7 
##      badge         by 
##          6          6
```

