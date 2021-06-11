import r {Numeric}

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
fn my_numeric(mut x Numeric) Numeric{
  //This changes the values in place!
  for i, val in x.data {
    x.data[i] = val + 1.
  }
  return x
}

