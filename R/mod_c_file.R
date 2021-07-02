C_FILE <-
'/* Automatically generated with V <https://vlang.io>
*  using R package: `rvee`
*  rvee version: {{version}}
*  source: `./rv_export.v`
*/
'

#' modify c file so it redirects to R constructs when printing and errorring.
#' @keywords internal
mod_c_file <- function(c_file, pkg){
  c_code <- readLines(c_file)

  data <- list(version = utils::packageVersion("rvee"))
  preamble <- whisker::whisker.render(C_FILE, data = data)

  # change printf into Rprintf
  c_code <- gsub("\\bprintf\\b", "Rprintf", c_code)

  # redirect v_panic
  body_begin <- grep("^void v_panic\\(", c_code)[2]
  end_function <- grep("^\\}", c_code)
  body_end <- end_function[end_function>body_begin][1]
  c_code <- c( c_code[1:body_begin]
             , '\tRf_error("v error: %s", s.str);'
             , c_code[body_end:length(c_code)]
             )

  # redirect exit
  c_code <- gsub("\\bexit\\((\\w+)\\)", 'Rf_error("v exit code: %d", \\1)', c_code)

  # redirect print
  body_begin <- grep("^void print\\(", c_code)[2]
  end_function <- grep("^\\}", c_code)
  body_end <- end_function[end_function>body_begin][1]
  c_code <- c( c_code[1:body_begin]
               , '\tRprintf("v lib: %s", s.str);'
               , c_code[body_end:length(c_code)]
  )

    # redirect println
  body_begin <- grep("^void println", c_code)[2]
  end_function <- grep("^\\}", c_code)
  body_end <- end_function[end_function>body_begin][1]
  c_code <- c( c_code[1:body_begin]
               , '\tRprintf("v lib: %s\\n", s.str);'
               , c_code[body_end:length(c_code)]
  )

  # redirect eprint
  body_begin <- grep("^void eprint\\(", c_code)[2]
  end_function <- grep("^\\}", c_code)
  body_end <- end_function[end_function>body_begin][1]
  c_code <- c( c_code[1:body_begin]
               , '\tREprintf("v lib: %s", s.str);'
               , c_code[body_end:length(c_code)]
  )

    # redirect eprintln
  body_begin <- grep("^void eprintln\\(", c_code)[2]
  end_function <- grep("^\\}", c_code)
  body_end <- end_function[end_function>body_begin][1]
  c_code <- c( c_code[1:body_begin]
               , '\tREprintf("v lib: %s\\n", s.str);'
               , c_code[body_end:length(c_code)]
  )

  c_code <- c(preamble, c_code)
  writeLines(c_code, c_file)
}
