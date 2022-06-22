v_function(
"fn add_v(x int, y int) int{
   return x + y
}"
)

add_r <- function(x, y){
  x + y
}

system.time({
  replicate(10000, {add_r(1L, 2L)})
})

system.time({
  replicate(10000, {add_v(1L, 2L)})
})


dist_r <- function(x, d){
  (x-d)*(x-d)
}

v_function("fn dist_v1(x []int, d int) []int{
  mut y := x.clone()
  for mut yi in y {
    y2 := yi - d
    yi = y2 + y2
  }
  return y
}")

res <- bench::mark(
  dist_v1(1:10, 2),
  dist_r(1:10, 2)
)

View(res)
