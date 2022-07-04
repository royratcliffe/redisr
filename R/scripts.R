#' Redis High-Level Interface Lua Scripts
#' @param x Redis interface
#' @param ... Extra parameters
#' @export
scripts <- function(x, ...) {
  UseMethod("scripts", x)
}
