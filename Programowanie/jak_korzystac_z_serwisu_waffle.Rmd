# Jak korzystać z serwisu Waffle?

Efektywna praca zespołowa jest najczęściej oparta o system dobrze zdefiniowanych zadań do wykonania.  Jest wiele systemów do zarządzania zadaniami w pracy zespołowej. Waffle jest jednym z nich. To co go wyróżnia to duża prostota i silna integracja z serwisem github.

Serwis Waffle jest dostępny na stronie http://waffle.io.
Umożliwia proste i wizualne zarządzanie zadaniami (ang. `issues`) przypisanymi do repozytorium GitHuba.

Zadania mają numery (odwołuję się do nich pisząc `#numer_zadania`), tytuły, treści, tagi oraz osoby odpowiedzialne za zadanie. Do zadania jest też przypisana lista komentarzy.

System waffle korzysta z rozwiązań zwinnych metodyk zarządzania projektami. Każde zadanie może znajdować się w jednym z kilku stanów. Domyślnie są to:

* `Backlog`, luźne pomysły co warto kiedyś zrobić. Tak zwana długa lista TODO.

* `Ready`, zadania gotowe do rozpoczęcia nad nimi pracy. Tak zwana krótka lista TODO.

* `In Progress`, zadania aktualnie wykonywane.

* `Done`, zadania zakończone.

Modelowy przepływa zadania zaczyna się w stanie `Backlog`. Uznajemy, że chcemy je realizować, przesuwamy je do `Ready`. Ktoś zaczyna pracę nad nim, przesuwa zadanie do stanu `In progress`. Kończymy pracę nad zadaniem, przesuwamy je do stanu `Done`.

Może się oczywiście tak zdarzyć, że w zadaniu jest błąd i trzeba je poprawić. Wtedy z `Done` zadanie może trafić do `In progress`. Lub też może się wydarzyć, że zadanie musi poczekać na zakończenie czegoś innego, wtedy wraca do stanu `Ready`.

Dostęp do tablicy z zadaniami ma cały zespół. Dzięki temu łatwiej śledzić postępu prac i aktualnie rozwijane funkcjonalności.

## Jak dobrze definiować zadania?

Jest jakiś urok w kolorowej tablicy wypełnionej zadaniami. Jednak to nie liczba zadań determinuje, czy projekt się dobrze rozwija czy nie. Kluczowe jest to, w jaki sposób zadania są definiowane i realizowane. Poniżej znajduje się lista  dobrych praktyk. 

* Zadanie powinno być tak opisane by współpracownicy po przeczytaniu opisu wiedzieli o co chodzi. Również by 'przyszłe ja', które przeczyta treść tego zadania za miesiąc lub rok, wiedziało o co w zadaniu chodziło.

* Zadanie powinno być konkretne, tak by dało się jednoznacznie określić co trzeba zrobić by je zrealizować i by było wiadomo czy zadanie zostało zrealizowane. Złe zadania są mało konkretne, np. `Poprawić dokumentację`. Dokumentacje zawsze można poprawić, więc takiego zadania nigdy nie można zamknąć. Lepsza treść to `Dla każdej funkcji przygotować przynajmniej dwa akapity opisu`. Takie zadanie można przynajmniej zweryfikować, czy zostało zrealizowane.

* Zadanie powinno mieć przypisanego opiekuna. Jedną osobę, która troszczy się o to by zostało zrealizowane.

* Zadania powinny być okresowo przeglądane i jeżeli zajdzie taka potrzeba usuwane, zamykane. Nie ma nic gorszego niż stos kilkudziesięciu zadań, które nigdy nie zostaną zrealizowane, ale zabierają nam czas na ich przeglądanie jak również zużywają nasze zasoby na zastanawianie się czy je realizować czy nie. 

* Zadania powinny być względnie małe, możliwe do realizacji w jeden dzień, maksymalnie tydzień. Zadanie, którego realizacja miałaby trwać dłużej powinni być podzielone na mniejsze zadania. Inaczej trudniej nam będzie śledzić postęp prac.

