module r

pub struct List {
	sexp C.SEXP
pub mut:
	data []RObject
}

pub fn list() List{
	sexp := C.Rf_allocList(0)
	return List{sexp: sexp}
}

//TODO change this into a RObject (or something like that)
	pub fn (l List) get(i int) C.SEXP {
	sexp := C.VECTOR_ELT(l.sexp, C.R_xlen_t(i))
	return sexp
}

pub fn list_from_map(m map[string]RObject) List {
	l := List{sexp : C.Rf_allocList(m.len)}

	mut nms := []string{}
	for k, v in m {
		C.SET_VECTOR_ELT(l.sexp, C.R_xlen_t(nms.len), v.sexp)	
		nms << k
	}

	l.set_names(nms)
	return l
}

//TODO change this into a RObject (or something like that)
pub fn (l List) set(i int, sexp C.SEXP){
	C.SET_VECTOR_ELT(l.sexp, C.R_xlen_t(i), sexp)
}

fn (l List) sync(){
}

pub fn (l List) set_names(nms []string){
	C.Rf_setAttrib(l.sexp, r.names_symbol, character_from_strings(nms).sexp)
}

pub fn (l List) names() []string {
	sexp := C.Rf_getAttrib(l.sexp, r.names_symbol)
	return as_string_array(sexp)
}