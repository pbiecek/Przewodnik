# Jak rozpoznać rodzaj zmiennej?

W całym poniższym rozdziale słowo `zmienna` będzie wykorzystywane nie w kontekście programistycznym (obiekt), ale w kontekście statystycznym (obserwowana cecha). 

Zanim zaczniemy poważniejsze tematy musimy uzgodnić podstawy. Pierwszą, być może najważniejszą rzeczą, o której należy pamiętać wykonując jakiekolwiek analizy, jest to, że *dane liczbowe to nie tylko liczby!!!*

Jeżeli nie tylko liczby to co jeszcze? 

To liczby i ich znaczenie. Wydaje się tak oczywiste, że często się o tym zapomina, co niestety ma przykre konsekwencje. Przykładowo, jeżeli mamy zmienną o nazwie wiek i jest w niej wartość 9, to może ona mieć wiele znaczeń. Może jest to wiek w latach, może wartość 9 koduje pewien przedział wiekowy, np. 90+ lat, być może wartość 9 koduje brak danych (czasem wartościami 9, 99, 999 koduje się braki danych), być może to wiek ale w miesiącach. W zależności od tego co znaczy określona wartość należy ją inaczej traktować.

Przyjmijmy następujący podział zmiennych:

* Zmienne jakościowe (nazywane również wyliczeniowymi, czynnikowymi lub kategorycznymi), to zmienne przyjmujące określoną liczbę wartości (najczęściej nie liczbowych). Zmienne te można dalej podzielić na: 
  + binarne (nazywane również dwumianowymi, dychotomicznymi) np. płeć (poziomy: kobieta/mężczyzna),
	+ nominalne (nazywane również zmiennymi jakościowymi nieuporządkowanymi) np. marka samochodu,
	+ uporządkowane, np. wykształcenie (poziomy: podstawowe/średnie/wyższe), ocena z przedmiotu.
* Zmienne ilościowe, z których można dodatkowo wyróżnić:
	+ zliczenia (liczba wystąpień pewnego zjawiska, opisywana liczbą całkowitą), np. liczba lat nauki, liczba wypadków,
	+ ilorazowe, czyli zmienne mierzone w skali, w której można dzielić wartości (ilorazy mają sens). Np. długość w metrach (coś jest 2 razy dłuższe, 10 razy krótsze itp.),
	+ przedziałowe (nazywane też interwałowymi), mierzone w skali, w której można odejmować wartości (wyznaczać długość przedziału). Np. daty, można liczyć czas pomiędzy dwoma datami ale nie ma sensu ich dzielić. Też temperatura, można liczyć różnice temperatur w stopniach Celsjusza, ale nie ma sensu liczyć ilorazu.

W zależności od tego co opisuje zmienna, można na niej wykonywać inne operacje. Dla zmiennych w skali uporządkowanej można wyznaczać wartość minimalną, maksymalną, środkową. Ale może nie mieć sensu liczenie średniej.

Warto dodać, że różnice zmiennych na skali przedziałowej (skali z jednostką), a więc długości przedziałów, są już na skali ilorazowej (skali z bezwzględną wartością 0). Przykładowo, dat 2016 r n.e. i 1995 r n.e. nie można dzielić (jaki sens miałby taki iloraz?) ale można odejmować. Różnica to 11 lat a lata można już dzielić (11 lat to dwa razy mniej niż 22 lata). Podobnie jest z temperaturą.
