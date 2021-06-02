INIT_C <-
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

RV_EXPORT_V <-
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

#' @noRd
RV_EXPORT_R <-
"## Automatically generated with R package: `rvee`
#
#' %s
NULL

{{#fns}}
#' {{pkg}}_{{name}}
#'
#' {{pkg}}_{{name}} calls the v function '{{name}}'.
#' {{#input}}@param {{name}} {{type}}{{/input}}
#' @return {{result}}
#' @keywords internal
{{pkg}}_{{name}} <- function({{#input}}{{name}}{{/input}}){
  .Call('_{{pkg}}_{{name}}' {{#input}},{{name}}{{/input}})
}

{{/fns}}
"

