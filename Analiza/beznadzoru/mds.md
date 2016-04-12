# Jak zrobić skalowanie na przestrzeń o niskim wymiarze?

Problem, który będziemy rozwiązywać w tym rozdziale jest następujący:

Mamy symetryczną macierz $$D = [d_{i,j}]$$, będącą macierzą podobieństw pomiędzy $$n$$ obiektami. Na podstawie tej macierzy szukamy $$p$$ wymiarowej reprezentacji w przestrzeni $$\mathcal R^p$$, takiej by podobieństwa pomiędzy obiektami były zachowane.

Ten problem można rozwiązać na wiele sposobów, poniżej przedstawimy najbardziej klasyczne podejścia zachęcając jednocześnie czytelnika do szukania innych.

Problem skalowania wielowymiarowego ma wiele zastosowań zarówno w eksploracji danych, wizualizacji danych czy tzw. identyfikacji struktur w danych. W ogólnym przypadku możemy obiekty reprezentować na $$p$$ wymiarowej przestrzeni z dowolną metryką, ale w przykładach skupimy się na reprezentacji dwu-wymiarowej z odległością Euklidesową.


## Skalowanie metryczne

Oznaczmy przez $$x_i \in \mathcal R^p$$ współrzędne reprezentacji obiektu $$i$$ w nowej, zredukowanej przestrzeni.

Problem szukania $$p$$ wymiarowej reprezentacji można zamienić na problem optymalizacji funkcji opisującej błąd odwzorowania. Wprowadźmy następującą funkcję zniekształcenia (tzw. funkcję ang. *stress*).

$$
stress_1 = \left( \sum_{i,j} (d_{i,j} - ||x_i - y_j||)^2 \right)^{\frac 12}
$$

Opisuje ona różnice pomiędzy zadanymi odległościami, a odległościami w nowej przestrzeni. Minimalizacja funkcji $$stress_1$$ sprowadza się do znalezienia optymalnych wartości dla współrzędnych $$x_i$$. 

Z punktu widzenia optymalizacji, możemy również minimalizować poniższą funkcję, która ma jednak taką zaletę, że wartości nie zależą już od wybranej jednostki. Zauważmy też, że dla optymalizacji nie ma również znaczenia pierwiastek. 

$$
stress_2 = \left( \frac{ \sum_{i,j} (d_{i,j} - ||x_i - y_j||)^2 }{ \sum_{i,j} d^2_{i,j} } \right)^{\frac 12}
$$


W ogólnym przypadku minimalizacja funkcji $$stress_1$$ nie jest łatwa i wykorzystuje się do niej algorytmy iteracyjne oparte na gradientach. Ogólny schemat takiego algorytmu jest następujący.

1. Wyznacz początkowa konfigurację (może być losowa, lub oparta o skalowanie klasyczne),
2. Wyznacz macierz odległości pomiędzy obiektami w bieżącej konfiguracji $$\delta{i,j} = ||x_i - x_j||$$,
3. Wykonaj regresję odległości $$\delta_{i,j}$$ na oryginalne odległości $$d_{i,j}$$,
$$
d_{i,j} = \alpha + \beta \delta_{i,j},
$$
to nie musi być liniowa regresja, ale coś co sprowadzi $$\delta_{i,j}$$ do skali $$d_{i,j}$$,
4. Wyznacz bieżącą wartość funkcji $$stress$$
$$
stress = \left( \frac{ \sum_{i,j} (d_{i,j} - \hat\delta_{i,j})^2 }{ \sum_{i,j} d^2_{i,j} } \right)^{\frac 12},
$$
5. Na bazie gradientu funkcji $$stress$$ uaktualnij współrzędne reprezentacji $$x_i$$. 

Powyższy algorytm ma wiele wariantów, różniących się np. adaptacyjnym wyborem długości kroku w punkcie 5 lub dodaniem wag. Schemat jest jednak podobny.



