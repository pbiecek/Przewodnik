# Jak korzystać z serwisu GitHub i Waffle?

Jeżeli pracujesz nad bardziej złożonym projektem lub pracujesz nad projektem w zespole to z pewnością potrzebujesz sprawdzić jakie zmiany, przez kogo i kiedy zostały wprowadzone do plików projektowych. Świetnym narzędziem do tego jest system git.

Git to rozproszony system kontroli wersji stworzony przez Linusa Torvaldsa (Wikipedia, 2016). Jest otwartym oprogramowaniem dostępnym na licencji GNU GPL 2. Pozwala na zarządzanie i śledzenie zmian w plikach. Zazwyczaj są to pliki z kodami, np. w języku R lub innym języku programowania, ale mogą być to też inne pliki binarne.

Git jest systemem, który każdy może pobrać i zainstalować na swoim serwerze. Jednak na potrzeby mniejszych projektów wygodnie jest skorzystać z serwisu GitHub http://github.com/, który umożliwia korzystanie z systemu git bez konieczności samodzielnej instalacji.

Dane i kody na serwisie GitHub można przechowywać w publicznych repozytoriach (każdy internauta widzi ich zawartość), co jest bezpłatne, lub w prywatnych repozytoriach (możemy określać kto co może widzieć), lecz ta usługa jest już płatna. Poniżej opiszemy jak korzystać z bezpłatnych repozytoriów. 

## Struktura

Struktura GitHuba jest następująca.

Na najwyższym poziomie organizacji znajdują się konta. Mogą być to konta osób (np. moje konto http://github.com/pbiecek) lub organizacji (np. konto grupy MI^2 http://github.com/mi2-warsaw).

W ramach kont można tworzyć repozytoria. Repozytoria mogą być publiczne (`public`, widoczne dla wszystkich) lub prywatne (`private`, widoczne dla określonych kont). 

W ramach repozytoriów można składować pliki i katalogi. Obecnie GitHub ma ograniczenie co do wielkości plików. Pojedynczy plik nie może przekraczać 100MB wielkości.

## Praca z repozytorium

Typowa praca z repozytorium sprowadza się do wykonywania 5 operacji. Poniżej omówimy je jedna po drugiej. Krótkie wprowadzenie do tych operacji można też znaleźć pod adresem https://guides.github.com/activities/hello-world/.

### `create` - stwórz nowe repozytorium

Po zalogowaniu się na serwerze GitHub, w zakładce `Repositories` mamy opcję stwórz repozytorium `Create a new repository`. 

Repozytorium domyślnie będzie przypisane do zalogowanego użytkownika.
Repozytorium musi mieć nazwę.
Repozytorium może mieć opis.

Z czasem będziesz miał coraz więcej repozytoriów. Warto zadbać, by ich nazwy coś znaczyły. 

### `branch` - wersje repozytorium

W ramach jednego repozytorium można przechowywać różne wersje plików. Te wersje przypisane są do tzw. gałęzi (`branch`).

Główna gałąź repozytorium nazywa sie `master`, ale można tworzyć własne. Jest to dobre rozwiązanie, jeżeli chcemy stworzyć eksperymentalne funkcjonalności ale nie jesteśmy przekonani czy trafią one do ostatecznej wersji repozytorium.
Zazwyczaj tworzy się w takim przypadku eksperymentalną gałąź. Dodaje do niej pliki. Jeżeli uznamy, że funkcjonalności powinny trafić do głównej gałęzi to przesyła się pliki z eksperymentalnej do głównej gałęzi.

### `commit` - wprowadzanie zmian

Gdy pracujemy z kodem to pliki zmieniają się w sposób prawie, że ciągły. Wpisujemy tekst literka po literce. Ale tak szczegółowe pamiętanie zmian byłoby bardzo niewygodne, dlatego w systemie git pracuje się z migawkami repozytorium.

Wprowadzamy zmiany do plików, a następnie gdy chcemy te zmiany wprowadzić do repozytorium tworzymy tzw. `commit`, polecenie zmiany plików (zmianą jest i zmiana treści i dodanie/usunięcie pliku).

Każdy `commit` ma swoją unikalną 32-znakową nazwę. Dzięki niej możemy odwoływać się do stanu repozytorium po wprowadzeniu określonej zmiany. Innymi słowy repozytorium to sekwencja migawek. Możemy się odwoływać do aktualnego lub przeszłego stanu repozytorium.

Przykładowo, w repozytorium Eseje (https://github.com/pbiecek/Eseje) jest plik GamatykaGrafiki.Rmd.

Został on dodany w grudniu 2015 roku `commit`em o nazwie `a971423315f6a5a940411128feb8f23697fe1a29`. Treść tego pliku jest tutaj https://github.com/pbiecek/Eseje/blob/a971423315f6a5a940411128feb8f23697fe1a29/GamatykaGrafiki.Rmd.

W kolejnych migawkach do tego pliku coś dodawałem lub usuwałem. Obecna postać tego pliku jest dostępna pod adresem https://github.com/pbiecek/Eseje/blob/master/GamatykaGrafiki.Rmd

Można jednak prześledzić historię zmian i odwoływać się do stanu repozytorium z określonej migawki (migawka jest charakteryzowana 32 znakowa nazwą).

### `pull` - zlecenie zmiany pliku/plików

Poleceniem `commit` wysyłamy do repozytorium nową wersję pliku. 
W określonych sytuacjach chcemy przesłać zmiany w plikach z jednej gałęzi do drugiej lub z jednego repozytorium do innego. Takie przesłanie plików wykonuje się poleceniem `pull`.

Jeden przykład użycia może dotyczyć eksperymentalnej gałęzi repozytorium. Pracowaliśmy w niej nad nowymi funkcjami. Widzimy, że działają, chcemy je przesłać do głównej gałęzi `master`. Wiec tworzymy `pull`, który prześle pliki z jednej gałęzi do drugiej.

Inny przykład dotyczy pracy w kopii repozytorium. Przypuśćmy, że zrobiłeś kopię mojego repozytorium https://github.com/pbiecek/Eseje. Do tej kopii dodałeś kilka nowych plików, Twoim zdaniem interesujących materiałów. Możesz te zmiany wysłać ze swojego repozytorium do mojego.

### `merge` - scalanie zmian

Polecenie `pull` wysyła pliki z jednej gałęzi/repozytorium do drugiej. 
Polecenie `merge` wprowadza te zmiany do docelowej gałęzi/repozytorium.

Logika operacji `pull` i `merge` jest następująca. Przypuśćmy, że chcesz wprowadzić zmiany do mojego repozytorium https://github.com/pbiecek/Eseje. 
Tworzysz kopię repozytorium. W Twojej kopii możesz wprowadzać dowolne zmiany.
Następnie zmiany wysyłasz do mojego repozytorium poleceniem `pull`. 

Otrzymuję informację, że pojawia się zlecenie zmiany. Mogę przejrzeć co to za zmiany i jeżeli uznam, że powinny znaleźć się w moim repozytorium to te zmiany scalam z aktualnym stanem repozytorium. 

## Zdalne / lokalne. O co chodzi?

Repozytorium znajduje się na serwerze GitHub. Korzystając ze strony www GitHuba można dodawać pojedyncze pliki lub modyfikować istniejące, ale nie jest to najwygodniejsze rozwiązanie. Zazwyczaj praca z repozytorium przebiega za pośrednictwem lokalnych kopii. 

Do zarządzania lokalnymi kopiami można wykorzystać linię poleceń i program `git`, można wykorzystać program `GitHub` dostępny dla Windowsa i OSX, ale najwygodniej jest użyć programu SourceTree https://www.sourcetreeapp.com/.

Praca z repozytorium wygląda następująco.

1. Tworzymy na lokalnym dysku kopię repozytorium GitHub (polecenie `clone`).

2. Zmieniamy pliki na lokalnym dysku. Są to zwykłe pliki, do zmiany można wykorzystać dowolny program.

3. Wysyłamy zmiany z lokalnej kopii do zdalnego GitHubowego repozytorium (polecenie `commit`).

4. Pobieramy zmiany z GitHubowego repozytorium do lokalnej kopii (polecenie `pull`). Te zmiany mógł wprowadzić nasz współpracownik, lub mogliśmy zrobić je sami.



## Praca grupowa

Jedno repozytorium jest przypisane do jednego użytkownika. Ten użytkownik ma pełnie praw do danego repozytorium, może je usunąć, zmienić, dodać uprawnienia dla innych użytkowników. 

Istnieją dwa główne rozwiązania, pozwalające na pracę grupową na repozytorium. 

1. Można do repozytorium przypisać współpracowników (opcje `Settings/Collaborators`). Współpracownicy będą mogli dowolnie dodawać, zmieniać, usuwać pliki z repozytorium.

2. Można zrobić kopię repozytorium, tzw. `fork`a. Kopia repozytorium jest w rzeczywistości nowym repozytorium, przypisanym do użytkownika, który tą kopię zbudował. Kopia jest inicjowana plikami z oryginału, ale później może być niezależnie rozwijana. Pomiędzy kopią a oryginałem można przesyłać pliki (synchronizować pliki). Służy do tego opcja `Pull Request` (patrz niżej).

W pierwszym rozwiązaniu, każdy współpracownik może zmieniać samodzielnie pliki. W drugim przypadku właściciel kopii może zmieniać pliki w swoim repozytorium. Ale gdy chce te zmiany wysłać do oryginału musi stworzyć zlecenie przesłania zmian (`Pull Request`). To zlecenie musi zostać zaakceptowane przez właściciela oryginału.

