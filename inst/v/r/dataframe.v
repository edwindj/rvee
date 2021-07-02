module r

pub struct DataFrame {
	sexp C.SEXP
pub mut:
	columns []RObject
}

pub fn dataframe() DataFrame{
	sexp := C.Rf_allocList(0)
	C.Rf_setAttrib(sexp, r.class_symbol, from_string("data.frame"))
	return DataFrame{sexp: sexp}
}
