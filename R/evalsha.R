#' Load and Evaluate Scripts by SHA
#'
#' @details Redux decodes a Redis reply as a raw vector if the first two
#'   characters match X or B followed by new-line. Raw vector replies then
#'   answer if the remaining bytes contain at least one null, a zero byte. See
#'   the implementation of the C function \code{is_raw_string} in the
#'   \code{redux} package for more details.
#'
#' @param named_scripts Named list of Lua scripts
#' @param redis High-level Redis interface
#' @inheritDotParams scripts
#' @return SHA evaluate function accepting script name, key vector and argument
#'   vector in that order; the name becomes the Lua script SHA by look-up
#' @export
#' @examples
#' \dontrun{
#' evalsha <- script_load.evalsha(list(version = "return _VERSION"))
#' evalsha("version")
#' #> [1] "Lua 5.1"
#' script_load.evalsha(list(lua = 'return "X\\n\\0"..ARGV[1]'))("lua",, "hello")
#' #> [1] 58 0a 00 68 65 6c 6c 6f
#' }
script_load.evalsha <- function(named_scripts, redis = hi(), ...) {
  scripts(redis, ..., scripts = named_scripts)
}

#' Load Scripts by SHA for Evaluation
#' @param named_scripts Named list of Lua scripts
#' @inheritDotParams script_load.evalsha
#' @return List of named wrapper functions, one per Lua script
#' @export
eval_sha <- function(named_scripts, ...) {
  sha <- script_load.evalsha(named_scripts, ...)
  eval_sha <- lapply(names(named_scripts), function(x)
    function(keys, args) sha(x, keys, args))
  names(eval_sha) <- names(named_scripts)
  eval_sha
}
