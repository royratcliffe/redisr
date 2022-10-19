#' Character to Redis Stream Identifier
#' @param x Character vector of length 1.
#' @return Redis stream identifier, the same character vector of length 1 but
#'   with class \code{redis_stream_id}.
#' @export
as.redis_stream_id.character <- function(x, ...) {
  structure(x, class = "redis_stream_id")
}

#' Redis Stream Identifier to Time Stamp and Sequence Number
#' @description Splits the stream identifier by its dash delimiter.
#' @param x Redis stream identifier.
#' @return Vector of two character scalars: the Redis time stamp in
#'   milliseconds, the zero-based sequence number.
#' @export
as.character.redis_stream_id <- function(x, ...) strsplit(x, "-")[[1L]]

#' Redis Stream Identifier to POSIX Calendar Time
#' @param x Redis stream identifier.
#' @return POSIX calendar time.
#' @export
as.POSIXct.redis_stream_id <- function(x, ...) {
  as.POSIXct(as.numeric(as.numeric(as.character(x)[1L]) / 1e3),
             origin = "1970-01-01", ...)
}
