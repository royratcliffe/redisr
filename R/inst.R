#' Reads All Package-Installed Lua Scripts
#' @param ... Script base-name filters; reads \emph{all} scripts if no filters
#' @param package Name of installed package
#' @return Named list of character vectors after reading the package-installed
#'   Lua scripts. The names exclude the package path and the \code{lua}
#'   file-name extension.
#' @export
read.inst_lua <- function(..., package = "redisr") {
  inst.lua <- system.file("lua", package = package)
  files <- list.files(inst.lua, "\\.lua$", full.names = TRUE)
  names(files) <- basename(tools::file_path_sans_ext(files))
  dots <- c(...)
  if (!is.null(dots)) files <- files[names(files) %in% dots]
  lapply(files, function(x) paste(readLines(x), collapse = "\n"))
}

#' Loads Installed Lua Scripts for Evaluation
#' @inheritDotParams read.inst_lua
#' @export
#' @examples
#' \dontrun{
#' library(magrittr)
#' lua <- inst.lua()
#' lua$cmsgpack.pack_fenv(NULL, "a = 1") %>% strip.raw()
#' #> [1] 81 a1 61 01
#' lua$cmsgpack.pack_fenv(NULL, "hello = 123.456") %>%
#'   strip.raw() %>%
#'   RcppMsgPack::msgpack_unpack(simplify = TRUE)
#' #>   hello
#' #> 123.456
#' lua$serialise(c("x", "\t", "\t"), "a=1") %>% cat()
#' #> x = {
#' #>   a = 1
#' #> }
#' }
inst.lua <- function(...) {
  eval_sha(read.inst_lua(...))
}
