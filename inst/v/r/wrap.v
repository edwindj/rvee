module r

// conversion between types
pub fn as_f64(x C.SEXP) f64{
  return C.SCALAR_DVAL(x)
}

pub fn as_int(x C.SEXP) int{
  return C.SCALAR_IVAL(x)
}

[manualfree]
pub fn as_int_array(x C.SEXP) []int{
  return as_integer(x).data
}

pub fn as_bool(x C.SEXP) bool{
  return C.SCALAR_LVAL(x) != 0
}

pub fn as_string(x C.SEXP) string {
  unsafe {
    ch := C.STRING_PTR_RO(x)
    // this is not UTF8 safe, to be improved
    ch2 := C.R_CHAR(ch[0])
    // copies the string!
    return cstring_to_vstring(ch2)
  }
}

// assumes that x is a numeric vector
[manualfree]
pub fn as_numeric(x C.SEXP) Numeric {
  data := unsafe{as_f64s(C.REAL(x), C.LENGTH(x))}
  return Numeric{x, data}
}

[manualfree]
pub fn as_integer(x C.SEXP) Integer {
  data := unsafe{as_ints(C.INTEGER(x), C.LENGTH(x))}
  return Integer{x, data}
}

pub fn as_character(x C.SEXP) Character {
  return Character{sexp: x}
}

pub fn from_f64(x f64) C.SEXP {
  return C.Rf_ScalarReal(x)
}

pub fn from_int(x int) C.SEXP{
  return C.Rf_ScalarInteger(x)
}

[manualfree]
pub fn from_int_array(x []int) C.SEXP{
  return integer_from_ints(x).to_sexp()
}


pub fn from_bool(x bool) C.SEXP {
   return C.Rf_ScalarLogical(int(x))
}

pub fn from_string(x string) C.SEXP {
  // this is not UTF8 safe on Windows...
  return C.Rf_mkString(x.str)
}

pub fn from_numeric(x Numeric) C.SEXP {
  return x.to_sexp()
}

pub fn from_integer(x Integer) C.SEXP {
  return x.to_sexp()
}

pub fn from_character(x Character) C.SEXP {
  return x.to_sexp()
}

pub fn from_logical(x Logical) C.SEXP {
  return x.to_sexp()
}

pub fn from_void() C.SEXP {
  return null_value
}
