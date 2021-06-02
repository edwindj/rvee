module r

pub interface Vector {
	sexp C.SEXP
	protect bool
}

pub struct IntegerVector {
	sexp C.SEXP
}

fn new_integer_vector(len int) IntegerVector {
	sexp := C.Rf_allocVector(.intsxp, C.R_xlen_t(len))
	return IntegerVector{sexp}
}

 