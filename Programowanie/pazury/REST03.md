## Jak zdalnie wywołać funkcję?

W pakiecie `opencpu` operacja GET służy do pobierania danych.
Aby wywołać zdalnie funkcję należy wykorzystać operację POST. 
Można to zrobić z użyciem funkcji `httr::POST`. Argumenty zdalnego wywołania można podać jako listę, przekazując ją przez argument `body`.

Przyjrzyjmy się przykładowemu wywołaniu. Uruchomimy zdalnie funkcję `rnorm` z jednym argumentem `n = 5`. Wynik zostanie zapisany do katalogu dostępnego pod uchwytem `/ocpu/tmp/x009700e95f`.

```r
(tmp <- httr::POST("http://localhost:4348/ocpu/library/stats/R/rnorm", 
           body = list(n = "5")))
```

```
Response [http://localhost:4348/ocpu/library/stats/R/rnorm]
  Date: 2016-05-06 17:39
  Status: 201
  Content-Type: text/plain; charset=utf-8
  Size: 184 B
/ocpu/tmp/x009700e95f/R/.val
/ocpu/tmp/x009700e95f/stdout
/ocpu/tmp/x009700e95f/source
/ocpu/tmp/x009700e95f/console
/ocpu/tmp/x009700e95f/info
/ocpu/tmp/x009700e95f/files/DESCRIPTION
```

Po zdalnym wywołaniu funkcji na serwerze powstaje zapis sesji z wynikami przetwarzania. Taką sesję można odpytywać. Np. aby odczytać listę obiektów R w sesji można sięgnąć do uchwytu `http://localhost:4348/ocpu/tmp/x009700e95f/R/`. 

Możemy te wyniki odczytać w R na wiele sposobów. Przedstawmy trzy najprostsze. Sięgniemy do `ocpu/tmp/x009700e95f/R/.val` odczytując ten obiekt jako plik rda, csv czy plik R.

* odczytywanie wyników przez parsowanie funkcji `print()`

```r
(tmp <- httr::GET("http://localhost:4348/ocpu/tmp/x009700e95f/R"))
rawToChar(tmp$content)
```

```
[1] "[1] -0.1798980  1.3466641  1.1543092  0.2607556 -0.3512327\n"
```

* odczytywanie wyników w formacie rda przez funkcję `load()`

```r
(load(url("http://localhost:4348/ocpu/tmp/x009700e95f/R/.val/rda")))
.val
```

```
[1] -0.1798980  1.3466641  1.1543092  0.2607556 -0.3512327
```

* odczytywanie wyników w formacie csv z użyciem funkcji `readLines()`

```r
readLines(url("http://localhost:4348/ocpu/tmp/x009700e95f/R/.val/csv"))
```

```
[1] "\"x\""              "-0.179898029143394" "1.34666410945253"  
[4] "1.15430921232522"   "0.260755573763041"  "-0.351232739954579"
```

## Jak przekazywać dodatkowe argumenty do funkcji?

Wywołując zdalnie funkcje możemy wskazać jako parametr wartość, wyrażenie R lub wynik z innego wyrażenia, które było poprzednio policzone.

Poniżej przedstawiamy przykład dla każdej z tych możliwości.

```r
# argumenty przekazane jako wartości
httr::POST("http://localhost:4348/ocpu/library/stats/R/rpois", 
           body = list(n = "1", lambda= "10"))

# przekazanie kodu R jako argumentu
httr::POST("http://localhost:4348/ocpu/library/stats/R/rexp", 
           body = list(n = "sqrt(9)", rate= "1"))

# przekazanie wyników jednej funkcji jako argumentu do drugiej
httr::POST("http://localhost:4348/ocpu/library/stats/R/rexp", 
           body = list(n = "x01bbf1e095", rate= "1"))
```
