#devtools::load_all()
#l <- lapply(list.files("R",full.names = T), source)

pkg <- "rveetest"
pkg_dir <- sprintf("../%s", pkg)

fns <- scan_v_dir(file.path(pkg_dir, "src"))
generate_rv_export_v(fns, file.path(pkg_dir, "src", "rv_export.v"), pkg = pkg)
generate_init_c(fns, file.path(pkg_dir, "src", "init.c"), pkg = pkg)
generate_rv_export_R(fns, file.path(pkg_dir, "R", "rv_export.R"), pkg = pkg)
run_v_to_c(dir = file.path(pkg_dir, "src"), pkg = pkg)
