module r 

//utility

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

