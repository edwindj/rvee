generate_init_c <- function(fns, file=stdout(), pkg = "rvee"){
  fns <- lapply(fns, function(fn){
    fn$num_args <- length(fn$input)
    fn
  })
  writeLines(
    whisker::whisker.render(INIT_C, list(fns=fns, pkg=pkg)),
    con=file
  )
}

generate_rv_export_v <- function(fns, file=stdout(), pkg = "rvee"){
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
    whisker::whisker.render(RV_EXPORT_V, list(fns=fns, pkg=pkg)),
    con=file
  )
}

generate_rv_export_R <- function(fns, file=stdout(), pkg = "rvee"){
  fns <- lapply(fns, function(fn){
    fn$input <- lapply(fn$input, function(arg){
      arg$type <- get_rtype(arg$type)
      arg
    })
    fn$result <- get_rtype(fn$result)
    fn
  })
  writeLines(
    # needed because otherwise roxygen2 gets really confused...
    whisker::whisker.render( sprintf(RV_EXPORT_R, "@useDynLib {{pkg}}, .registration=TRUE")
                           , list(fns=fns, pkg=pkg)
                           ),
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
