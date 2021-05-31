scan_v_dir <- function(path){
  v_files <- list.files(path = path, pattern = "\\.v$", full.names = TRUE)

  fns <- list()
  for (vfile in v_files){
    fns <- c(fns, scan_v_file(vfile))
  }

  is_null <- sapply(fns, is.null)
  if (any(is_null)){
    warning("Some functions could not be parsed")
  }
  fns
}

# TODO functions that are commented should not be found...
scan_v_file <- function(vfile){
  code <- readLines(vfile)
  rv <- grep("\\[rv_export\\s*\\]", code) + 1
  fns <- code[rv]
  scan_v_fn(fns)
}

scan_v_fn <- function(fns){
  m <- regexec("fn ([A-z0-9_]+)\\(([^)]*)\\)\\s*([^{ ]*)", fns)
  mm <- regmatches(fns, m)

  signature <- lapply(mm, function(m){
    if (length(m)){
      list(name = m[2], input = m[3], result = m[4])
    }
  })

  lapply(signature, function(f){
    if (!is.null(f$input)){
      f$input <- scan_v_input(f$input)
    }
    f
  })
}

scan_v_input <- function(input){
  input <- trimws(strsplit(input, ",")[[1]])
  lapply(strsplit(input, "\\s+"), function(arg){
    if (length(arg) > 2){
      stop("'mut' arguments are not supported:", input)
    }
    list(name = arg[1], type=arg[2])
  })
}


#vfile <- "src/test.v"
#input <- "mut x f64, y int"
