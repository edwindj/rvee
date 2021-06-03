import r {NumericVector}

[rv_export]
pub fn scalar_numeric(x f64) f64{
   return x + 1.
}

[rv_export]
pub fn scalar_integer(x int) int{
   return x + 1
}


[rv_export]
fn negate(x bool) bool {
  return !x
}

[rv_export]
fn my_numeric(x NumericVector) NumericVector{
  //This changes the values in place!
  mut values := x.f64s()
  for mut val in values {
    val += 1.
  }
  return x
}

