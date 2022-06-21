module r

//https://github.com/hadley/r-internals/blob/master/strings.md

pub struct Character {
	sexp C.SEXP
pub mut:
    data []string
}

pub fn character(len int) Character{
	sexp := C.Rf_allocVector(.strsxp, C.R_xlen_t(len))
	return Character{sexp: sexp, data: []string{len:len}}
}

pub fn character_from_strings(x []string) Character{
	sexp := C.Rf_allocVector(.strsxp, C.R_xlen_t(0))
	return Character{sexp: sexp, data: x}
}


fn (v Character) to_sexp() C.SEXP{
	mut vs := v
	vs.sync()
	return vs.sexp
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

fn (mut v Character) sync(){
	C.SETLENGTH(v.sexp, C.R_xlen_t(v.data.len))
	unsafe{
		// we could use STRING_PTR here, but need to take care of dangling R string pointers. 
		// may be first 
		for i, s in v.data {
			// should be mkCharCE
			C.SET_STRING_ELT(v.sexp, C.R_xlen_t(i), C.Rf_mkChar(s.str))
		}
	}

}

fn (mut v Character) set_data() {
	// this can be made much more efficient
	unsafe {
		len := C.LENGTH(v.sexp)
		v.data = []string{len:len, cap: len}
		ptr := C.STRING_PTR_RO(v.sexp)
		for i, mut s in v.data {
			//avoid copying by using literal...
			c := C.R_CHAR(ptr[i])
			s = c.vstring_literal()
		}
	}
}

fn as_string_array(x C.SEXP) []string {
	// this can be made much more efficient
	unsafe {
		len := C.LENGTH(x)
		mut ss := []string{len:len, cap: len}
		ptr := C.STRING_PTR_RO(x)
		for i, mut s in ss {
			//avoid copying by using literal...
			c := C.R_CHAR(ptr[i])
			s = c.vstring_literal()
		}
		return ss
	}
}
