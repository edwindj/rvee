module r

pub struct Protect {
	// ch chan int
	mut:
		count int
}

fn (mut p Protect) sexp(x C.SEXP) C.SEXP {
	sexp := C.Rf_protect(x)

	//HACK mutating a global const...
	unsafe{
		p.count += 1
	}
	// this would be threadsafe...
	// count := <-p.ch
	// p.ch <-(count + 1)
	return sexp
}


fn (p Protect) add(o RObject) C.SEXP {
	sexp := C.Rf_protect(o.sexp)

	//HACK mutating a global const...
	unsafe{
		p.count += 1
	}
	// this would be threadsafe...
	// count := <-p.ch
	// p.ch <-(count + 1)
	return sexp
}

pub fn (p Protect) flush(){
	if p.count > 0 {
		C.Rf_unprotect(p.count)
	}

	unsafe{
		p.count = 0
	}
}

pub const protected = Protect{}

pub fn protect<T>(x T) T{
	// obj := RObject(x)
	sexp := r.protected.add(x)
	return T{sexp}
}

fn protect_sexp(x C.SEXP) C.SEXP{
	return x
	// mut prot := r.protected
	// return prot.sexp(x)
}
