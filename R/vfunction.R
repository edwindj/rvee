VFUNC <-
"
{{{code}}}

[rv_export]
fn {{{name}}}({{sig}}) {{{ret}}}{
  {{{body}}}
}
"

#' create an R wrapper from a v function.
#'
#' like `inline::cfunction`, but for `v`.
#'
#' @param body `character`
vfunction <- function(sig, body, ret = "", code=""){
  dir_name <- tempfile()
  dir.create(dir_name, recursive = TRUE)
  fn_file_v <- tempfile(tmpdir = dir_name, fileext = ".v")
  fn_file_c <- tempfile(tmpdir = dir_name, fileext = ".c")
  fn_name <- sub("\\.v", "", basename(fn_file_v))

  code <- whisker::whisker.render( VFUNC
                                 , list( sig=sig
                                       , body = body
                                       , ret = ret
                                       , name = fn_name
                                       ))
  writeLines(code, fn_file_v)
  # TODO add checking code

  fns <- scan_v_file(fn_file_v)
  generate_rv_export_v(fns, file.path(dir_name, "rv_export.v"), pkg="rvee")
  generate_rv_export_R(fns, file.path(dir_name, "rv_export.R"), pkg="rvee")
  generate_makevars(file.path(dir_name, "Makevars"), suppress_warnings=TRUE)
  generate_init_c(fns, file.path(dir_name, "init.c"), pkg="rvee")

  # supressing warning!
  run_v_to_c(dir_name, outdir=dir_name, pkg="rvee", compile=TRUE)
  shlib <- file.path(dir_name, "rvee.so")
  dyn.load(shlib)
  source(file.path(dir_name, "rv_export.R"), local=TRUE)
  get(paste0("rvee_", fn_name))
}

#vfunction("i int", "return i + 1", "int")
