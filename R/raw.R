#' Strip Raw Prefix
#' @description Useful for handling raw reply vectors.
#' @param x Raw vector to strip
#' @param pre Prefix to strip off if present, a raw vector
#' @return Stripped raw vector
#' @export
#' @examples
#' strip.raw(c(charToRaw("X\n"), as.raw(0), charToRaw("abc")))
strip.raw <- function(x, pre = c(charToRaw("X\n"), as.raw(0L))) {
  len <- length(pre)
  if (identical(x[1:len], pre)) x[0:-len] else x
}

#' Strip Prefix If Raw
#' @description Strips if and only if raw.
#' @param x Raw vector to strip else anything else
#' @inheritDotParams strip.raw
#' @return Stripped raw vector else unchanged
#' @export
#' @examples
#' strip_if_raw(c(charToRaw("X\n"), as.raw(0L)))
#' #> raw(0)
strip_if_raw <- function(x, ...) {
  if (is.raw(x)) strip.raw(x, ...) else x
}
