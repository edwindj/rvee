module r

pub struct NumericVector {
	sexp C.SEXP
pub mut:
  data []f64
}

pub fn new_numeric_vector(len int) NumericVector {
	sexp := C.Rf_allocVector(.realsxp, C.R_xlen_t(len))
	data := unsafe {as_f64s(C.REAL(sexp), len)}
	nv := NumericVector{sexp, data}
	return protect(nv)
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

fn (v NumericVector) to_sexp() C.SEXP {
	x := v.sexp
	mut ptr := C.REAL(x)

	if ptr != v.data.data {
		// copy the new data!
		C.SETLENGTH(x, C.R_xlen_t(v.data.len))
		// R reallocation?
		ptr = C.REAL(x)
		unsafe{
			C.memcpy(v.data.data, ptr, v.data.len * v.data.element_size)
			v.data = as_f64s(ptr, v.data.len)
		}
	}
	return v.sexp
}
