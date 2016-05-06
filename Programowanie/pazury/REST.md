# Jak tworzyć usługi SaaS oparte o RESTful API?

Zacznijmy od rozwinięcia kilku pojęć.

Model SaaS (ang. Software as a Service) budowy oprogramowania polega na udostępnianiu użytkownikom określonych usług/funkcjonalności za pośrednictwem sieci Internet. Użytkownik może korzystać z określonych funkcjonalności bez konieczności instalacji, aktualizacji oprogramowania.

API (ang. Application Programming Interface) opisuje sposób komunikacji elementów oprogramowania. Jeżeli mamy oprogramowanie składające się z części/komponentów/elementów, składowe muszą się komunikować, sposób komunikacji opisuje właśnie API. 

REST (ang. representational state transfer) to wzorzec architektury oprogramowania często stosowany w API. 

Systemy zgodne z wzorcem REST nazywane są RESTful. Często są one oparte o protokół HTTP (ang. Hypertext Transfer Protocol) wykorzystując metody tego protokołu, najczęściej GET i POST. Dwie charakterystyczne cechy tego rozwiązania to architektura klient-serwer (w komunikacji każdy element wie czy działa jako klient czy serwer, komunikując się korzysta z jednolitego interfaceu) i bezstanowość (do pewnego stopnia, serwer odpowiadając na zapytania klienta reaguje to bez pamiętania kontekstu dotychczasowej komunikacji).

Dlaczego mielibyśmy chcieć tworzyć takie RESTful API? Jest to najprostszy sposób by udostępnić określone funkcjonalności zbudowane w R dla innych elementów, bez względu na ich architekturę. 

Ok, a więc jak zbudować usługi SaaS oparte o RESTful API? W R najłatwiej to zrobić za pomocą pakietu `openCPU`.



