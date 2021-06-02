module r


//https://github.com/hadley/r-internals/blob/master/strings.md

pub struct CharacterVector {
	sexp C.SEXP
}

fn rstring_to_vstring(s C.SEXP){

}

fn vstring_to_rstring(s string) C.SEXP {
	rchar := C.Rf_mkCharCE(&char(s.str), C.cetype_t(CE.utf8))
	return rchar 
}

fn rstring_as_vstring(s C.SEXP) string{
	unsafe{
		vstr := C.R_CHAR(s).vstring() 
		return vstr
	}
}