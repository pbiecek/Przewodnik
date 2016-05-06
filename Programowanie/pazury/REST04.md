## Jak zdalnie zbudowac wykres?

Wynikiem zdalnego wywołania funkcji mogą być nie tylko obiekty R, ale też grafika/wykresy np. w formacie png, pdf lub svg.

Jak stworzyć taki wykres? Wystarczy zdalnie wykonać funkcję, która wykres wyprodukuje. Zobaczmy przykłąd z użyciem histogramu generowanego przez funkcję `hist()`.

```r
httr::POST("http://localhost:4348/ocpu/library/graphics/R/hist", 
           body = list(x = "[0,1,1,1,1,5]", col="'black'"))
```

```
Response [http://localhost:4348/ocpu/library/graphics/R/hist]
  Date: 2016-05-06 17:53
  Status: 201
  Content-Type: text/plain; charset=utf-8
  Size: 188 B
/ocpu/tmp/x051d8acae9/R/.val
/ocpu/tmp/x051d8acae9/graphics/1
/ocpu/tmp/x051d8acae9/source
/ocpu/tmp/x051d8acae9/console
/ocpu/tmp/x051d8acae9/info
/ocpu/tmp/x051d8acae9/files/DESCRIPTION
```

Odwołać do wyników można się przez uchwyt wsazywany jako wynik funkcji `POST`, czyli

* `http://localhost:4348/ocpu/tmp/x051d8acae9`
* jeżeli jest wiecej wykresów to można wskazać który ma być odczytany `http://localhost:4348/ocpu/tmp/x051d8acae9/graphics/1/pdf`

## Jak pobrać całą sesje z uruchomienia zdalnego funkcji

Wynik wywołania funkcji - cała sesja - może być pobrana jako jeden plik
`http://localhost:4348/ocpu/tmp/x051d8acae9/zip`.

Wynik przetwarzania może być wyświetlony 
`http://localhost:4348/ocpu/tmp/x051d8acae9/console/text`.

## Jak używać funkcji z własnych pakietów?

Wywoływanie zdalne funkcji z pakietów standardowych ma pewne zalety. Ale znacznie bardziej przydatne jest udostępnianie własnych funkcjonajlności pozamykacnych jako wynkcje we własnych pakietach.

Przykłądowo, zbudowałem własny pakiet `proton`, który udostępnia funkcję `dcode()`. Zobaczmy jak ją uruchomić lokalnie i zdalnie

* wykonanie lokalne

```r
proton:::dcode('Zakoduj to')
```

```
"aZPLWFQ GL"
```

* Równowazne wykonanie zdalne

```r
httr::POST("http://localhost:4348/ocpu/library/proton/R/dcode", 
           body = list(tex = "'Zakoduj to'"))
```

```
Response [http://localhost:4348/ocpu/library/proton/R/dcode]
  Date: 2016-05-06 19:02
  Status: 201
  Content-Type: text/plain; charset=utf-8
  Size: 184 B
/ocpu/tmp/x0872f3db8b/R/.val
/ocpu/tmp/x0872f3db8b/stdout
/ocpu/tmp/x0872f3db8b/source
/ocpu/tmp/x0872f3db8b/console
/ocpu/tmp/x0872f3db8b/info
/ocpu/tmp/x0872f3db8b/files/DESCRIPTION
```

* Ze zdalnego wywołania musimy jeszcez wyłuskać wyniki

```r
load(url("http://localhost:4348/ocpu/tmp/x0872f3db8b/R/.val/rda"))
.val
```

```
[1] "aZPLWFQ GL"
```

