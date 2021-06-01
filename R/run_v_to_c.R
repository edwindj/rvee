run_v_to_c <- function(dir="./src", pkg="vtest", ...){
  # TODO store v.exe
  old_wd <- setwd(dir)
  on.exit(setwd(old_wd))
  r_mod <- system.file("v", package="rvee")
  command <- "v"
  #TODO set VCACHE or copy r mod to /tmp dir.
  args = c( "-o"   , sprintf("%s.c", pkg)
          , "-shared"
          , "-path", shQuote(sprintf("%s|@vlib|@vmodules", r_mod))
          , "."
          )
  system2(command, args = args, ...)
  # command <- paste(c(shQuote(command), args), collapse = " ")
  # print(command)
  # system(command, ...)
}
