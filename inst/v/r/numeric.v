module r

pub struct Numeric {
  sexp C.SEXP
pub mut:
  data []f64
}

[manualfree]
pub fn new_numeric(len int) Numeric {
	sexp := C.Rf_allocVector(.realsxp, C.R_xlen_t(len))
	data := unsafe {as_f64array(sexp)}
	nv := Numeric{sexp, data}
	return protect(nv)
}

// pub fn new_numeric_vector(len int) Nume{
// 	unsafe {
// 	mut sexp := C.Rf_allocVector(.realsxp, xlen(len))
// 	sexp = C.Rf_p(sexp)
// 	return Numeric{sexp, true}
// 	}
// }
pub fn (v Numeric) copy() Numeric {
	len := v.data.len
	sexp := C.Rf_allocVector(.realsxp, C.R_xlen_t(len))
	
	// nasty trick, reuse the data
	nv := Numeric{sexp, v.data}
	nv.to_sexp() //copies the data
    return protect(nv)
}

pub fn (v Numeric) length() int {
	return C.LENGTH(v.sexp)
}

fn (v Numeric) to_sexp() C.SEXP {
	x := v.sexp
	mut ptr := C.REAL(x)
    if ptr != v.data.data {
		// copy the new data!
		C.SETLENGTH(x, C.R_xlen_t(v.data.len))
		// R ?
		ptr = C.REAL(x)
		unsafe {
			C.memcpy(v.data.data, ptr, v.data.len * v.data.element_size)
			v.data = as_f64s(ptr, v.data.len)
		}
	}
	return v.sexp
}

[unsafe]
fn as_f64array(sexp C.SEXP) []f64 {
	data := C.REAL(sexp)
	len := C.LENGTH(sexp)

	res := unsafe {
		array{
			element_size: 8
			data: data
			len: len
			cap: len
		}
	}
	return res
}
