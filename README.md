
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `rvee`

## Recreational V programming for R / WIP

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/rvee)](https://CRAN.R-project.org/package=rvee)
[![R-CMD-check](https://github.com/edwindj/rvee/workflows/R-CMD-check/badge.svg)](https://github.com/edwindj/rvee/actions)
<!-- badges: end -->

**Early work, expect errors and crashes! (not ready for production)**

Create R extension packages with the [V programming
language](https://vlang.io). V is a simple, safe and fast programming
language with the speed of C.

R has good interfaces for many programming languages such as
[C](https://cran.r-project.org/doc/manuals/r-release/R-exts.html#System-and-foreign-language-interfaces)
,
[fortran](https://cran.r-project.org/doc/manuals/r-release/R-exts.html#System-and-foreign-language-interfaces)
, cpp (e.g. [Rcpp](http://www.rcpp.org/)) , python
(e.g. [reticulate](https://rstudio.github.io/reticulate/)) and rust
(e.g. [r-rust](https://github.com/r-rust)). R Package `rvee` intends to
provide an easy toolkist for creating R package with the `v` programming
language.

## Status

Translation to `C` and compilation (works…)

Interfacing:

-   [x] Generating all interfacing code from `v` file with
    `rvee::rv_export_c()`
-   [x] wraps simple input and return types: `f64`, `int`, `bool`,
    `string`
-   [x] wraps `numeric`, `logical`, `integer`, `character`, `factor` and
    `list` input and return types.
-   [x] compiling and working :-)
-   [ ] wraps `data.frame` input and return types.
-   [ ] wraps array input and return types: `[]f64`, `[]int`, `[]bool`,
    `[]string`
-   [x] CRAN checks

r module (in v):

-   [x] `Numeric`, direct access as a `[]f64`
-   [x] `Integer`, direct access as a `[]int`
-   [x] `Character`, indirect access as a `[]string`. string values of R
    are reused, but newly created string (not managed by R) are copied.
-   [x] `Logical`, indirect access as a `[]bool`. automatically converts
    between `[]bool` and `logical`.
-   [x] `Factor`
-   [x] `List`
-   [x] `DataFrame`
-   [ ] `Environment`
-   [ ] `Function`

## Installation

The **unstable** development version from [GitHub](https://github.com/)
with:

``` r
# install.packages("devtools")
devtools::install_github("edwindj/rvee")
```

## Overview

Possible routes for creating an R extension with `v` code are:

1.  Transpiling `V` code to `C` code and use it as a normal `C`
    extension.
2.  Using the `v` compiler to build a shared library linked to the R
    shared library.

Both options have their benefits and draw backs:

1.  Allows for easy distribution and installation, but requires tweaking
    the compilation flags to pass CRAN checks etc. and
    removing/stripping code that is not needed by R.

2.  Allows for an optimized shared library, but requires `v` to be
    installed by the installer (e.g. CRAN).

## Example

Currently the transpiling to C is in the make and kind-of works.

Put your `v` files in the “<pkg>/src” directory and decorate each
function to be exported with the `[rv_export]` attribute (see example
below).

After that

`rvee::rv_export_c` generates the necessary interfacing code:

-   “./R/rv_export.R”: R functions calling the v functions declared in
    “./src/rv_export.v”
-   “./src/rv_export.v”: v wrapper functions translating input and
    output to the original v functions.
-   “./src/init.c”: registration code for the shared library

And `devtools::load_all` (or `R CMD SHLIB`) should work.

Most work to be done is on the `v` module providing a easy interop
between v and R.

-   `numeric` and `integer` vectors are working
-   working on `character` vectors

Suppose we have the following file “<pkg>/src/example.v”

``` r
import r {Numeric}

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
fn my_numeric(mut x Numeric) Numeric{
  //This changes the values in place!
  for mut val in x.data {
    val += 1.
  }
  return x
}
```

With:

``` r
rvee::rv_export_c("<pkg>", prefix="my_pkg") # <pkg> is root dir of the source of your package...
```

The interfacing code is generated:

`"<pkg>/src/rv_export.v"`:

``` v
/* Automatically generated with R package: `rvee`
*
*/
import r

[manualfree]
fn my_pkg_scalar_numeric(x C.SEXP) C.SEXP {
  defer {r.protected.flush()} // clear any protected r objects

  // wrap input x
  i_x_v := r.as_f64(x)
  res := scalar_numeric(i_x_v)

  //wrap output
  return r.from_f64(res)

}

[manualfree]
fn my_pkg_scalar_integer(x C.SEXP) C.SEXP {
  defer {r.protected.flush()} // clear any protected r objects

  // wrap input x
  i_x_v := r.as_int(x)
  res := scalar_integer(i_x_v)

  //wrap output
  return r.from_int(res)

}

[manualfree]
fn my_pkg_negate(x C.SEXP) C.SEXP {
  defer {r.protected.flush()} // clear any protected r objects

  // wrap input x
  i_x_v := r.as_bool(x)
  res := negate(i_x_v)

  //wrap output
  return r.from_bool(res)

}

[manualfree]
fn my_pkg_my_numeric(x C.SEXP) C.SEXP {
  defer {r.protected.flush()} // clear any protected r objects

  // wrap input x
  mut i_x_v := r.as_numeric(x)
  res := my_numeric(mut i_x_v)

  //wrap output
  return r.from_numeric(res)

}
```

and

`"<pkg>/R/rv_export.R"`:

``` r
## Automatically generated with R package: `rvee`
#
#' @useDynLib my_pkg, .registration=TRUE
NULL

#' my_pkg_scalar_numeric
#'
#' my_pkg_scalar_numeric calls the v function 'scalar_numeric'
#' ('example/example.v:4').
#' @param x numeric
#' @return numeric
#' @keywords internal
my_pkg_scalar_numeric <- function(x){
  x <- as.numeric(x)
  .Call('_my_pkg_scalar_numeric', x)
}

#' my_pkg_scalar_integer
#'
#' my_pkg_scalar_integer calls the v function 'scalar_integer'
#' ('example/example.v:9').
#' @param x integer
#' @return integer
#' @keywords internal
my_pkg_scalar_integer <- function(x){
  x <- as.integer(x)
  .Call('_my_pkg_scalar_integer', x)
}

#' my_pkg_negate
#'
#' my_pkg_negate calls the v function 'negate'
#' ('example/example.v:15').
#' @param x logical
#' @return logical
#' @keywords internal
my_pkg_negate <- function(x){
  x <- as.logical(x)
  .Call('_my_pkg_negate', x)
}

#' my_pkg_my_numeric
#'
#' my_pkg_my_numeric calls the v function 'my_numeric'
#' ('example/example.v:20').
#' @param x numeric
#' @return numeric
#' @keywords internal
my_pkg_my_numeric <- function(x){
  x <- as.numeric(x)
  .Call('_my_pkg_my_numeric', x)
}
```

And create the shared library with a call to devtools

``` r
devtools::load_all("<pkg>")
```
