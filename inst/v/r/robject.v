module r

interface RObject {
	sexp C.SEXP
}

pub fn copy<T>(T x) C.SEXP{
	o := x as RObject

	sexp := C.Rf_copyVector(o.sexp)
	return sexp
}

pub fn length(x RObject) int{
	return C.LENGTH(x.sexp)
}