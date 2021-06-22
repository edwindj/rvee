generate_makevars <- function(file = stdout()){
  txt <-
"PKG_CFLAGS=-Wno-unused-result -Wno-discarded-qualifiers"
  writeLines(text = txt, con = file)
}
