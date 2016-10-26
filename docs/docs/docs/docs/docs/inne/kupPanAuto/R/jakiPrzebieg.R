#' Średni przebieg aut wyprodukowanych w danym roku
#'
#' Funkcja jakiPrzebieg() wyznacza średni przebieg aut,
#' które jako data produkcji mają podany wskazany rok.
#'
#' @param rok Rok, dla którego liczona ma być średnia, domyślnie 2012.
#' @param auta Zbiór danych, na bazie którego liczona ma być średnia.
#'
#' @export

jakiPrzebieg <- function(rok = '2012', auta) {
  wybrane <- filter(auta, Rok.produkcji == rok)
  mean(wybrane$Przebieg.w.km, na.rm=TRUE)
}
