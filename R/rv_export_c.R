#' Generate rv_export files for .c
#'
#' Generates rv_export files from a `v` source file, that is located in the
#' `src` directory of a pkg.
#'
#' The following files are generated:
#'
#' - "./R/rv_export.R": R functions that wrap the v functions
#' - "./src/rv_export.v": v wrappers, that interface v with R.
#' - "./src/init.c" : registration code, needed for the shared library.
#' - "./src/Makevars" : settings that suppress compiler warnings.
#' - "./src/<pkg_name>.c" : generated c code from the `v` source code.
#'
#' @export
#' @param pkg `character` location of package.
#' @param prefix `character` optional prefix that is used in the wrapper generation
#' @return (invisibly) the list of parsed v functions.e
rv_export_c <- function(pkg=".", prefix=NULL){
  desc <- read.dcf(file.path(pkg, "DESCRIPTION"))

  if (is.character(prefix)){
    prefix <- prefix[1]
  } else {
    prefix <- as.character(desc[,1]) # pkgname
  }

  pkg_src <- file.path(pkg, "src")
  pkg_R <- file.path(pkg, "R")

  fns <- scan_v_dir(pkg_src)

  generate_rv_export_v(fns, file.path(pkg_src, "rv_export.v"), pkg = prefix)
  generate_init_c(fns, file.path(pkg_src, "init.c"), pkg = prefix)
  generate_makevars(file.path(pkg_src, "Makevars"))

  generate_rv_export_R(fns, file.path(pkg_R, "rv_export.R"), pkg = prefix)

  run_v_to_c(dir = file.path(pkg, "src"), pkg = prefix)

  invisible(fns)
}
