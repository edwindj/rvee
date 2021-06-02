module r

#include <R.h>
#include <Rinternals.h>

[typedef]
struct C.SEXP {}

[typedef]
struct C.R_xlen_t {}


// special values
pub const (
// /* Evaluation Environment */
// LibExtern SEXP	R_GlobalEnv;	    /* The "global" environment */
  global_env = C.SEXP(C.R_GlobalEnv)
// LibExtern SEXP  R_EmptyEnv;	    /* An empty environment at the root of the
// 				    	environment tree */
  empty_env  = C.SEXP(C.R_EmptyEnv)
// LibExtern SEXP  R_BaseEnv;	    /* The base environment; formerly R_NilValue */
// LibExtern SEXP	R_BaseNamespace;    /* The (fake) namespace for base */
// LibExtern SEXP	R_NamespaceRegistry;/* Registry for registered namespaces */

// LibExtern SEXP	R_Srcref;           /* Current srcref, for debuggers */

// /* Special Values */
// LibExtern SEXP	R_NilValue;	    /* The nil object */
  null_value = C.SEXP(C.R_NilValue)
// LibExtern SEXP	R_UnboundValue;	    /* Unbound marker */
// LibExtern SEXP	R_MissingArg;	    /* Missing argument marker */
// LibExtern SEXP	R_InBCInterpreter;  /* To be found in BC interp. state
// 				       (marker) */
// LibExtern SEXP	R_CurrentExpression; /* Use current expression (marker) */

/* Symbol Table Shortcuts */
// LibExtern SEXP	R_AsCharacterSymbol;/* "as.character" */
// LibExtern SEXP	R_baseSymbol; // <-- backcompatible version of:
// LibExtern SEXP	R_BaseSymbol;	// "base"
// LibExtern SEXP	R_BraceSymbol;	    /* "{" */
// LibExtern SEXP	R_Bracket2Symbol;   /* "[[" */
// LibExtern SEXP	R_BracketSymbol;    /* "[" */
// LibExtern SEXP	R_ClassSymbol;	    /* "class" */
// LibExtern SEXP	R_DeviceSymbol;	    /* ".Device" */
// LibExtern SEXP	R_DimNamesSymbol;   /* "dimnames" */
// LibExtern SEXP	R_DimSymbol;	    /* "dim" */
// LibExtern SEXP	R_DollarSymbol;	    /* "$" */
// LibExtern SEXP	R_DotsSymbol;	    /* "..." */
// LibExtern SEXP	R_DoubleColonSymbol;// "::"
// LibExtern SEXP	R_DropSymbol;	    /* "drop" */
// LibExtern SEXP	R_EvalSymbol;	    /* "eval" */
// LibExtern SEXP	R_LastvalueSymbol;  /* ".Last.value" */
// LibExtern SEXP	R_LevelsSymbol;	    /* "levels" */
// LibExtern SEXP	R_ModeSymbol;	    /* "mode" */
// LibExtern SEXP	R_NaRmSymbol;	    /* "na.rm" */
// LibExtern SEXP	R_NameSymbol;	    /* "name" */
// LibExtern SEXP	R_NamesSymbol;	    /* "names" */
// LibExtern SEXP	R_NamespaceEnvSymbol;// ".__NAMESPACE__."
// LibExtern SEXP	R_PackageSymbol;    /* "package" */
// LibExtern SEXP	R_PreviousSymbol;   /* "previous" */
// LibExtern SEXP	R_QuoteSymbol;	    /* "quote" */
// LibExtern SEXP	R_RowNamesSymbol;   /* "row.names" */
// LibExtern SEXP	R_SeedsSymbol;	    /* ".Random.seed" */
// LibExtern SEXP	R_SortListSymbol;   /* "sort.list" */
// LibExtern SEXP	R_SourceSymbol;	    /* "source" */
// LibExtern SEXP	R_SpecSymbol;	// "spec"
// LibExtern SEXP	R_TripleColonSymbol;// ":::"
// LibExtern SEXP	R_TspSymbol;	    /* "tsp" */

// LibExtern SEXP  R_dot_defined;      /* ".defined" */
// LibExtern SEXP  R_dot_Method;       /* ".Method" */
// LibExtern SEXP	R_dot_packageName;// ".packageName"
// LibExtern SEXP  R_dot_target;       /* ".target" */
// LibExtern SEXP  R_dot_Generic;      /* ".Generic" */

// /* Missing Values - others from Arith.h */
// #define NA_STRING	R_NaString
// LibExtern SEXP	R_NaString;	    /* NA_STRING as a CHARSXP */
na_string = C.SEXP(C.R_NaString)
// LibExtern SEXP	R_BlankString;	    /* "" as a CHARSXP */
blank_string = C.SEXP(C.R_BlankString)
// LibExtern SEXP	R_BlankScalarString;/* "" as a STRSXP */
blank_scalar_string = C.SEXP(C.R_BlankScalarString)
)

pub enum SEXPTYPE {
	nilsxp	= 0     /* nil = null */
    symsxp	= 1	    /* symbols */
    listsxp	= 2	    /* lists of dotted pairs */
    closxp	= 3	    /* closures */
    envsxp	= 4	    /* environments */
    promsxp	= 5	    /* promises: [un]evaluated closure arguments */
    langsxp	= 6	    /* language constructs (special lists) */
    specialsxp	= 7	/* special forms */
    builtinsxp	= 8	/* builtin non-special forms */
    charsxp	= 9	    /* "scalar" string type (internal only)*/
    lglsxp	= 10	/* logical vectors */
    intsxp	= 13	/* integer vectors */
    realsxp	= 14	/* real variables */
    cplxsxp	= 15	/* complex variables */
    strsxp	= 16	/* string vectors */
    dotsxp	= 17	/* dot-dot-dot object */
    anysxp	= 18	/* make "any" args work */
    vecsxp	= 19	/* generic vectors */
    exprsxp	= 20	/* expressions vectors */
    bcodesxp	= 21	/* byte code */
    extptrsxp	= 22	/* external pointer */
    weakrefsxp	= 23	/* weak reference */
    rawsxp	= 24	/* raw bytes */
    s4sxp	= 25	/* s4 non-vector */

    newsxp      = 30   /* fresh node creaed in new page */
    freesxp     = 31   /* node released by gc */

    funsxp	= 99	/* closure or builtin */
}

/* Vector Access Functions */
// int  (LENGTH)(SEXP x);
fn C.LENGTH(x C.SEXP) int
// R_xlen_t (XLENGTH)(SEXP x);
fn C.XLENGTH(x C.SEXP) C.R_xlen_t
// R_xlen_t  (TRUELENGTH)(SEXP x);
fn C.TRUELENGTH(x C.SEXP) C.R_xlen_t
// void (SETLENGTH)(SEXP x, R_xlen_t v);
fn C.SETLENGTH(x C.SEXP, v C.R_xlen_t)
// void (SET_TRUELENGTH)(SEXP x, R_xlen_t v);
fn C.SET_TRUELENGTH(x C.SEXP, v C.R_xlen_t)
// int  (IS_LONG_VEC)(SEXP x);
fn C.IS_LONG_VEC(x C.SEXP) int
// int  (LEVELS)(SEXP x);
fn C.LEVELS(x C.SEXP) int
// int  (SETLEVELS)(SEXP x, int v);
fn C.SETLEVELS(x C.SEXP, v int) int

// int  *(LOGICAL)(SEXP x);
fn C.LOGICAL(x C.SEXP) voidptr
// int  *(INTEGER)(SEXP x);
fn C.INTEGER(x C.SEXP) voidptr
// Rbyte *(RAW)(SEXP x);
// double *(REAL)(SEXP x);
fn C.REAL(x C.SEXP) voidptr
// Rcomplex *(COMPLEX)(SEXP x);
// const int  *(LOGICAL_RO)(SEXP x);
fn C.LOGICAL_RO(x C.SEXP) voidptr
// const int  *(INTEGER_RO)(SEXP x);
fn C.INTEGER_RO(x C.SEXP) voidptr
// const Rbyte *(RAW_RO)(SEXP x);
// const double *(REAL_RO)(SEXP x);
fn C.REAL_RO(x C.SEXP) voidptr
// const Rcomplex *(COMPLEX_RO)(SEXP x);
// //SEXP (STRING_ELT)(SEXP x, R_xlen_t i);
// SEXP (VECTOR_ELT)(SEXP x, R_xlen_t i);
fn C.VECTOR_ELT(x C.SEXP, i C.R_xlen_t) C.SEXP
// void SET_STRING_ELT(SEXP x, R_xlen_t i, SEXP v);
fn C.SET_STRING_ELT(x C.SEXP, i C.R_xlen_t, v C.SEXP)
// SEXP SET_VECTOR_ELT(SEXP x, R_xlen_t i, SEXP v);
fn C.SET_VECTOR_ELT(x C.SEXP, i C.R_xlen_t, v C.SEXP)
// SEXP *(STRING_PTR)(SEXP x);
fn C.STRING_PTR(x C.SEXP) &C.SEXP
// const SEXP *(STRING_PTR_RO)(SEXP x);
fn C.STRING_PTR_RO(x C.SEXP) &C.SEXP
// SEXP * NORET (VECTOR_PTR)(SEXP x);

// /* Type Coercions of all kinds */

// SEXP Rf_asChar(SEXP);
// SEXP Rf_coerceVector(SEXP, SEXPTYPE);
// SEXP Rf_PairToVectorList(SEXP x);
// SEXP Rf_VectorToPairList(SEXP x);
// SEXP Rf_asCharacterFactor(SEXP x);
// int Rf_asLogical(SEXP x);
// int Rf_asLogical2(SEXP x, int checking, SEXP call, SEXP rho);
// int Rf_asInteger(SEXP x);
// double Rf_asReal(SEXP x);
// Rcomplex Rf_asComplex(SEXP x);


/* Other Internally Used Functions, excluding those which are inline-able*/

// char * Rf_acopy_string(const char *);
// void Rf_addMissingVarsToNewEnv(SEXP, SEXP);
// SEXP Rf_alloc3DArray(SEXPTYPE, int, int, int);
// SEXP Rf_allocArray(SEXPTYPE, SEXP);
// SEXP Rf_allocFormalsList2(SEXP sym1, SEXP sym2);
// SEXP Rf_allocFormalsList3(SEXP sym1, SEXP sym2, SEXP sym3);
// SEXP Rf_allocFormalsList4(SEXP sym1, SEXP sym2, SEXP sym3, SEXP sym4);
// SEXP Rf_allocFormalsList5(SEXP sym1, SEXP sym2, SEXP sym3, SEXP sym4, SEXP sym5);
// SEXP Rf_allocFormalsList6(SEXP sym1, SEXP sym2, SEXP sym3, SEXP sym4, SEXP sym5, SEXP sym6);
// SEXP Rf_allocMatrix(SEXPTYPE, int, int);
// SEXP Rf_allocList(int);
// SEXP Rf_allocS4Object(void);
// SEXP Rf_allocSExp(SEXPTYPE);
// SEXP Rf_allocVector3(SEXPTYPE, R_xlen_t, R_allocator_t*);
// R_xlen_t Rf_any_duplicated(SEXP x, Rboolean from_last);
// R_xlen_t Rf_any_duplicated3(SEXP x, SEXP incomp, Rboolean from_last);
// SEXP Rf_applyClosure(SEXP, SEXP, SEXP, SEXP, SEXP);
// SEXP Rf_arraySubscript(int, SEXP, SEXP, SEXP (*)(SEXP,SEXP),
//                        SEXP (*)(SEXP, int), SEXP);
// SEXP Rf_classgets(SEXP, SEXP);
// SEXP Rf_cons(SEXP, SEXP);
// SEXP Rf_fixSubset3Args(SEXP, SEXP, SEXP, SEXP*);
// void Rf_copyMatrix(SEXP, SEXP, Rboolean);
// void Rf_copyListMatrix(SEXP, SEXP, Rboolean);
// void Rf_copyMostAttrib(SEXP, SEXP);
// void Rf_copyVector(SEXP, SEXP);
// int Rf_countContexts(int, int);
// SEXP Rf_CreateTag(SEXP);
// void Rf_defineVar(SEXP, SEXP, SEXP);
// SEXP Rf_dimgets(SEXP, SEXP);
// SEXP Rf_dimnamesgets(SEXP, SEXP);
// SEXP Rf_DropDims(SEXP);
// SEXP Rf_duplicate(SEXP);
// SEXP Rf_shallow_duplicate(SEXP);
// SEXP R_duplicate_attr(SEXP);
// SEXP R_shallow_duplicate_attr(SEXP);
// SEXP Rf_lazy_duplicate(SEXP);
// /* the next really should not be here and is also in Defn.h */
// SEXP Rf_duplicated(SEXP, Rboolean);
// Rboolean R_envHasNoSpecialSymbols(SEXP);
// SEXP Rf_eval(SEXP, SEXP);
// SEXP Rf_ExtractSubset(SEXP, SEXP, SEXP);
// SEXP Rf_findFun(SEXP, SEXP);
// SEXP Rf_findFun3(SEXP, SEXP, SEXP);
// void Rf_findFunctionForBody(SEXP);
// SEXP Rf_findVar(SEXP, SEXP);
// SEXP Rf_findVarInFrame(SEXP, SEXP);
// SEXP Rf_findVarInFrame3(SEXP, SEXP, Rboolean);
// void R_removeVarFromFrame(SEXP, SEXP);
// SEXP Rf_getAttrib(SEXP, SEXP);
// SEXP Rf_GetArrayDimnames(SEXP);
// SEXP Rf_GetColNames(SEXP);
// void Rf_GetMatrixDimnames(SEXP, SEXP*, SEXP*, const char**, const char**);
// SEXP Rf_GetOption(SEXP, SEXP); /* pre-2.13.0 compatibility */
// SEXP Rf_GetOption1(SEXP);
// int Rf_FixupDigits(SEXP, warn_type);
// int Rf_FixupWidth (SEXP, warn_type);
// int Rf_GetOptionDigits(void);
// int Rf_GetOptionWidth(void);
// SEXP Rf_GetRowNames(SEXP);
// void Rf_gsetVar(SEXP, SEXP, SEXP);
// SEXP Rf_install(const char *);
// SEXP Rf_installChar(SEXP);
// SEXP Rf_installNoTrChar(SEXP);
// SEXP Rf_installTrChar(SEXP);
// SEXP Rf_installDDVAL(int i);
// SEXP Rf_installS3Signature(const char *, const char *);
// Rboolean Rf_isFree(SEXP);
// Rboolean Rf_isOrdered(SEXP);
// Rboolean Rf_isUnmodifiedSpecSym(SEXP sym, SEXP env);
// Rboolean Rf_isUnordered(SEXP);
// Rboolean Rf_isUnsorted(SEXP, Rboolean);
// SEXP Rf_lengthgets(SEXP, R_len_t);
// SEXP Rf_xlengthgets(SEXP, R_xlen_t);
// SEXP R_lsInternal(SEXP, Rboolean);
// SEXP R_lsInternal3(SEXP, Rboolean, Rboolean);
// SEXP Rf_match(SEXP, SEXP, int);
// SEXP Rf_matchE(SEXP, SEXP, int, SEXP);
// SEXP Rf_namesgets(SEXP, SEXP);
// SEXP Rf_mkChar(const char *);
fn C.Rf_mkChar(s charptr) C.SEXP
// SEXP Rf_mkCharLen(const char *, int);
fn C.Rf_mkCharLen(s charptr, len int) C.SEXP
// Rboolean Rf_NonNullStringMatch(SEXP, SEXP);
// int Rf_ncols(SEXP);
// int Rf_nrows(SEXP);
// SEXP Rf_nthcdr(SEXP, int);


// inlinable functions

// SEXP     Rf_allocVector(SEXPTYPE, R_xlen_t);
fn C.Rf_allocVector(st SEXPTYPE, len C.R_xlen_t) C.SEXP
// Rboolean Rf_conformable(SEXP, SEXP);
// SEXP	 Rf_elt(SEXP, int);
// Rboolean Rf_inherits(SEXP, const char *);
// Rboolean Rf_isArray(SEXP);
// Rboolean Rf_isFactor(SEXP);
// Rboolean Rf_isFrame(SEXP);
// Rboolean Rf_isFunction(SEXP);
// Rboolean Rf_isInteger(SEXP);
// Rboolean Rf_isLanguage(SEXP);
// Rboolean Rf_isList(SEXP);
// Rboolean Rf_isMatrix(SEXP);
// Rboolean Rf_isNewList(SEXP);
// Rboolean Rf_isNumber(SEXP);
// Rboolean Rf_isNumeric(SEXP);
// Rboolean Rf_isPairList(SEXP);
// Rboolean Rf_isPrimitive(SEXP);
// Rboolean Rf_isTs(SEXP);
// Rboolean Rf_isUserBinop(SEXP);
// Rboolean Rf_isValidString(SEXP);
// Rboolean Rf_isValidStringF(SEXP);
// Rboolean Rf_isVector(SEXP);
// Rboolean Rf_isVectorAtomic(SEXP);
// Rboolean Rf_isVectorList(SEXP);
// Rboolean Rf_isVectorizable(SEXP);
// SEXP	 Rf_lang1(SEXP);
// SEXP	 Rf_lang2(SEXP, SEXP);
// SEXP	 Rf_lang3(SEXP, SEXP, SEXP);
// SEXP	 Rf_lang4(SEXP, SEXP, SEXP, SEXP);
// SEXP	 Rf_lang5(SEXP, SEXP, SEXP, SEXP, SEXP);
// SEXP	 Rf_lang6(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
// SEXP	 Rf_lastElt(SEXP);
// SEXP	 Rf_lcons(SEXP, SEXP);
// R_len_t  Rf_length(SEXP);
// SEXP	 Rf_list1(SEXP);
// SEXP	 Rf_list2(SEXP, SEXP);
// SEXP	 Rf_list3(SEXP, SEXP, SEXP);
// SEXP	 Rf_list4(SEXP, SEXP, SEXP, SEXP);
// SEXP	 Rf_list5(SEXP, SEXP, SEXP, SEXP, SEXP);
// SEXP	 Rf_list6(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
// SEXP	 Rf_listAppend(SEXP, SEXP);
// SEXP	 Rf_mkNamed(SEXPTYPE, const char **);
fn C.Rf_mkNamed(st SEXPTYPE, names &charptr) C.SEXP
// SEXP	 Rf_mkString(const char *);
fn C.Rf_mkString(s charptr) C.SEXP
// int	 Rf_nlevels(SEXP);
// int	 Rf_stringPositionTr(SEXP, const char *);
// SEXP	 Rf_ScalarComplex(Rcomplex);
// SEXP	 Rf_ScalarInteger(int);
fn C.Rf_ScalarInteger(x int) C.SEXP
// SEXP	 Rf_ScalarLogical(int);
fn C.Rf_ScalarLogical(x int) C.SEXP
// SEXP	 Rf_ScalarRaw(Rbyte);
// SEXP	 Rf_ScalarReal(double);
fn C.Rf_ScalarReal(x f64) C.SEXP
// SEXP	 Rf_ScalarString(SEXP);
fn C.Rf_ScalarString(x C.SEXP) C.SEXP
// R_xlen_t  Rf_xlength(SEXP);
// R_xlen_t  (XLENGTH)(SEXP x);
// R_xlen_t  (XTRUELENGTH)(SEXP x);
// int LENGTH_EX(SEXP x, const char *file, int line);
// R_xlen_t XLENGTH_EX(SEXP x);
// # ifdef INLINE_PROTECT
// SEXP Rf_protect(SEXP);
fn C.Rf_protect(x C.SEXP) C.SEXP
// void Rf_unprotect(int);
fn C.Rf_unprotect(n int)
// void R_ProtectWithIndex(SEXP, PROTECT_INDEX *);
// void R_Reprotect(SEXP, PROTECT_INDEX);
// # endif
// SEXP R_FixupRHS(SEXP x, SEXP y);
// SEXP (CAR)(SEXP e);
// void *(DATAPTR)(SEXP x);
// const void *(DATAPTR_RO)(SEXP x);
// const void *(DATAPTR_OR_NULL)(SEXP x);
// const int *(LOGICAL_OR_NULL)(SEXP x);
// const int *(INTEGER_OR_NULL)(SEXP x);
// const double *(REAL_OR_NULL)(SEXP x);
// const Rcomplex *(COMPLEX_OR_NULL)(SEXP x);
// const Rbyte *(RAW_OR_NULL)(SEXP x);
// void *(STDVEC_DATAPTR)(SEXP x);
// int (INTEGER_ELT)(SEXP x, R_xlen_t i);
// double (REAL_ELT)(SEXP x, R_xlen_t i);
// int (LOGICAL_ELT)(SEXP x, R_xlen_t i);
// Rcomplex (COMPLEX_ELT)(SEXP x, R_xlen_t i);
// Rbyte (RAW_ELT)(SEXP x, R_xlen_t i);
// SEXP (STRING_ELT)(SEXP x, R_xlen_t i);
// double SCALAR_DVAL(SEXP x);
fn C.SCALAR_DVAL(x C.SEXP) f64
// int SCALAR_LVAL(SEXP x);
fn C.SCALAR_LVAL(x C.SEXP) int
// int SCALAR_IVAL(SEXP x);
fn C.SCALAR_IVAL(x C.SEXP) int
// void SET_SCALAR_DVAL(SEXP x, double v);
// void SET_SCALAR_LVAL(SEXP x, int v);
// void SET_SCALAR_IVAL(SEXP x, int v);
// void SET_SCALAR_CVAL(SEXP x, Rcomplex v);
// void SET_SCALAR_BVAL(SEXP x, Rbyte v);
// SEXP R_altrep_data1(SEXP x);
// SEXP R_altrep_data2(SEXP x);
// void R_set_altrep_data1(SEXP x, SEXP v);
// void R_set_altrep_data2(SEXP x, SEXP v);
// SEXP ALTREP_CLASS(SEXP x);
// int *LOGICAL0(SEXP x);
// int *INTEGER0(SEXP x);
// double *REAL0(SEXP x);
// Rcomplex *COMPLEX0(SEXP x);
// Rbyte *RAW0(SEXP x);
// void SET_LOGICAL_ELT(SEXP x, R_xlen_t i, int v);
// void SET_INTEGER_ELT(SEXP x, R_xlen_t i, int v);
// void SET_REAL_ELT(SEXP x, R_xlen_t i, double v);


// typedef enum {
//     CE_NATIVE = 0,
//     CE_UTF8   = 1,
//     CE_LATIN1 = 2,
//     CE_BYTES  = 3,
//     CE_SYMBOL = 5,
//     CE_ANY    =99
// } cetype_t;

// Content encoding
pub enum CE {
    native = 0
    utf8   = 1
    latin1 = 2
    bytes  = 3
    symbol = 5
    any    = 99
}

[typedef]
struct C.cetype_t {}
// cetype_t Rf_getCharCE(SEXP);
fn C.Rf_getCharCE(x C.SEXP) C.cetype_t
// SEXP Rf_mkCharCE(const char *, cetype_t);
fn C.Rf_mkCharCE(x charptr, ce C.cetype_t) C.SEXP
// SEXP Rf_mkCharLenCE(const char *, int, cetype_t);
fn C.Rf_mkCharLenCE(x charptr, len int, ce C.cetype_t) C.SEXP
// const char *Rf_reEnc(const char *x, cetype_t ce_in, cetype_t ce_out, int subst);
