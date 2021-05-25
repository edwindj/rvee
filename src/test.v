import r {NumericVector}

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

[rv_export]
fn get_length(x C.SEXP) int{
  n := NumericVector{x}
  l := n.length()
  return l
}
