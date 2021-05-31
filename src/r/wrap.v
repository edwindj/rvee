module r

// conversion between types

pub fn as_f64(x C.SEXP) f64{
  return C.SCALAR_DVAL(x)
}

pub fn as_int(x C.SEXP) int{
  return C.SCALAR_IVAL(x)
}

pub fn as_bool(x C.SEXP) bool{
  return C.SCALAR_LVAL(x) != 0
}

// assumes that x is a numeric vector
pub fn as_numeric_vector(x C.SEXP) NumericVector {
  return NumericVector{x}
}

pub fn as_integer_vector(x C.SEXP) IntegerVector {
  return IntegerVector{x}
}

pub fn from_numeric_vector(x NumericVector) C.SEXP {
  return x.sexp
}

pub fn from_integer_vector(x IntegerVector) C.SEXP {
  return x.sexp
}