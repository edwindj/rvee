module r

#include <R.h>
#include <Rinternals.h>

[typedef]
struct C.SEXP {}

// Access
fn C.LENGTH(x C.SEXP) int

// todo XLENGTH not working yet...

// conversion
fn C.SCALAR_DVAL(x C.SEXP) f64
fn C.SCALAR_IVAL(x C.SEXP) int
fn C.SCALAR_LVAL(x C.SEXP) int

fn C.REAL(x C.SEXP) voidptr

// double *
fn C.INTEGER(x C.SEXP) voidptr

// int *
fn C.LOGICAL(x C.SEXP) voidptr

// to SEXP
fn C.Rf_ScalarInteger(x int) C.SEXP
fn C.Rf_ScalarLogical(x int) C.SEXP
fn C.Rf_ScalarReal(x f64) C.SEXP

// special values
pub const (
  null_value = C.SEXP(C.R_NilValue)
)

// int *

[unsafe]
fn as_f64s(data voidptr, len int) []f64 {
	res := unsafe {
		array{
			element_size: 8
			data: data
			len: len
			cap: len
		}
	}
	return res
}

[unsafe]
fn as_ints(data voidptr, len int) []int {
	res := unsafe {
		array{
			element_size: 4
			data: data
			len: len
			cap: len
		}
	}
	return res
}
