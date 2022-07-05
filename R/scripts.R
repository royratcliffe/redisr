#' Redis High-Level Interface to Lua Scripts
#' @description Loads a list of scripts by name and SHA ready for subsequent
#'   evaluation.
#' @param x Redis high-level interface
#' @param ... Extra parameters, including:
#'   * `scripts` for named Lua scripts to load
#' @export
scripts <- function(x, ...) {
  UseMethod("scripts", x)
}
