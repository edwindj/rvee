MAKEVARS <-
"# generated with `rvee`
PKG_CFLAGS=-s
#PKG_CFLAGS=-Wno-unused-result -Wno-discarded-qualifiers
"

generate_makevars <- function(file = stdout()){
  writeLines(text = MAKEVARS, con = file)
}
