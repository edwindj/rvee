module r

// #define R_ARITH_H_
pub const (
// LibExtern double R_NaN;		/* IEEE NaN */
	nan = f64(C.R_NaN)
// LibExtern double R_PosInf;	/* IEEE Inf */
    pos_inf = f64(C.R_PosInf)
// LibExtern double R_NegInf;	/* IEEE -Inf */
	neg_inf = f64(C.R_NegInf)
// LibExtern double R_NaReal;	/* NA_REAL: IEEE */
	na_real = f64(C.R_NaReal)
	na_f64  = na_real   // alias
// LibExtern int	 R_NaInt;	/* NA_INTEGER:= INT_MIN currently */
	na_int  = int(C.R_NaInt)
)

// int R_IsNA(double);		/* True for R's NA only */
fn C.R_IsNA(x f64) int
// int R_IsNaN(double);		/* True for special NaN, *not* for NA */
fn C.R_IsNaN(x f64) int
// int R_finite(double);		/* True if none of NA, NaN, +/-Inf */
fn C.R_finite(x f64) int

// #  define ISNAN(x)     (isnan(x)!=0)


////// #define R_EXT_BOOLEAN_H_

// typedef enum { FALSE = 0, TRUE /*, MAYBE */ } Rboolean;
[typedef]
struct C.Rboolean {}

// #endif /* R_EXT_BOOLEAN_H_ */


// #define R_COMPLEX_H

// typedef struct {
// 	double r;
// 	double i;
// } Rcomplex;
[typedef]
struct C.Rcomplex {
	r f64
	i f64
}

// #endif /* R_COMPLEX_H */

// #define R_ERROR_H_

// void NORET Rf_error(const char *, ...);
fn C.Rf_error(charptr, ...voidptr)
// void NORET UNIMPLEMENTED(const char *);
fn C.UNIMPLEMENTED(x charptr)
// void NORET WrongArgCount(const char *);

// void	Rf_warning(const char *, ...);
fn C.Rf_warning(x charptr, v ...charptr)
// void 	R_ShowMessage(const char *s);
fn C.R_ShowMessage(x charptr)
    
// #endif /* R_ERROR_H_ */


// #define R_EXT_MEMORY_H_

// # define R_SIZE_T size_t
[typedef]
struct C.R_SIZE_T {}


// void*	vmaxget(void);
fn C.vmaxget() voidptr
// void	vmaxset(const void *);
fn C.vmaxset(voidptr)

// void	R_gc(void);
fn C.R_gc()
// int	R_gc_running();
fn C.R_gc_running() int

// char*	R_alloc(R_SIZE_T, int);
fn C.R_alloc(s C.R_SIZE_T, l int)
// long double *R_allocLD(R_SIZE_T nelem);
fn C.R_allocLD(nelem C.R_SIZE_T) voidptr
// char*	S_alloc(long, int);
// char*	S_realloc(char *, long, long, int);

// void *  R_malloc_gc(size_t);
// void *  R_calloc_gc(size_t, size_t);
// void *  R_realloc_gc(void *, size_t);

// #ifdef  __cplusplus
// }
// #endif

// #endif /* R_EXT_MEMORY_H_ */

// #ifndef R_EXT_PRINT_H_
// #define R_EXT_PRINT_H_

// # define R_VA_LIST va_list

// void Rprintf(const char *, ...);
fn C.Rprintf(charptr, ...voidptr)
// void REprintf(const char *, ...);
fn C.REprintf(charptr, ...voidptr)
// void Rvprintf(const char *, R_VA_LIST);
// void REvprintf(const char *, R_VA_LIST);

// #endif /* R_EXT_PRINT_H_ */


// #define R_RANDOM_H

// typedef enum {
//     WICHMANN_HILL,
//     MARSAGLIA_MULTICARRY,
//     SUPER_DUPER,
//     MERSENNE_TWISTER,
//     KNUTH_TAOCP,
//     USER_UNIF,
//     KNUTH_TAOCP2,
//     LECUYER_CMRG
// } RNGtype;

// /* Different kinds of "N(0,1)" generators :*/
// typedef enum {
//     BUGGY_KINDERMAN_RAMAGE,
//     AHRENS_DIETER,
//     BOX_MULLER,
//     USER_NORM,
//     INVERSION,
//     KINDERMAN_RAMAGE
// } N01type;

// /* Different ways to generate discrete uniform samples */
// typedef enum {
//     ROUNDING,
//     REJECTION
// } Sampletype;
// Sampletype R_sample_kind();

// void GetRNGstate(void);
// void PutRNGstate(void);

// double unif_rand(void);
// double R_unif_index(double);
// /* These are also defined in Rmath.h */
// double norm_rand(void);
// double exp_rand(void);

// typedef unsigned int Int32;
// double * user_unif_rand(void);
// void user_unif_init(Int32);
// int * user_unif_nseed(void);
// int * user_unif_seedloc(void);

// double * user_norm_rand(void);

// #endif /* R_RANDOM_H */

//////// #define R_EXT_UTILS_H_

// /* ../../main/sort.c : */
// void	R_isort(int*, int);
// void	R_rsort(double*, int);
// void	R_csort(Rcomplex*, int);
// void    rsort_with_index(double *, int *, int);
// void	revsort(double*, int*, int);/* reverse; sort i[] alongside */
// void	iPsort(int*,    int, int);
// void	rPsort(double*, int, int);
// void	cPsort(Rcomplex*, int, int);

// /* ../../main/qsort.c : */
// /* dummy renamed to II to avoid problems with g++ on Solaris */
// void R_qsort    (double *v,         R_SIZE_T i, R_SIZE_T j);
// void R_qsort_I  (double *v, int *II, int i, int j);
// void R_qsort_int  (int *iv,         R_SIZE_T i, R_SIZE_T j);
// void R_qsort_int_I(int *iv, int *II, int i, int j);
// #ifdef R_RS_H
// void F77_NAME(qsort4)(double *v, int *indx, int *ii, int *jj);
// void F77_NAME(qsort3)(double *v,            int *ii, int *jj);
// #endif

// /* ../../main/util.c  and others : */
// const char *R_ExpandFileName(const char *);
// #ifdef Win32
// const char *R_ExpandFileNameUTF8(const char *);
// #endif
// void	setIVector(int*, int, int);
// void	setRVector(double*, int, double);
// Rboolean StringFalse(const char *);
// Rboolean StringTrue(const char *);
// Rboolean isBlankString(const char *);

// /* These two are guaranteed to use '.' as the decimal point,
//    and to accept "NA".
//  */
// double R_atof(const char *str);
// double R_strtod(const char *c, char **end);

// char *R_tmpnam(const char *prefix, const char *tempdir);
// char *R_tmpnam2(const char *prefix, const char *tempdir, const char *fileext);
// void R_free_tmpnam(char *name);

// void R_CheckUserInterrupt(void);
// void R_CheckStack(void);
// void R_CheckStack2(R_SIZE_T);


// /* ../../appl/interv.c: also in Applic.h */
// int findInterval(double *xt, int n, double x,
// 		 Rboolean rightmost_closed,  Rboolean all_inside, int ilo,
// 		 int *mflag);
// int findInterval2(double *xt, int n, double x,
// 		  Rboolean rightmost_closed,  Rboolean all_inside, Rboolean left_open,
// 		  int ilo, int *mflag);
// #ifdef R_RS_H
// int F77_SUB(interv)(double *xt, int *n, double *x,
// 		    Rboolean *rightmost_closed, Rboolean *all_inside,
// 		    int *ilo, int *mflag);
// #endif
// void find_interv_vec(double *xt, int *n,	double *x,   int *nx,
// 		     int *rightmost_closed, int *all_inside, int *indx);

// /* ../../appl/maxcol.c: also in Applic.h */
// void R_max_col(double *matrix, int *nr, int *nc, int *maxes, int *ties_meth);

// #endif /* R_EXT_UTILS_H_ */
