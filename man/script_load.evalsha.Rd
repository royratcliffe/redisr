% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/evalsha.R
\name{script_load.evalsha}
\alias{script_load.evalsha}
\title{Load and Evaluate Scripts by SHA}
\usage{
script_load.evalsha(named_scripts, redis = hi(), ...)
}
\arguments{
\item{named_scripts}{Named list of Lua scripts}

\item{redis}{High-level Redis interface}

\item{...}{
  Arguments passed on to \code{\link[=scripts]{scripts}}
  \describe{
    \item{\code{x}}{Redis high-level interface}
  }}
}
\value{
SHA evaluate function accepting script name, key vector and argument
vector in that order; the name becomes the Lua script SHA by look-up
}
\description{
Load and Evaluate Scripts by SHA
}
\details{
Redux decodes a Redis reply as a raw vector if the first two
characters match X or B followed by new-line. Raw vector replies then
answer if the remaining bytes contain at least one null, a zero byte. See
the implementation of the C function \code{is_raw_string} in the
\code{redux} package for more details.
}
\examples{
\dontrun{
evalsha <- script_load.evalsha(list(version = "return _VERSION"))
evalsha("version")
#> [1] "Lua 5.1"
script_load.evalsha(list(lua = 'return "X\\\\n\\\\0"..ARGV[1]'))("lua",, "hello")
#> [1] 58 0a 00 68 65 6c 6c 6f
}
}
