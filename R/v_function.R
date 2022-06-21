V_FUNC <-
"
{{#r_module}}
import r
{{/r_module}}

[rv_export]
{{{code}}}
"

#' Create a R wrapper from a v function.
#'
#' `v_function` transpiles the supplied `v` code to `C`, compiles it,
#' and returns a R function that calls the compiled code.
#' `Rcpp::cppFunction`, but for `v`.
#'
#' Note: R specific classes in `v` can be found in the `r` module.
#'
#' @examples
#' \dontrun{
#' # create a compiled function with v code
#' f <- v_function("fn add_one(i int) int {
#'    return i + 1
#' }")
#'
#' # and use it in R
#' add_one(2)
#' }
#' @param code `character` v code that defines the v function.
#' @param verbose if `TRUE` the compilation parameters will be shown.
#' @return R function that will call the compiled code
#' @export
v_function <- function(code, verbose=FALSE){
  dir_name <- tempfile()
  dir.create(dir_name, recursive = TRUE)

  fn_file_v <- tempfile(tmpdir = dir_name, fileext = ".v")
  fn_file_c <- tempfile(tmpdir = dir_name, fileext = ".c")

  r_module <- any(grepl("\\br\\.", code))

  rv_export.R <- file.path(dir_name, "rv_export.R")

  v_code <- whisker::whisker.render( V_FUNC
                                   , list( code = code, r_module = r_module)
                                   )
  writeLines(v_code, fn_file_v)
  writeLines(v_code)
  # TODO add checking code

  fns <- scan_v_file(fn_file_v)
  generate_rv_export_v(fns, file.path(dir_name, "rv_export.v"), pkg="rvee")
  generate_rv_export_R(fns, rv_export.R, pkg="rvee")
  generate_makevars(file.path(dir_name, "Makevars"), suppress_warnings=TRUE)
  generate_init_c(fns, file.path(dir_name, "init.c"), pkg="rvee")

  # supressing warning!
  run_v_to_c( dir_name
            , outdir=dir_name
            , pkg = "rvee"
            , prod = FALSE
            , compile=TRUE
            , verbose = verbose
            )
  shlib <- file.path(dir_name, "rvee.so")
  dyn.load(shlib)
  rcode <- readLines(rv_export.R)
  rcode <- sub("\\brvee_", "", rcode)
  writeLines(rcode, rv_export.R)
  source(rv_export.R)
}
