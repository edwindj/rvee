run_v_to_c <- function( dir="./src/v", outdir="./src", pkg="vtest"
                      , prod = TRUE
                      , compile=FALSE
                      , verbose=FALSE, ...
                      ){
  # TODO store v.exe and make this work for windows...
  outdir <- normalizePath(outdir)
  old_wd <- setwd(dir)
  on.exit(setwd(old_wd))
  r_mod <- system.file("v", package="rvee")
  command <- "v"
  #TODO set VCACHE or copy r mod to /tmp dir.
  c_file <- file.path(outdir, sprintf("%s.c", pkg))
  args = c( "-o"   , c_file
          , "-shared"
          , if (isTRUE(prod)) "-prod"
#          , "-freestanding"
          , "-autofree"
          , "-path", shQuote(sprintf("%s|@vlib|@vmodules", r_mod))
          , "."
          )
  system2(command, args = args, ...)
  if (!file.exists(c_file)){
    stop("v compiling error.", call. = FALSE)
  }

  # post operative surgery...
  mod_c_file(c_file, pkg = pkg)

  if (isTRUE(compile)){
    setwd(outdir)
    system2("R"
           , args = c("CMD", "SHLIB", sprintf("%s.c", pkg), "init.c",
                      "-Wno-unused-result", "-Wno-discarded-qualifiers"
                     )
           , stdout = if (verbose) "" else FALSE
           )
  }

  # command <- paste(c(shQuote(command), args), collapse = " ")
  # print(command)
  # system(command, ...)
}
