#include <R.h>
#include <Rinternals.h>

[typedef]
struct C.SEXP{}

// conversion
fn C.SCALAR_DVAL(x C.SEXP) f64
fn C.REAL(x C.SEXP) voidptr  // double *


[unsafe]
fn (data voidptr) f64s(len int) []f64 {
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
fn (data voidptr) ints(len int) []int {
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

pub fn (Vector v) length() int {
	return 1;
}

pub fn (NumericVector n) f64() []f64 {
	len := n.length()
	ret := unsafe{
		array{ 
			element_size: 8,
			data: C.REAL(n),
			len: len,
			cap: len
		}
	}
	return []f64(ret);
}

