#devtools::load_all()
l <- lapply(list.files("R",full.names = T), source)

pkg <- "vtest"

fns <- scan_v_dir("src")
generate_rv_export_v(fns, "src/rv_export.v", pkg = pkg)
generate_init_c(fns, "src/init.c", pkg = pkg)
generate_rv_export_R(fns, "R/rv_export.R", pkg = pkg)
run_v_to_c(pkg = pkg)


