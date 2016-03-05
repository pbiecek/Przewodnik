# Jak filrować wiersze?

Funkcja `filter()` pozwala na wybór tylko wierszy spełniających określony warunek

```{r, warning=FALSE}
tmp <- filter(auta2012,
        Marka == "Porsche")
head(tmp)
```

Możemy określać jednocześnie więcej warunków.

```{r, warning=FALSE}
tylkoPorscheZDuzymSilnikiem <- filter(auta2012,
         Marka == "Porsche",
         KM > 300)
head(tylkoPorscheZDuzymSilnikiem)
```
