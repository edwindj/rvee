module r

pub struct NumericVector {
	sexp C.SEXP
}

pub fn (v NumericVector) length() int {
	return C.LENGTH(v.sexp)
}

pub fn (n NumericVector) f64s() []f64 {
	len := int(n.length())
	data := C.REAL(n.sexp)
	return unsafe { as_f64s(data, len) }
}
