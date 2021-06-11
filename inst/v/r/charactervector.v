module r

//https://github.com/hadley/r-internals/blob/master/strings.md

pub struct CharacterVector {
	sexp C.SEXP
pub mut:
	data []charptr
}

fn (mut v CharacterVector) to_sexp() C.SEXP{
	return v.sexp
}

fn (v CharacterVector) get_strings() []string {
	// this can be made much more efficient
	unsafe {
		len := v.data.len
		mut s := []string{len:len, cap: len}
		for i, c in v.data {
			//avoid copying by using literal...
			s[i] = c.vstring_literal()
		}
		return s
	}
}

fn (mut v CharacterVector) set_strings(ss []string){
	C.SETLENGTH(v.sexp, C.R_xlen_t(ss.len))
	unsafe{
		ptr := C.STRING_PTR(v.sexp)
		for i, s in ss {
			// should be mkCharCE
			C.SET_STRING_ELT(v.sexp, C.R_xlen_t(i), C.Rf_mkChar(s.str))
		}
	}
	// v.data = []string{data: C.STRING_PTR_RO(v.sexp), len: ss.len, cap: ss.len}
}