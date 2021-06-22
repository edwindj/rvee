module r

pub struct Logical {
	sexp C.SEXP
pub mut:
	data []bool // copy of data!
}

pub fn logical(len int) &Logical{
	sexp := C.Rf_allocVector(.lglsxp, C.R_xlen_t(len))
	mut l := Logical{sexp : sexp}
	l.set_data()
	return &l
}

pub fn logical_from_bools(bs []bool) &Logical {
	sexp := C.Rf_allocVector(.lglsxp, C.R_xlen_t(bs.len))
	mut l := Logical{sexp: sexp, data: bs}
	l.sync()
	return &l
}

fn (l Logical) to_sexp() C.SEXP{
	l.sync()
	return l.sexp
}

[direct_array_access;manualfree]
fn (mut l Logical) set_data() []bool {
	unsafe{
		len := C.LENGTH(l.sexp)
		l.data = []bool{len: len}
		data := as_ints(C.LOGICAL(l.sexp), len)
		for i, mut b in l.data {
			b = (data[i] != 0)
		}
		//TODO setlength to 0 for SEXP?
		return l.data
	}
}

[manualfree;direct_array_access]
fn (l &Logical) sync(){
	len := l.data.len
	C.SETLENGTH(l.sexp, C.R_xlen_t(len))
	unsafe {
		mut d := as_ints(C.LOGICAL(l.sexp), len)
		for i, b in l.data {
			d[i] = int(b) 
		}
	}
}
