
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `rvee`

## Recreational V programming for R / WIP

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/rvee)](https://CRAN.R-project.org/package=rvee)
<!-- badges: end -->

**Very early work, expect errors and crashes! (not ready any use)**

Create R extension packages with the [V programming
language](https://vlang.io). V is a simple, safe and fast programming
language with the speed of C.

R has many good interfaces with programming languages C, fortran, cpp
(Rcpp), python (reticulate), rust ().

## Installation

The **unstable** development version from [GitHub](https://github.com/)
with:

``` r
# install.packages("devtools")
devtools::install_github("edwindj/rvee")
```

## Overview

There are the following possible routes for creating an R extension with
`v` code:

1.  Transpiling `V` code to `C` code and use it as a normal C extension.
2.  Using the `v` compiler to build a shared library linked to the R
    shared library

Both options have their benefits and draw backs:

1.  Allows for easy distribution and installation, but requires tweaking
    the compilation flags to pass CRAN checks etc. and
    removing/stripping code that is not needed by R.

2.  Allows for a optimized shared library, but required `v` to be
    installed by the installer (e.g. CRAN).

## Status

Currently the transpiling to C is in the make and kind-of works.

Put your `v` files in the “<pkg>/src” directory and decorate each
function to be exported with the `[rv_export]` attribute (see example
below).

After that

`rvee::rv_export_c` generates the necessary interfacing code:

-   “./R/rv\_export.R”: R functions interfacing the shared library
-   “./src/rv\_export.v”: v wrapper functions translating input and
    output
-   “./src/init.c”: registration code for the shared library

And `devtools::load_all` (or `R CMD SHLIB`) should work.

Most work to be done is on the `v` module providing a easy interop
between v and R.

-   `numeric` and `integer` vectors are working
-   working on `character` vectors

## Example

Suppose we have the following file “<pkg>/src/example.v”

``` r
import r {NumericVector}

[rv_export]
pub fn scalar_numeric(x f64) f64{
   return x + 1.
}

[rv_export]
pub fn scalar_integer(x int) int{
   return x + 1
}


[rv_export]
fn negate(x bool) bool {
  return !x
}

[rv_export]
fn my_numeric(x NumericVector) NumericVector{
  //This changes the values in place!
  mut values := x.f64s()
  for mut val in values {
    val += 1.
  }
  return x
}
```

With:

``` r
rvee::rv_export_c("<pkg>") # <pkg> is root dir of the source of your package...
```

The interfacing code is generated:

`"<pkg>/src/rv_export.v"`:

``` v
/* Automatically generated with R package: `rvee`
*
*/
import r

fn rvee_scalar_numeric(x C.SEXP) C.SEXP {

  // wrap input x
  i_x_v := r.as_f64(x)
  o_res_v := scalar_numeric(i_x_v)
  //wrap output
  res := r.from_f64(o_res_v)
  r.protected.flush() // clear any protected r objects
  return res

}

fn rvee_scalar_integer(x C.SEXP) C.SEXP {

  // wrap input x
  i_x_v := r.as_int(x)
  o_res_v := scalar_integer(i_x_v)
  //wrap output
  res := r.from_int(o_res_v)
  r.protected.flush() // clear any protected r objects
  return res

}

fn rvee_negate(x C.SEXP) C.SEXP {

  // wrap input x
  i_x_v := r.as_bool(x)
  o_res_v := negate(i_x_v)
  //wrap output
  res := r.from_bool(o_res_v)
  r.protected.flush() // clear any protected r objects
  return res

}

fn rvee_my_numeric(x C.SEXP) C.SEXP {

  // wrap input x
  i_x_v := r.as_numeric_vector(x)
  o_res_v := my_numeric(i_x_v)
  //wrap output
  res := r.from_numeric_vector(o_res_v)
  r.protected.flush() // clear any protected r objects
  return res

}
```

and

`"<pkg>/R/rv_export.R"`:

``` r
## Automatically generated with R package: `rvee`
#
#' @useDynLib rvee, .registration=TRUE
NULL

#' rvee_scalar_numeric
#'
#' rvee_scalar_numeric calls the v function 'scalar_numeric'.
#' @param x numeric
#' @return numeric
#' @keywords internal
rvee_scalar_numeric <- function(x){
    x <- as.numeric(x)
  .Call('_rvee_scalar_numeric', x)
}

#' rvee_scalar_integer
#'
#' rvee_scalar_integer calls the v function 'scalar_integer'.
#' @param x integer
#' @return integer
#' @keywords internal
rvee_scalar_integer <- function(x){
    x <- as.integer(x)
  .Call('_rvee_scalar_integer', x)
}

#' rvee_negate
#'
#' rvee_negate calls the v function 'negate'.
#' @param x logical
#' @return logical
#' @keywords internal
rvee_negate <- function(x){
    x <- as.logical(x)
  .Call('_rvee_negate', x)
}

#' rvee_my_numeric
#'
#' rvee_my_numeric calls the v function 'my_numeric'.
#' @param x numeric
#' @return numeric
#' @keywords internal
rvee_my_numeric <- function(x){
    x <- as.numeric(x)
  .Call('_rvee_my_numeric', x)
}
```
