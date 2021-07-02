module r

pub type Factor = Integer

pub fn (f Factor) levels() []string {
	sexp := C.Rf_getAttrib(f.sexp, r.levels_symbol)
	return as_string_array(sexp)
}

pub fn (f Factor) set_levels(levels []string){
	levs := character_from_strings(levels)
	C.Rf_setAttrib(f.sexp, r.levels_symbol, levs.sexp)
}

pub fn levels(f Factor) Character {
	sexp := C.Rf_getAttrib(f.sexp, r.levels_symbol)
	return as_character(sexp)
}

pub fn set_levels(f Factor, levels Character){
	C.Rf_setAttrib(f.sexp, r.levels_symbol, levels.sexp)
}

