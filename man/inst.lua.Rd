% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/inst.R
\name{inst.lua}
\alias{inst.lua}
\title{Loads Installed Lua Scripts for Evaluation}
\usage{
inst.lua(...)
}
\arguments{
\item{...}{
  Arguments passed on to \code{\link[=read.inst_lua]{read.inst_lua}}
  \describe{
    \item{\code{package}}{Name of installed package}
  }}
}
\description{
Loads Installed Lua Scripts for Evaluation
}
\examples{
\dontrun{
library(magrittr)
lua <- inst.lua()
lua$cmsgpack.pack_fenv(NULL, "a = 1") \%>\% strip.raw()
#> [1] 81 a1 61 01
lua$cmsgpack.pack_fenv(NULL, "hello = 123.456") \%>\%
  strip.raw() \%>\%
  RcppMsgPack::msgpack_unpack(simplify = TRUE)
#>   hello
#> 123.456
lua$serialise(c("x", "\t", "\t"), "a=1") \%>\% cat()
#> x = {
#>   a = 1
#> }
}
}
