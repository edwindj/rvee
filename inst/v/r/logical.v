module r

pub struct Logical {
	sexp C.SEXP
pub:
	data []int
}

[manualfree]
pub fn new_logical(len int) Logical{
	sexp := C.Rf_allocVector(.lglsxp, C.R_xlen_t(len))
	data := unsafe{as_ints(C.LOGICAL(sexp), len)}
	return Logical{sexp : sexp, data: data}
}

fn (l Logical) sync(){
}


[direct_array_access]
pub fn (l Logical) get_bools() []bool {
	unsafe{
		len := l.data.len
		mut bs := []bool{len: len, cap: len}
		for i, mut b in bs {
			b = (l.data[i] != 0)
		}
		return bs
	}
}

[manualfree;direct_array_access]
pub fn (mut l Logical) set_bools(bs []bool){
	len := bs.len
	C.SETLENGTH(l.sexp, C.R_xlen_t(len))
	unsafe {
		mut d := as_ints(C.LOGICAL(l.sexp), len)
		for i, b in bs {
			d[i] = int(b) 
		}
	}
}
