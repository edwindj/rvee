#' @importFrom whisker whisker.render
generate_init_c <- function(fns, file=stdout(), pkg = "rvee"){
  init_c <-
'/* Automatically generated with R package: `rvee`
*
*/
#include <R.h>
#include <Rinternals.h>

// These are wrapped functions that are exported (see file "rv_export.v").
{{#fns}}
SEXP main__{{pkg}}_{{name}}({{#input}}SEXP {{name}}{{/input}});
{{/fns}}


static const R_CallMethodDef CallEntries[] = {
  {{#fns}}
  {"_{{pkg}}_{{name}}", (DL_FUNC) &main__{{pkg}}_{{name}}, {{num_args}} },
  {{/fns}}
  {NULL, NULL, 0}
};

extern void R_init_{{pkg}}(DllInfo *dll) {
  R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
  R_useDynamicSymbols(dll, FALSE);
};
'
  fns <- lapply(fns, function(fn){
    fn$num_args <- length(fn$input)
    fn
  })
  writeLines(
    whisker::whisker.render(init_c, list(fns=fns, pkg=pkg)),
    con=file
  )
}

#' @useDynLib
generate_rv_export_v <- function(fns, file=stdout(), pkg = "rvee"){
  rv_export <-
'/* Automatically generated with R package: `rvee`
*
*/
import r

{{#fns}}
fn {{pkg}}_{{name}}({{#input}}{{name}} C.SEXP{{/input}}) C.SEXP {
  {{#input}}

  // wrap input {{name}}
  i_{{name}} := r.as_{{type}}({{name}})
  {{/input}}
  {{#result}}

  res := {{name}}({{#input}}i_{{name}}{{/input}})
  //wrap output
  o_res := r.from_{{result}}(res)
  return o_res
  {{/result}}
  {{^result}}
  {{name}}({{#input}}i_{{name}}{{/input}})
  return r.null_value
  {{/result }}
}

{{/fns}}
'
  fns <- lapply(fns, function(fn){
    fn$num_args <- length(fn$input)
    fn$input <- lapply(fn$input,function(i){
      i$type <- snake_case(i$type)
      i
    })

    fn$result <- snake_case(fn$result)
    if (fn$result == ""){
      fn$result <- FALSE
    }
    fn
  })
  writeLines(
    whisker::whisker.render(rv_export, list(fns=fns, pkg=pkg)),
    con=file
  )
}


generate_rv_export_R <- function(fns, file=stdout(), pkg = "rvee"){
  rv_export <-
"## Automatically generated with R package: `rvee`
#
#' @useDynLib {{pkg}}, .registration=TRUE

{{#fns}}
#' {{pkg}}_{{name}}
#'
#' {{pkg}}_{{name}} calls the v function '{{name}}'.
#'
#' {{#input}}@param {{name}} {{type}}{{/input}}
#' @return {{result}}
#' @keywords internal
{{pkg}}_{{name}} <- function({{#input}}{{name}}{{/input}}){
  .Call('_{{pkg}}_{{name}}' {{#input}},{{name}}{{/input}})
}

{{/fns}}
"
  fns <- lapply(fns, function(fn){
    fn$input <- lapply(fn$input, function(arg){
      arg$type <- get_rtype(arg$type)
      arg
    })
    fn$result <- get_rtype(fn$result)
    fn
  })
  writeLines(
    whisker::whisker.render(rv_export, list(fns=fns, pkg=pkg)),
    con=file
  )
}

get_rtype <- function(x){
  switch( x
        , "f64"    = "numeric"
        , "string" = "character"
        , "int"    = "integer"
        , "bool"   = "logical"
        , "void"   = "NULL"
        , sprintf("unknown type: %s", x)
        )
}
