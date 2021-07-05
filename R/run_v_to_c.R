run_v_to_c <- function(dir="./src/v", outdir="./src", pkg="vtest", ...){
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
          , "-prod"
#          , "-freestanding"
          , "-autofree"
          , "-path", shQuote(sprintf("%s|@vlib|@vmodules", r_mod))
          , "."
          )
  system2(command, args = args, ...)

  # post operative surgery...
  mod_c_file(c_file, pkg = pkg)

  # command <- paste(c(shQuote(command), args), collapse = " ")
  # print(command)
  # system(command, ...)
}
