#include <R.h>
#include <Rinternals.h>

double main__test(double x);

extern SEXP _vtest_test(SEXP x){
  // wrapping SEXP
  double v_x = SCALAR_DVAL(x);

  double v_ret = main__test(v_x);

  SEXP ret = Rf_ScalarReal(v_ret);
  return ret;
}

static const R_CallMethodDef CallEntries[] = {
  {"_vtest_test", (DL_FUNC) &_vtest_test, 1},
  {NULL, NULL, 0}
};

extern void R_init_vtest(DllInfo *dll) {
  R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
  R_useDynamicSymbols(dll, FALSE);
}
