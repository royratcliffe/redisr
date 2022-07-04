#' Redis High-Level Interface
#' @inheritDotParams redux::hiredis
#' @return Redis interface facade, R6 \code{redis_api} instance
#' @export
#' @examples
#' \dontrun{
#' redis <- redisr::hi()
#' redis$PING()
#' #> [Redis: PONG]
#' }
hi <- function(...) {
  redux::hiredis(...)
}
