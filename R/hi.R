#' Redis High-Level Interface
#' @inheritDotParams redux::hiredis
#' @return Redis interface facade, R6 \code{redis_api} instance
#' @seealso \href{https://github.com/redis/hiredis}{Minimalistic C client
#'   library for the Redis database}
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
