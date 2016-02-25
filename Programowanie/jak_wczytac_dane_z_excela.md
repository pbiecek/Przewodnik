# Jak wczytać dane z Excela?

Jedną z najbardziej popularnych form przechowywania danych tabelarycznych są pliki Excela. Poniżej pokażemy jak takie dane odczytać z pliku Excela bezpośrednio do programu R.

Jako przykład wykorzystamy dane udostępniane przez Główny Urząd Statystyczny (GUS) w Danku Danych Lokalnych (BDL) https://bdl.stat.gov.pl/BDL/dane/wymiary. Przez interface www można wyklinać jakie wskaźniki w jakich grupach chcemy pobrać, a następnie możemy pobrać je w formacie pliku Excela.

![Druga zakładka z pliku Excela](resources/BDL1.png)

![Trzecia zakładka z pliku Excela](resources/BDL2.png)



```r
library(openxlsx)
ludnosc <- read.xlsx("resources/LUDN_2137_20160225144358.xlsx", sheet = 2)
```

```
## Error in read.xlsx.default("resources/LUDN_2137_20160225144358.xlsx", : Excel file does not exist.
```

```r
head(ludnosc)
```

```
##   TERYT_CODE TERYT_NAME   AGE   SEX YEAR MEASURE.UNIT    VALUE ATTRIBUTE
## 1 0000000000     POLAND total total 1995       person 38609399          
## 2 0000000000     POLAND total total 1996       person 38639341          
## 3 0000000000     POLAND total total 1997       person 38659979          
## 4 0000000000     POLAND total total 1998       person 38666983          
## 5 0000000000     POLAND total total 1999       person 38263303          
## 6 0000000000     POLAND total total 2000       person 38253955
```


