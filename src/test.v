[rv_export]
pub fn test(x f64) f64{
   return x + 1
}

[rv_export]
pub fn test2(x f64) (f64,f64){
  return 1, 2
}

fn test_r(x C.SEXP) f64{
  return C.SCALAR_DVAL(x)
}

fn test_r2(x C.SEXP){
  y := C.REAL(x)
  println(y)
}
