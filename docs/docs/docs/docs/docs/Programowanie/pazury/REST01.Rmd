# Jak uruchomić RESTowy serwer?

Zacznijmy od przykładu. Uruchomimy lokalnie serwer RESTful bazujący na R na porcie 4348.

Samo włączenie pakietu `opencpu` startuje serwer na losowym porcie. Dlatego poniżej najpierw ten serwer zamykamy, a następnie uruchamiamy ponownie na wskazanym porcie `4348` (początkowy port można określić w plikach konfiguracyjnych).

```r
library(opencpu)
opencpu$stop()
opencpu$start(4348)
```

```
Initiating OpenCPU server...
Using config: /Users/pbiecek/.opencpu.conf
OpenCPU started.
[httpuv] http://localhost:4348/ocpu
OpenCPU single-user server ready.
```

Serwer został uruchomiony w tle. 

Ale jak to rozpoznać? Np. za pomocą programu *Network Utility* można sprawdzić listę otwartych portów (ilustracja poniżej).

![Lista otwartych portów](figure/aplikacja1.png)

Domyślnie serwer uruchamia się na interfejsie `localhost`. Możemy więc odpytywać ten serwer przez przeglądarkę internetową, taką jak chrome, firefox czy safari.

Testowa strona do budowania zapytań od serwera jest dostępna pod adresem `http://localhost:4348/ocpu/test/`. 

Pozwala ona w prosty sposób budować zapytania GET i POST. Poniżej przedstawiamy ilustracje jak wygląda ta strona. Na jednym ekranie widać i parametry zapytania i parametry odpowiedzi z serwera.

![Testowa aplikacja www](figure/aplikacja2.png)



