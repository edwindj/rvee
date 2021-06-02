module r

pub struct NumericVector {
	sexp C.SEXP
}

fn new_numeric_vector(len int) &NumericVector {
	unsafe{
	mut sexp := C.Rf_allocVector(.realsxp, C.R_xlen_t(len))
	sexp = C.Rf_protect(sexp)
	return &NumericVector{sexp}
	}
}

fn (x &NumericVector) free(){
	unsafe{
		C.Rf_unprotect(1)
	}
}

// pub fn new_numeric_vector(len int) NumericVector{
// 	unsafe {
// 	mut sexp := C.Rf_allocVector(.realsxp, xlen(len))
// 	sexp = C.Rf_protect(sexp)
// 	return NumericVector{sexp, true}
// 	}
// }

pub fn (v NumericVector) length() int {
	return C.LENGTH(v.sexp)
}

pub fn (n NumericVector) f64s() []f64 {
	len := int(n.length())
	data := C.REAL(n.sexp)
	return unsafe { as_f64s(data, len) }
}
