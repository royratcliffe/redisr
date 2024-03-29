% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/raw.R
\name{strip_if_raw}
\alias{strip_if_raw}
\title{Strip Prefix If Raw}
\usage{
strip_if_raw(x, ...)
}
\arguments{
\item{x}{Raw vector to strip else anything else}

\item{...}{
  Arguments passed on to \code{\link[=strip.raw]{strip.raw}}
  \describe{
    \item{\code{pre}}{Prefix to strip off if present, a raw vector}
  }}
}
\value{
Stripped raw vector else unchanged
}
\description{
Strips if and only if raw.
}
\examples{
strip_if_raw(c(charToRaw("X\n"), as.raw(0L)))
#> raw(0)
}
