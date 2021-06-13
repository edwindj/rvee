
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `rvee`

## Recreational V programming for R / WIP

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/rvee)](https://CRAN.R-project.org/package=rvee)
<!-- badges: end -->

**Early work, expect errors and crashes! (not ready for production)**

Create R extension packages with the [V programming
language](https://vlang.io). V is a simple, safe and fast programming
language with the speed of C.

R has many good interfaces with programming languages C, fortran, cpp
(Rcpp), python (reticulate), rust (), `rvee` provides this for the `v`
programming language.

## Status

Translation to `C` and compilation (works…)

Interfacing:

-   [x] Generating all interfacing code from `v` file with
    `rvee::rv_export_c()`
-   [x] wraps simple input and return types: `f64`, `int`, `bool`,
    `string`
-   [ ] wraps array input and return types: `[]f64`, `[]int`, `[]bool`,
    `[]string`
-   [x] wraps `numeric`, `logical`, `integer` and `character` input and
    return types.
-   [ ] wraps `factor`, `list`, `data.frame` input and return types.
-   [x] compiling and working :-)
-   [ ] CRAN checks (remove c compiler warnings)

r module (in v):

-   [x] `Numeric`, direct access as a `[]f64`
-   [x] `Integer`, direct access as a `[]int`
-   [x] `Character`, indirect access as a `[]string`. string values of R
    are reused, but newly created string (not managed by R) are copied.
-   [x] `Logical`, indirect access as a `[]bool`. automatically converts
    between `[]bool` and `logical`.
-   [ ] `Factor`
-   [ ] `List`
-   [ ] `DataFrame`
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

## Example

Currently the transpiling to C is in the make and kind-of works.

Put your `v` files in the “<pkg>/src” directory and decorate each
function to be exported with the `[rv_export]` attribute (see example
below).

After that

`rvee::rv_export_c` generates the necessary interfacing code:

-   “./R/rv\_export.R”: R functions calling the v functions declared in
    “./src/rv\_export.v”
-   “./src/rv\_export.v”: v wrapper functions translating input and
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
  for i, val in x.data {
    x.data[i] = val + 1.
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

fn my_pkg_scalar_numeric(x C.SEXP) C.SEXP {
  defer {r.protected.flush()} // clear any protected r objects

  // wrap input x
  i_x_v := r.as_f64(x)
  o_res_v := scalar_numeric(i_x_v)

  //wrap output
  return r.from_f64(o_res_v)

}

fn my_pkg_scalar_integer(x C.SEXP) C.SEXP {
  defer {r.protected.flush()} // clear any protected r objects

  // wrap input x
  i_x_v := r.as_int(x)
  o_res_v := scalar_integer(i_x_v)

  //wrap output
  return r.from_int(o_res_v)

}

fn my_pkg_negate(x C.SEXP) C.SEXP {
  defer {r.protected.flush()} // clear any protected r objects

  // wrap input x
  i_x_v := r.as_bool(x)
  o_res_v := negate(i_x_v)

  //wrap output
  return r.from_bool(o_res_v)

}

fn my_pkg_my_numeric(x C.SEXP) C.SEXP {
  defer {r.protected.flush()} // clear any protected r objects

  // wrap input x
  mut i_x_v := r.as_numeric(x)
  o_res_v := my_numeric(mut i_x_v)

  //wrap output
  return r.from_numeric(o_res_v)

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
