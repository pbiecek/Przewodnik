# Jak pobierać dane z Twittera?

Twitter udostępnia dwa API do pobierania danych.

* API do odczytywania historycznych wiadomości pasujących do określonego wzorca,
* API do aktywnego nasłuchiwania strumienia wiadomości pasujących do określonego wzorca (otrzymujemy zaledwie wycinek całego API).

Omówimy poniżej oba API.

## Autoryzacja z API Twittera

Aby móc automatycznie pobierać dane z Twittera należy ze strony https://apps.twitter.com pobrać klucze `Access Token` i `Access Token Secret`. 

Następnie, używając funkcji `setup_twitter_oauth()` należy autoryzować program R do pobierania danych. Poniżej klucze są wykropkowane, należy pobrać własne klucze z www strony.


```r
library(twitteR)

consumerKey <- "..................................."
consumerSecret <- "..................................."
access_token <- "..................................."
access_secret <- "..................................."

setup_twitter_oauth(consumerKey, consumerSecret, access_token, access_secret)
```

```
## [1] "Using direct authentication"
```

## Czytanie z historii Twittera

Po autoryzacji można dane pobrać używając funkcji `searchTwitter()`. Pierwszy argument określa słowa kluczowe, które będą wyszukiwane. Drugi argument określa ile wiadomości ma być pobranych. Kolejne argumenty pozwalają na dookreślenie, czy wiadomości mają być pobierane z określonego okresu czasu, czy określonej lokalizacji.

Wynikiem funkcji `searchTwitter()` jest lista obiektów opisujących wiadomości. Do analizy wygodniej jest tą listę zamienić na tabelę danych. Można to zrobić funkcją `twListToDF`. 

Poniższy przykład pobiera z Twittera 10 wiadomości zawierających słowo `chopin`. Następnie wynik zamienia na tabelę danych i wyświetla z tej tabeli trzy kolumny (numer, datę utworzenia i treść wiadomości).


```r
library(twitteR)
tweets <- searchTwitter("chopin", n=10)

dftweets <- twListToDF(tweets)
dftweets[,c("id", "created", "text")]
```

```
##                    id             created
## 1  703739618911502336 2016-02-28 00:32:54
## 2  703739332004216832 2016-02-28 00:31:46
## 3  703739324530081792 2016-02-28 00:31:44
## 4  703739032912732161 2016-02-28 00:30:34
## 5  703738659376373761 2016-02-28 00:29:05
## 6  703738344790839296 2016-02-28 00:27:50
## 7  703738246484914176 2016-02-28 00:27:27
## 8  703737940330070016 2016-02-28 00:26:14
## 9  703737600650059776 2016-02-28 00:24:53
## 10 703737487211032577 2016-02-28 00:24:26
##                                                                                                                                                                                                                                                                                     text
## 1                                                                                                                                                             RT @PGENarodowy: Kings On Ice. Tribute to Chopin już za nami! Dziękujemy Wam za wspólną zabawę :-) https://t.co/W2qlCuMC7i
## 2                                                                                                                                                                Relájense con \xed\xae\xba\xed\xb0\x97\xed\xae\xba\xed\xb0\x99\xed\xa0\xbc\xed\xbc\xb3  #chopin https://t.co/dzBLYJONrG
## 3  This Guy Perfectly Explains How to Recognize The Artist Of A Painting. He do indeed %%robert\xed\xa0\xbc\xed\xbe\x93\xed\xa0\xbd\xed\xb3\x9a\xed\xa0\xbc\xed\xbe\xb9\xed\xa0\xbc\xed\xbf\x9b\xed\xa0\xbc\xed\xbe\xa8\xed\xa0\xbc\xed\xbe\xa8 H/t @good_mewls  https://t.co/D4dmLgo9el
## 4                                                                                                                                               Friday night spent sleeping with a sausage dog curled up under my bed. Saturday night and I'm listening to Chopin on Myleen Klass' show.
## 5                                                                                                                                                                           #Chopin : Variations sur "La ci darem la mano" - N.Goerner / Orch du 18è siècle / F.Brüggen .#classicalmusic
## 6                                                                                                                                                                                やっぱり、もうちょいお絵描き！モイ！iPhoneからキャス配信中 - / 少しだけお絵描き https://t.co/ka3JGQmy75
## 7                                                                                                                                                                                                                               #INTL Suggest me the classic(s) instrument? Chopin, etc.
## 8                                                                                                                                                                                                           I liked a @YouTube video https://t.co/UkfHyvjzCb Chopin Sonata op.65 1st mvt
## 9                                                                                                                                                                                                            Chopin Funeral March (Arr. for Organ) https://t.co/K4pr8QkL6f 來自 @YouTube
## 10                                                                                                                                                                                                                     Pour travailler, se concentrer et tout, Chopin c'grave un bon ami
```

## Strumień wiadomości

Drugim sposobem pobierania danych z serwisu Twitter jest nasłuchiwanie przez określony okres czasu i zapisywanie wiadomości, które pasują do określonego wzorca. 
Ten sposób pobierania danych jest możliwy dzięki pakietowi `streamR`.

Aby z niego skorzystać musimy użyć innego sposobu autoryzacji OAuth.

Funkcja `handshake()` wywołana z obiektu klasy `OAuth` otworzy stronę internetową z kluczem, dzięki któremu będzie można dokonać autoryzacji.


```r
library(ROAuth)
requestURL <- "https://api.twitter.com/oauth/request_token"
accessURL <- "https://api.twitter.com/oauth/access_token"
authURL <- "https://api.twitter.com/oauth/authorize"

consumerKey <- ".............................."
consumerSecret <- ".............................."

my_oauth <- OAuthFactory$new(consumerKey=consumerKey,
                             consumerSecret=consumerSecret, 
                             requestURL=requestURL, accessURL=accessURL, authURL=authURL)
my_oauth$handshake(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"))
```

Po wykonaniu autoryzacji można pobierać wiadomości korzystając z funkcji `filterStream()` z pakietu `streamR`.

Przez okres czasu określony w sekundach przez argument `timeout` zapisuje do pliku `file` wiadomości pasujące do wzorca `track`.


```r
library(streamR)
filterStream(file="chopin.json",
             track="chopin, konkurs", 
             timeout=5*60, oauth=my_oauth) 
```

```
Capturing tweets...
Connection to Twitter stream was closed after 300 seconds with up to 41 tweets downloaded.
```

Po zebraniu danych można je następnie wczytać z pliku json do programu R z użyciem funkcji `parseTweet()`. Wczytuje ona wiadomości ze wskazanego pliku a następnie przekształca je do formatu ramki danych.



```r
parsedTwees <- parseTweets("chopin.json", simplify = FALSE, verbose = TRUE)
parsedTwees[,c("id_str", "created_at", "text")]
```

```
              id_str                     created_at
1 703746124276998145 Sun Feb 28 00:58:45 +0000 2016
2 703746342280159232 Sun Feb 28 00:59:37 +0000 2016
3 703746344213725185 Sun Feb 28 00:59:38 +0000 2016
4 703746680345067521 Sun Feb 28 01:00:58 +0000 2016
                                                                                                                                        text
1                                                                 Frédéric Chopin - Prelude in E-Minor (op.28 no. 4) https://t.co/EdwzCFZedd
2                                                                    Abbey Simon / Chopin: 3 Waltzes, Op. 64: No. 1 in D-Flat Major "Minute"
3 SprintAir to base Saab 340 in Radom from April - SprintAir (SRN, Warsaw Chopin) has announced another expansion... https://t.co/8mmHlDU9ry
4                                       RT @Norah_min: インスタ見た感じだとこのマートンのChopinで演ったっぽいね！？\nhttps://t.co/GlWT3zW11g
```

## Inne użyteczne funkcje

Poza filtrowaniem twittera w poszukiwaniu wiadomości pasujących do określonych słów kluczowych, można również pobierać dane w inny sposób.

* Funkcja `userTimeline()` pozwala na pobieranie ostatnich wiadomości utworzonych przez określonego użytkownika.
* Funkcja `homeTimeline()` pozwala na pobieranie wiadomości z linii aktualnego użytkownik.
* Funkcja `mentions()` pozwala na pobieranie wiadomości, w których określony użytkownik został mieniony.
* Funkcja `retweetsOfMe()` pozwala na zliczanie liczby retwittów kolejnych wiadomości.

Aby korzystać z powyżej opisanych pakietów należy pobrać z konta odpowiednie klucze. Szczegółowa instrukacj jak to zrobić, krok po kroku po stronie Twittera, znajduje się na stronie http://bigcomputing.blogspot.com/2016/02/the-twitter-r-package-by-jeff-gentry-is.html.
