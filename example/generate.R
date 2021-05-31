#devtools::load_all()

fns <- scan_v_dir("src")

generate_rv_export_v(fns, "src/rv_export.v")
generate_init_c(fns, "src/init.c")
generate_rv_export_R(fns, "R/rv_export.R")

