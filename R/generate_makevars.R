MAKEVARS <-
"# generated with `rvee`
# rvee version {{{version}}}
{{^suppress_warnings}}
PKG_CFLAGS=-s
{{/suppress_warnings}}
{{#suppress_warnings}}
PKG_CFLAGS=-s -Wno-unused-result -Wno-discarded-qualifiers
{{/suppress_warnings}}
"

generate_makevars <- function(file = stdout(), suppress_warnings=FALSE){
  version <- utils::packageVersion("rvee")
  text <- whisker::whisker.render( MAKEVARS
                                 , data = list( suppress_warnings=suppress_warnings
                                              , version = version
                                              )
                                 )
  writeLines(text = text, con = file)
}
