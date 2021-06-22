module r

pub type Factor = Integer

pub fn (f Factor) levels() Character {
	sexp := C.Rf_getAttrib(f.sexp, r.levels_symbol)
	return as_character(sexp)
}