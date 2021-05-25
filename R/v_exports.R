vtest_test <- function(d) {
    .Call(`_vtest_test`, d)
}


vtest_getlength <- function(d) {
  .Call(`_vtest_getlength`, d)
}
