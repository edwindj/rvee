module r

//https://github.com/hadley/r-internals/blob/master/strings.md

pub struct Character {
	sexp C.SEXP
}

fn (v Character) to_sexp() C.SEXP{
	return v.sexp
}

pub fn (v Character) get_strings() []string {
	
	// this can be made much more efficient
	unsafe {
		len := C.LENGTH(v.sexp)
		mut ss := []string{len:len, cap: len}
		ptr := C.STRING_PTR_RO(v.sexp)
		for i, mut s in ss {
			//avoid copying by using literal...
			c := C.R_CHAR(ptr[i])
			s = c.vstring_literal()
		}
		return ss
	}
}

pub fn (mut v Character) set_strings(ss []string){
	C.SETLENGTH(v.sexp, C.R_xlen_t(ss.len))
	unsafe{
		// we could use STRING_PTR here, but need to take care of dangling R string pointers. 
		// may be first 
		for i, s in ss {
			// should be mkCharCE
			C.SET_STRING_ELT(v.sexp, C.R_xlen_t(i), C.Rf_mkChar(s.str))
		}
	}
	// v.data = []string{data: C.STRING_PTR_RO(v.sexp), len: ss.len, cap: ss.len}
}