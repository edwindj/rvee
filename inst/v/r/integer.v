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

pub fn integer_from_ints(x []int) Integer{
	sexp := C.Rf_allocVector(.intsxp, C.R_xlen_t(x.len))
	mut l := Integer{sexp: protect_sexp(sexp), data: x}
	l.sync()
	return l
}

[manualfree]
pub fn (v Integer) copy() Integer {
	return integer_from_ints(v.data)
}

pub fn (v Integer) length() int {
	return C.LENGTH(v.sexp)
}

fn (mut v Integer) sync(){
	// if pointer of R differs from v array
	if C.INTEGER(v.sexp) != v.data.data {
		// copy the new data!
		C.SETLENGTH(v.sexp, C.R_xlen_t(v.data.len))
		// R reallocation?
		ptr := C.INTEGER(v.sexp)
		unsafe{
			C.memcpy(ptr, v.data.data, v.data.len * v.data.element_size)
			v.data = as_ints(ptr, v.data.len)
		}
	}
}


fn (v Integer) to_sexp() C.SEXP {
	mut vs := v
	vs.sync()
	return vs.sexp
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

