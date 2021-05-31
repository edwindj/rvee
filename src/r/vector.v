module r

pub struct NumericVector {
	sexp C.SEXP
}

pub struct IntegerVector {
	sexp C.SEXP
}

pub type RVector = NumericVector

pub fn (v RVector) length() int {
	return C.LENGTH(v.sexp)
}

pub fn (v NumericVector) length() int {
	return C.LENGTH(v.sexp)
}

pub fn (n NumericVector) f64s() []f64 {
	len := int(n.length())
	data := C.REAL(n.sexp)
	return unsafe{as_f64s(data, len)}
}
