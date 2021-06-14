module r

pub struct Integer {
  sexp C.SEXP
pub mut:
  data []int
}

[manualfree]
pub fn integer(len int) Integer {
	sexp := C.Rf_allocVector(.intsxp, C.R_xlen_t(len))
	data := unsafe {as_intarray(sexp)}
	nv := Integer{sexp, data}
	return protect(nv)
}

[manualfree]
pub fn integer_from_ints(x []int) Integer{
	sexp := C.Rf_allocVector(.intsxp, C.R_xlen_t(x.len))
	l := Integer{sexp: sexp, data: x}
	l.sync()
	return l
}

[manualfree]
pub fn (v Integer) copy() Integer {
	len := v.data.len
	sexp := C.Rf_allocVector(.intsxp, C.R_xlen_t(len))
	
	// nasty trick, reuse the data
	nv := Integer{sexp, v.data}
	nv.to_sexp() //copies the data

	return protect(nv)
}

pub fn (v Integer) length() int {
	return C.LENGTH(v.sexp)
}

fn (v Integer) sync(){
	// if pointer of R differs from v array
	x := v.sexp
	if C.INTEGER(x) != v.data.data {
		// copy the new data!
		C.SETLENGTH(x, C.R_xlen_t(v.data.len))
		// R reallocation?
		ptr := C.INTEGER(x)
		unsafe{
			C.memcpy(v.data.data, ptr, v.data.len * v.data.element_size)
			v.data = as_ints(ptr, v.data.len)
		}
	}
}


fn (v Integer) to_sexp() C.SEXP {
	v.sync()
	return v.sexp
}

[unsafe]
fn as_intarray(sexp C.SEXP) []int {
	data := C.INTEGER(sexp)
	len := C.LENGTH(sexp)

	res := unsafe {
		array{
			element_size: 4
			data: data
			len: len
			cap: len
		}
	}
	return res
}

