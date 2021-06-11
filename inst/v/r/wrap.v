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
[manualfree]
pub fn as_numeric_vector(x C.SEXP) NumericVector {
  data := unsafe{as_f64s(C.REAL(x), C.LENGTH(x))}
  return NumericVector{x, data}
}

pub fn as_integer_vector(x C.SEXP) IntegerVector {
  return IntegerVector{x}
}

pub fn from_f64(x f64) C.SEXP {
  return C.Rf_ScalarReal(x)
}

pub fn from_int(x int) C.SEXP{
  return C.Rf_ScalarInteger(x)
}

pub fn from_bool(x bool) C.SEXP {
   return C.Rf_ScalarLogical(int(x))
}

pub fn from_numeric_vector(x NumericVector) C.SEXP {
  return x.to_sexp()
}

pub fn from_integer_vector(x IntegerVector) C.SEXP {
  return x.sexp
}

pub fn from_void() C.SEXP {
  return null_value
}

