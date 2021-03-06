#' @noRd
RV_EXPORT_R <-
"## Automatically generated with R package: `rvee`
#  rvee version: {{version}}
#
#' {{>register}}
NULL

{{#fns}}
#' {{pkg}}_{{name}}
#'
#' {{pkg}}_{{name}} calls the v function '{{name}}'
#' ('{{file}}:{{line}}').
#' {{#input}}@param {{name}} {{type}}{{/input}}
#' @return {{result}}
#' @keywords internal
{{pkg}}_{{name}} <- function({{#input}}{{^first}}, {{/first}}{{name}}{{/input}}){
  {{#input}}
  {{name}} <- as.{{type}}({{name}})
  {{/input}}
  {{#noresult}}
  invisible(.Call('_{{pkg}}_{{name}}'{{#input}}, {{name}}{{/input}}))
  {{/noresult}}
  {{^noresult}}
  .Call('_{{pkg}}_{{name}}'{{#input}}, {{name}}{{/input}})
  {{/noresult}}

}

{{/fns}}
"

generate_rv_export_R <- function(fns, file=stdout(), pkg = "rvee"){
  fns <- lapply(fns, function(fn){
    fn$input <- lapply(fn$input, function(arg){
      arg$type <- get_rtype(arg$type)
      arg
    })
    fn$noresult <- fn$result %in% c("void", "")
    fn$result <- get_rtype(fn$result)
    fn
  })
  writeLines(
    # needed because otherwise roxygen2 really gets confused...
    whisker::whisker.render( sprintf(RV_EXPORT_R)
                             , list( fns = fns
                                     , pkg=pkg
                                     , version = utils::packageVersion("rvee")
                             )
                             , partials = list(register = "@useDynLib {{pkg}}, .registration=TRUE")
    ),
    con=file
  )
}

get_rtype <- function(x){
  if (x == ""){
    x <- "void"
  }
  x <- sub("^r\\.", "", x)
  switch( x
          , "f64"           = "numeric"
          , "[]f64"         = "numeric"
          , "string"        = "character"
          , "[]string"      = "character"
          , "int"           = "integer"
          , "[]int"         = "integer"
          , "bool"          = "logical"
          , "[]bool"        = "logical"
          , "void"          = "NULL"
          , "Numeric"       = "numeric"
          , "Integer"       = "integer"
          , "Logical"       = "logical"
          , "Character"     = "character"
          , "Factor"        = "factor"
          , "List"          = "list"
          , sprintf("unknown type: %s", x)
  )
}
