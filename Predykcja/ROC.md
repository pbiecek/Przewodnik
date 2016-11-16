# ROC, AUC i inne

Mając klasyfikator, często potrzebujemy narzędzia, które pozwoli ocenić jego jakość.

Przyjrzyjmy się lasom losowym dla dwóch zmiennych. To są obszary decyzyjne.


```r
library("Przewodnik")
titanic2 <- na.omit(titanic)

library("randomForest")
rf <- randomForest(Survived~Age+Fare, data=titanic2)

grid <- expand.grid(Age=seq(0,90, length.out=100),
                    Fare=seq(0,250, length.out=100))
pred_rf <- predict(rf, grid, type="prob")[,1]
grid$posterior_rf <- pred_rf

ggplot(grid, aes(Age, Fare, color=posterior_rf)) + 
  geom_point(size=1)
```

![plot of chunk obszary](figure/obszary-1.png)

Funkcją `varImpPlot` możemy pokazać ranking ważności zmiennych. 


```r
rf <- randomForest(Survived~., data=titanic2)
importance(rf)
```

```
##          MeanDecreaseGini
## Pclass          34.705861
## Sex             87.069807
## Age             58.658998
## Fare            62.045679
## Embarked         8.153328
```

```r
varImpPlot(rf)
```

![plot of chunk unnamed-chunk-1](figure/unnamed-chunk-1-1.png)

Lasy losowe jako wynik zwracają wartości scorów z przedziału 0-1. 

Aby ocenić jakość takich scorów często stosuje się krzywą ROC (Receiver operating characteristic), przedstawiającą zmianę dwóch współczynników, jako funkcję przyjętego punktu odcięcia.

* czułość (sensitivity) - true positive rate
$$
TPR = \frac{TP}{P} = \frac{y = +, \hat y = +}{\hat y = +}
$$

* specyficzność (specificity) - true negative rate
$$
SPEC = \frac{TN}{N} = \frac{y = -, \hat y = -}{\hat y = -}
$$

* accuracy - skuteczność
$$
ACC = \frac{TN+TP}{n}
$$

* Youden J = czułość + specyficzność - 1.


```r
library("caret")
inds <- createDataPartition(titanic2$Survived, p = 0.75)
titanic2_train <- titanic2[inds[[1]],]
titanic2_test  <- titanic2[-inds[[1]],]

rf <- randomForest(Survived~Age+Fare, data=titanic2_train)

library("plotROC")
pred_rf <- predict(rf, titanic2_test, type="prob")[,2]

roc.estimate <- calculate_roc(pred_rf, titanic2_test$Survived)
single.rocplot <- ggroc(roc.estimate)
```

```
## ggroc is deprecated. Please use geom_roc instead. Type ?geom_roc for more information.
```

```r
plot_journal_roc(single.rocplot)
```

```
## Scale for 'x' is already present. Adding another scale for 'x', which
## will replace the existing scale.
```

```
## Scale for 'y' is already present. Adding another scale for 'y', which
## will replace the existing scale.
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2-1.png)

```r
library("ROCR")
pred <- prediction( pred_rf, titanic2_test$Survived)
perf <- performance(pred,"tpr","fpr")
plot(perf,col="blue")
abline(0,1)
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2-2.png)

Aby ocenić jakość klasyfikatora można wykorzystać całą krzywą ROC lub pole pod nią - AUC.

Jeżeli chcemy wybrać optymalny punkt podziału, wygodnie jest skorzystać z pakietu `OptimalCutpoints` i funkcji `optimal.cutpoints` wybierającej optymalny punkt podziału.


```r
library("OptimalCutpoints")
pref_df <- data.frame(pred = pred_rf, truth = titanic2_test$Survived)
oc <- optimal.cutpoints(X = "pred", status = "truth", methods="Youden", data=pref_df, tag.healthy = "0")
summary(oc)
```

```
## 
## Call:
## optimal.cutpoints.default(X = "pred", status = "truth", tag.healthy = "0", 
##     methods = "Youden", data = pref_df)
## 
## Area under the ROC curve (AUC):  0.651 (0.566, 0.736) 
## 
## CRITERION: Youden
## Number of optimal cutoffs: 1
## 
##                     Estimate
## cutoff             0.5600000
## Se                 0.4861111
## Sp                 0.7641509
## PPV                0.5833333
## NPV                0.6864407
## DLR.Positive       2.0611111
## DLR.Negative       0.6724966
## FP                25.0000000
## FN                37.0000000
## Optimal criterion  0.2502621
```

```r
plot(oc)
```

![plot of chunk oc](figure/oc-1.png)![plot of chunk oc](figure/oc-2.png)

