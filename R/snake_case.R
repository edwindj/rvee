snake_case <- function(x){
  tolower(gsub("\\B([A-Z])", "_\\L\\1", x, perl=T))
}

PascalCase <- function(x){
  gsub("(\\b|_)([a-z])", "\\U\\2", x, perl=T)
}

# x <- c("IntegerVector", "NumericVector", "WithTestOfNothing")
# snake_case(x)
#
# PascalCase(snake_case(x))

