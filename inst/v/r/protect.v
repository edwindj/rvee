module r

interface RObject {
	sexp C.SEXP
}

struct Protect {
	// ch chan int
	mut: 
		count int
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

const protected = Protect{}

pub fn protect<T>(x T) T{
	// obj := RObject(x)
	sexp := r.protected.add(x)
	return T{sexp: sexp}
}

