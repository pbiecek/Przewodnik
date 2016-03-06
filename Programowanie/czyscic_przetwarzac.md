# Jak czyścić i przetwarzać dane?

Program `R` jest wyposażony w olbrzymią liczbę funkcji do przetwarzania danych. 
I w tym przypadku słowo `olbrzymią` nie jest nadużyciem, tych funkcji są dosłownie tysiące.

Niektóre dane wymagają bardzo specjalistycznego przetwarzania (np. pliki dźwiękowe, zdjęcia, obrazy video), ale w przypadku przetwarzania obowiązuje zasada 80/20 (tzw. zasada Parta) która w tym przypadku oznacza, że aby efektywnie wykonywać większość (nie wszystkie, ale np. 80% wszystkich możliwych) przetwarzań wystarczy znać jedynie część z wszystkich funkcji.

Hadley Wickham przygotował dwa pakiety, `dplyr` i `tidyr` które w sumie udostępniają jedynie kilka funkcji, jednak te funkcje można na tyle elastycznie łączyć, że w sumie pozwalają one na wykonanie większości typowych operacji na danych.

Funkcje w tych pakietach nazwał czasownikami a proces analizy danych przyrównał do konstrukcji zdania. Podstawowymi czasownikami są 

* `filter()` - wybieranie wierszy, 
* `select()` - wybieranie kolumn,
* `arrange()` - sortowanie wierszy,
* `group_by()` - określanie grup,
* `summarise()` - liczenie agregatów,
* `gather() / spread()` - przechodzenie pomiędzy postaciami wąską a szeroką w danych.

Te podstawowe czasowniki są opisane w kolejnych podrozdziałach. 

Więcej funkcji pozwalających na eksploracje danych przedstawionych jest w [ściągawce opracowanej przez RStudio](https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf).

