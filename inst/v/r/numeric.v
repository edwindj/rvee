module r

pub struct Numeric {
  sexp C.SEXP
pub mut:
  data []f64
}

[manualfree]
pub fn numeric(len int) Numeric {
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
pub fn numeric_from_f64s(data []f64) Numeric {
	sexp := C.Rf_allocVector(.realsxp, C.R_xlen_t(data.len))
	mut nv := Numeric{sexp: protect_sexp(sexp), data:data}
	nv.sync()
	return nv
}

pub fn (v Numeric) copy() Numeric {
	len := v.data.len
	sexp := C.Rf_allocVector(.realsxp, C.R_xlen_t(len))
	mut nv := Numeric{sexp: protect_sexp(sexp), data:v.data}
	nv.sync()
	return nv
}

pub fn (v Numeric) length() int {
	return C.LENGTH(v.sexp)
}

fn(mut v Numeric) sync(){
	mut ptr := C.REAL(v.sexp)
    if ptr != v.data.data {
		// copy the new data!
		C.SETLENGTH(v.sexp, C.R_xlen_t(v.data.len))
		// R ?
		ptr = C.REAL(v.sexp)
		unsafe {
			C.memcpy(ptr, v.data.data, v.data.len * v.data.element_size)
			v.data = as_f64s(ptr, v.data.len)
		}
	}
}

fn (v Numeric) to_sexp() C.SEXP {
	mut vs := v
	vs.sync()
	return vs.sexp
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
