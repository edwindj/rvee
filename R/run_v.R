run_v_to_c <- function(dir="./src", pkg="vtest"){
  # TODO store v.exe
  old_wd <- setwd(dir)
  on.exit(setwd(old_wd))
  system2( "v"
         , args = c( "-o", sprintf("%s.c", pkg)
                   , "-shared"
                   , "."
                   )
         )
}
