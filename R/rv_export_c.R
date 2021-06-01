#' Generate rv_export files for .c
#'
#' Generates rv_export files from a `v` source file, that is located in the
#' `src` directory of a pkg.
#'
#' The following files are generated:
#' - "./R/rv_export.R": R functions that wrap the v functions
#' - "./src/rv_export.v": v wrappers, that interface v with R.
#' - "./src/init.c" : registration code, needed for the shared library.
#' - "./src/<pkg_name>.c" : registration code, needed for the shared library.
#'
#' @export
#' @param pkg `character` location of package.
rv_export_c <- function(pkg="."){
  desc <- read.dcf(file.path(pkgdir, "DESCRIPTION"))
  pkg_name <- as.character(desc[,1]) # Title

  pkg_src <- file.path(pkg, "src")
  pkg_R <- file.path(pkg, "R")

  fns <- scan_v_dir(pkg_src)
  generate_rv_export_v(fns, file.path(pkg_src, "rv_export.v"), pkg = pkg_name)
  generate_init_c(fns, file.path(pkg_src, "init.c"), pkg = pkg_name)
  generate_rv_export_R(fns, file.path(pkg_R, "rv_export.R"), pkg = pkg_name)
  run_v_to_c(dir = file.path(pkg, "src"), pkg = pkg_name)
  invisible(fns)
}
