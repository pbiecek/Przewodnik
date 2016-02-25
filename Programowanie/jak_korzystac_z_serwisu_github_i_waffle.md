# Jak korzystać z serwisu GitHub i Waffle?

Jeżeli pracujesz nad bardziej złożonym projektem lub pracujesz nad projektem w zespole to z pewnością potrzebujesz sprawdzić jakie zmiany, przez kogo i kiedy zostały wprowadzone do plików projektowych. Świetnym narzędziem do tego jest system git.

Git to rozproszony system kontroli wersji stworzony przez Linusa Torvaldsa (Wikipedia, 2016). Jest otwartym oprogramowaniem dostępnym na licencji GNU GPL 2. Pozwala na zarządzanie i śledzenie zmian w plikach. Zazwyczaj są to pliki z kodami, np. w języku R lub innym języku programowania, ale mogą być to też inne pliki binarne.

Git jest systemem, który każdy może pobrać i zainstalować na swoim serwerze. Jednak na potrzeby mniejszych projektów wygodnie jest skorzystać z serwisu GitHub http://github.com/, który umożliwia korzystanie z systemu git bez konieczności samodzielnej instalacji.

Dane i kody na serwisie GitHub można przechowywać w publicznych repozytoriach (każdy internauta widzi ich zawartość), co jest bezpłatne, lub w prywatnych repozytoriach (możemy określać kto co może widzieć), lecz ta usługa jest już płatna. Poniżej opiszemy jak korzystać z bezpłatnych repozytoriów. 

## Struktura

Struktura GitHuba jest następująca.

Na najwyższym poziomie organizacji znajdują się konta. Mogą być to konta osób (np. moje konto http://github.com/pbiecek) lub organizacji (np. konto grupy MI^2 http://github.com/mi2-warsaw).

W ramach kont można tworzyć repozytoria. Repozytoria mogą być publiczne (widoczne dla wszystkich) lub prywatne (widoczne dla określonych kont). 

W ramach repozytoriów można składować pliki i katalogi. Obecnie GitHub ma ograniczenie co do wielkości plików. Pojedynczy plik nie może przekraczać 100MB wielkości.

## Praca grupowa

Jedno repozytorium jest przypisane do jednego użytkownika. Ten użytkownik ma pełnie praw do danego repozytorium, może je usunąć, zmienić, dodać uprawnienia dla innych użytkowników. 

Istnieją dwa główne rozwiązania, pozwalające na pracę grupową na repozytorium. 

1. Można do repozytorium przypisać współpracowników (opcje `Settings/Collaborators`). Współpracownicy będą mogli dowolnie dodawać, zmieniać, usuwać pliki z repozytorium.

2. Można zrobić kopię repozytorium, tzw. `fork`a. Kopia repozytorium jest w rzeczywistości nowym repozytorium, przypisanym do użytkownika, który tą kopię zbudował. Kopia jest inicjowana plikami z oryginału, ale później może być niezależnie rozwijana. Pomiędzy kopią a oryginałem można przesyłać pliki (synchronizować pliki). Służy do tego opcja `Pull Request` (patrz niżej).

W pierwszym rozwiązaniu, każdy współpracownik może zmieniać samodzielnie pliki. W drugim przypadku właściciel kopii może zmieniać pliki w swoim repozytorium, gdy chce te zmiany wysłać do oryginału musi stworzyć zlecenie przesłania zmian (`Pull Request`). To zlecenie musi zostać zaakceptowane przez właściciela oryginału.









