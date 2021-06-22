INIT_C <-
'/* Automatically generated with R package: `rvee`
* rvee version: {{version}}
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

generate_init_c <- function(fns, file=stdout(), pkg = "rvee"){
  fns <- lapply(fns, function(fn){
    fn$num_args <- length(fn$input)
    fn
  })
  writeLines(
    whisker::whisker.render(INIT_C, list(fns=fns
                                        , pkg=pkg
                                        , version = utils::packageVersion("rvee")
                                        )
                           ),
    con=file
  )
}

