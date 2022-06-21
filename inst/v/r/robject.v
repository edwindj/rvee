module r

interface RObject {
	sexp C.SEXP
}

pub fn copy<T>(x T) C.SEXP{
	o := x as RObject

	sexp := C.Rf_copyVector(o.sexp)
	return sexp
}

pub fn length(x RObject) int{
	return C.LENGTH(x.sexp)
}

pub fn (x RObject) names() ?[]string {
	sexp := C.Rf_getAttrib(x.sexp, r.names_symbol)
	if sexp == r.null_value {
		return none
	}
	return as_string_array(sexp)
}

pub fn (x RObject) set_names(names []string){
	nms := character_from_strings(names)
	C.Rf_setAttrib(x.sexp, r.names_symbol, nms.sexp)
}

pub fn names(x RObject) ?Character {
	sexp := C.Rf_getAttrib(x.sexp, r.names_symbol)
	if sexp == r.null_value {
		return none
	}
	return as_character(sexp)
}

pub fn set_names(x RObject, names []string){
	nms := character_from_strings(names)
	C.Rf_setAttrib(x.sexp, r.names_symbol, nms.sexp)
}
