module r

#include <R.h>
#include <Rinternals.h>

[typedef]
struct C.SEXP{}

// Access
fn C.LENGTH(x C.SEXP) int // todo XLENGTH not working yet...

// conversion
fn C.SCALAR_DVAL(x C.SEXP) f64
fn C.REAL(x C.SEXP) voidptr  // double *


[unsafe]
fn as_f64(data voidptr, len int) []f64 {
	res := unsafe{
		array{
			element_size: 8,
			data: data,
			len: len,
			cap: len
		}
	}
	return res
}

[unsafe]
fn as_int(data voidptr, len int) []int {
	res := unsafe{
		array{
			element_size: 4,
			data: data,
			len: len,
			cap: len
		}
	}
	return res
}


type Vector = NumericVector

pub struct NumericVector {
	sexp C.SEXP
}

pub fn (v NumericVector) length() int {
	return C.LENGTH(v.sexp)
}

pub fn (n NumericVector) f64() []f64 {
	len := int(n.length())
	data := C.REAL(n.sexp)
	return unsafe{as_f64(data, len)}
}

