% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/v_function.R
\name{v_function}
\alias{v_function}
\title{Create a R wrapper from a v function.}
\usage{
v_function(code, verbose = FALSE)
}
\arguments{
\item{code}{\code{character} v code that defines the v function.}

\item{verbose}{if \code{TRUE} the compilation parameters will be shown.}
}
\value{
R function that will call the compiled code
}
\description{
\code{v_function} transpiles the supplied \code{v} code to \code{C}, compiles it,
and returns a R function that calls the compiled code.
\code{Rcpp::cppFunction}, but for \code{v}.
}
\details{
Note: R specific classes in \code{v} can be found in the \code{r} module.
}
\examples{
\dontrun{
# create a compiled function with v code
f <- v_function("fn add_one(i int) int {
   return i + 1
}")

# and use it in R
add_one(2)
}
}
