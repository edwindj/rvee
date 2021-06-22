RV_EXPORT_V <-
'/* Automatically generated with R package: `rvee`
* rvee version: {{version}}
*/
import r

{{#fns}}
[manualfree]
fn {{pkg}}_{{name}}({{#input}}{{name}} C.SEXP{{/input}}) C.SEXP {
  defer {r.protected.flush()} // clear any protected r objects

  {{#input}}
  // wrap input {{name}}
  {{#mut}}mut {{/mut}}i_{{name}}_v := r.as_{{type}}({{name}})
  {{/input}}
  {{#result}}
  res := {{name}}({{#input}}{{#mut}}mut {{/mut}}i_{{name}}_v{{/input}})

  //wrap output
  return r.from_{{result}}(res)
  {{/result}}
  {{^result}}
  {{name}}({{#input}}{{#mut}}mut {{/mut}}i_{{name}}_v{{/input}})
  return r.null_value
  {{/result }}
}

{{/fns}}
'

generate_rv_export_v <- function(fns, file=stdout(), pkg = "rvee"){
  fns <- lapply(fns, function(fn){
    fn$num_args <- length(fn$input)

    fn$input <- lapply(fn$input,function(i){
      i$type <- sub("^\\[\\](.*)", "\\1_array", i$type)
      i$type <- snake_case(i$type)
      i
    })

    fn$result <- sub("^\\[\\](.*)", "\\1_array", fn$result)
    fn$result <- snake_case(fn$result)
    if (fn$result == ""){
      fn$result <- FALSE
    }
    fn
  })
  version <- utils::packageVersion("rvee")
  writeLines(
    whisker::whisker.render(RV_EXPORT_V, list(fns=fns, pkg=pkg, version=version)),
    con=file
  )
}
