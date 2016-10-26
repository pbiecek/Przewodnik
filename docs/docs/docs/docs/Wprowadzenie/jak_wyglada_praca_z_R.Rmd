# Jak wygląda praca z programem R?

Praca z programem R jest najczęściej pracą interaktywną. 
Sam program R jest często kojarzony z konsolą w której mruga kursor i do której wprowadza się polecenia i z której odczytuje się wyniki.

Aby oddać ten styl pracy, w tej książce będziemy przedstawiać przykłady instrukcji R, wraz z wynikami, które te instrukcje generują.
Zarówno instrukcje R jak i ich wyniki będą otoczone szarą ramką aby łatwiej było je odnaleźć.
Wyniki są w liniach oznaczonych podwójnym komentarzem `##`.

Przykładowo, funkcja `substr()` wycina z napisu podnapis o wskazanych współrzędnych. Po uruchomieniu programu R, wystarczy wpisać do konsoli poniższą instrukcję, aby w tej samej konsoli pojawił się wynik. Tutaj wynikiem jest napis składający się z jednej litery `R`.

```
substr("Co jest supeR?", start = 13, stop = 13)
## [1] "R"
```

Pisząc o funkcjach, pakietach, elementach języka stosować będziemy `czcionkę o stałej szerokości znaków`. Podając angielskie nazwy będziemy je oznaczać *kursywą*. Przy pierwszym wymienieniu nazwy funkcji z niestandardowego pakietu zaznaczymy również w jakim pakiecie ta funkcja jest dostępna. Zapis `ggplot2::qplot()` oznacza, że funkcja `qplot()` znajduje się w pakiecie `ggplot2`. Czasem funkcja o tej samej nazwie dostępna jest w różnych pakietach, wskazując w ten sposób jawnie w którym pakiecie dana funkcja się znajduje pozwala na jednoznaczne określenie o którą funkcję chodzi. Również w sytuacji gdy do użycia danej funkcji potrzeba zainstalować lub włączyć niestandardowy pakiet, warto wiedzieć w jakim pakiecie danej funkcji szukać. Na końcu tej książki znajduje się indeks funkcji zarówno alfabetyczny jak i w podziale na pakiety.
