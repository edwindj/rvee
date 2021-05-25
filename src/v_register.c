#include <R.h>
#include <Rinternals.h>

double main__test(double x);
int main__get_length(SEXP x);

extern SEXP _vtest_test(SEXP x){
  // wrapping SEXP
  double v_x = SCALAR_DVAL(x);

  double v_ret = main__test(v_x);

  SEXP ret = Rf_ScalarReal(v_ret);
  return ret;
}

extern SEXP _vtest_getlength(SEXP x){
  // wrapping SEXP

  int v_ret = main__get_length(x);

  SEXP ret = Rf_ScalarInteger(v_ret);
  return ret;
}


static const R_CallMethodDef CallEntries[] = {
  {"_vtest_test", (DL_FUNC) &_vtest_test, 1},
  {"_vtest_getlength", (DL_FUNC) &_vtest_getlength, 1},
  {NULL, NULL, 0}
};

extern void R_init_vtest(DllInfo *dll) {
  R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
  R_useDynamicSymbols(dll, FALSE);
}
