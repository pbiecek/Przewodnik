# Sejm Senat

Dane o statystykach różnych form słowa na podstawie stenogramów z Sejmu i Senatu.

Dane dostępne są pod adresem `archivist::aread("pbiecek/Przewodnik/arepo/a3666b4084daa5db9251dc36e3286298")`.

```
library(PBImisc)

SejmSenat <- SejmSenat
head(SejmSenat)

setLocalRepo("~/GitHub/Przewodnik/arepo")
saveToLocalRepo(SejmSenat)


library(ca)
plot(ca(SejmSenat[-15,]), mass =c(TRUE,TRUE), arrows =c(FALSE,TRUE), bty="n")

#The IPI PAN Corpus webpage http://korpus.pl/
summary(ca(SejmSenat[-15,]))

```

Więcej przykładów:

http://smarterpoland.pl/index.php/2011/12/o-czym-sie-mowi-w-sejmie-i-senacie/


A dla samochodów

```
library(PogromcyDanych)
library(ca)

contingency <- table(auta2012$Kolor, auta2012$Marka)
# tylko kolory i marki, dla których jest przynajmenij 500 ofert sprzedaży
tab <- contingency[rowSums(contingency) > 500, colSums(contingency) > 500]

plot(ca(tab), arrows = c(TRUE, FALSE))
```
