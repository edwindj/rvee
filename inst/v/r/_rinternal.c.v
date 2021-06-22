module r

#include <Rinternals.h>

// typedef unsigned char Rbyte;
[typedef]
struct C.Rbyte {} // map to v type

// /* type for length of (standard, not long) vectors etc */
// typedef int R_xlen_t; (can be int or int64)

[typedef]
struct C.R_xlen_t {}

// /* Fundamental Data Types:  These are largely Lisp
//  * influenced structures, with the exception of LGLSXP,
//  * INTSXP, REALSXP, CPLXSXP and STRSXP which are the
//  * element types for S-like data objects.
//  *
//  *			--> TypeTable[] in ../main/util.c for  typeof()
//  */

// /* UUID identifying the internals version -- packages using compiled
//    code should be re-installed when this changes */
// #define R_INTERNALS_UUID "2fdf6c18-697a-4ba7-b8ef-11c0d92f1327"

// /*  These exact numeric values are seldom used, but they are, e.g., in
//  *  ../main/subassign.c, and they are serialized.
// */
// #ifndef enum_SEXPTYPE
// /* NOT YET using enum:
//  *  1)	The SEXPREC struct below has 'SEXPTYPE type : 5'
//  *	(making FUNSXP and CLOSXP equivalent in there),
//  *	giving (-Wall only ?) warnings all over the place
//  * 2)	Many switch(type) { case ... } statements need a final `default:'
//  *	added in order to avoid warnings like [e.g. l.170 of ../main/util.c]
//  *	  "enumeration value `FUNSXP' not handled in switch"
//  */
enum SexpType {
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

// typedef struct SEXPREC *SEXP;
[typedef]
struct C.SEXP {}

// // ======================= not USE_RINTERNALS section
// #define CHAR(x)		R_CHAR(x)
// const char *(R_CHAR)(SEXP x);
fn C.R_CHAR(x C.SEXP) charptr

// /* Various tests with macro versions in the second USE_RINTERNALS section */
// Rboolean (Rf_isNull)(SEXP s);
// Rboolean (Rf_isSymbol)(SEXP s);
// Rboolean (Rf_isLogical)(SEXP s);
// Rboolean (Rf_isReal)(SEXP s);
// Rboolean (Rf_isComplex)(SEXP s);
// Rboolean (Rf_isExpression)(SEXP s);
// Rboolean (Rf_isEnvironment)(SEXP s);
// Rboolean (Rf_isString)(SEXP s);
// Rboolean (Rf_isObject)(SEXP s);

// /* ALTREP sorting support */
// enum {SORTED_DECR_NA_1ST = -2,
//       SORTED_DECR = -1,
//       UNKNOWN_SORTEDNESS = INT_MIN, /*INT_MIN is NA_INTEGER! */
//       SORTED_INCR = 1,
//       SORTED_INCR_NA_1ST = 2,
//       KNOWN_UNSORTED = 0};

// /* General Cons Cell Attributes */
// SEXP (ATTRIB)(SEXP x);
// int  (OBJECT)(SEXP x);
// int  (MARK)(SEXP x);
// int  (TYPEOF)(SEXP x);
// int  (NAMED)(SEXP x);
// int  (REFCNT)(SEXP x);
// int  (TRACKREFS)(SEXP x);
// void (SET_OBJECT)(SEXP x, int v);
// void (SET_TYPEOF)(SEXP x, int v);
// void (SET_NAMED)(SEXP x, int v);
// void SET_ATTRIB(SEXP x, SEXP v);
// void DUPLICATE_ATTRIB(SEXP to, SEXP from);
// void SHALLOW_DUPLICATE_ATTRIB(SEXP to, SEXP from);
// void (ENSURE_NAMEDMAX)(SEXP x);
// void (ENSURE_NAMED)(SEXP x);
// void (SETTER_CLEAR_NAMED)(SEXP x);
// void (RAISE_NAMED)(SEXP x, int n);
// void (DECREMENT_REFCNT)(SEXP x);
// void (INCREMENT_REFCNT)(SEXP x);
// void (DISABLE_REFCNT)(SEXP x);
// void (ENABLE_REFCNT)(SEXP x);
// void (MARK_NOT_MUTABLE)(SEXP x);

// int (ASSIGNMENT_PENDING)(SEXP x);
// void (SET_ASSIGNMENT_PENDING)(SEXP x, int v);
// int (IS_ASSIGNMENT_CALL)(SEXP x);
// void (MARK_ASSIGNMENT_CALL)(SEXP x);

// /* S4 object testing */
// int (IS_S4_OBJECT)(SEXP x);
// void (SET_S4_OBJECT)(SEXP x);
// void (UNSET_S4_OBJECT)(SEXP x);

// /* JIT optimization support */
// int (NOJIT)(SEXP x);
// int (MAYBEJIT)(SEXP x);
// void (SET_NOJIT)(SEXP x);
// void (SET_MAYBEJIT)(SEXP x);
// void (UNSET_MAYBEJIT)(SEXP x);

// /* Growable vector support */
// int (IS_GROWABLE)(SEXP x);
// void (SET_GROWABLE_BIT)(SEXP x);

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
// #ifdef TESTING_WRITE_BARRIER
// R_xlen_t (STDVEC_LENGTH)(SEXP);
// R_xlen_t (STDVEC_TRUELENGTH)(SEXP);
// void (SETALTREP)(SEXP, int);
// #endif

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
fn C.STRING_ELT(x C.SEXP, i C.R_xlen_t) C.SEXP
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

// /* ALTREP support */
// void *(STDVEC_DATAPTR)(SEXP x);
// int (IS_SCALAR)(SEXP x, int type);
// int (ALTREP)(SEXP x);
// SEXP ALTREP_DUPLICATE_EX(SEXP x, Rboolean deep);
// SEXP ALTREP_COERCE(SEXP x, int type);
// Rboolean ALTREP_INSPECT(SEXP, int, int, int, void (*)(SEXP, int, int, int));
// SEXP ALTREP_SERIALIZED_CLASS(SEXP);
// SEXP ALTREP_SERIALIZED_STATE(SEXP);
// SEXP ALTREP_UNSERIALIZE_EX(SEXP, SEXP, SEXP, int, int);
// R_xlen_t ALTREP_LENGTH(SEXP x);
// R_xlen_t ALTREP_TRUELENGTH(SEXP x);
// void *ALTVEC_DATAPTR(SEXP x);
// const void *ALTVEC_DATAPTR_RO(SEXP x);
// const void *ALTVEC_DATAPTR_OR_NULL(SEXP x);
// SEXP ALTVEC_EXTRACT_SUBSET(SEXP x, SEXP indx, SEXP call);

// /* data access */
// int ALTINTEGER_ELT(SEXP x, R_xlen_t i);
// void ALTINTEGER_SET_ELT(SEXP x, R_xlen_t i, int v);
// int ALTLOGICAL_ELT(SEXP x, R_xlen_t i);
// void ALTLOGICAL_SET_ELT(SEXP x, R_xlen_t i, int v);
// double ALTREAL_ELT(SEXP x, R_xlen_t i);
// void ALTREAL_SET_ELT(SEXP x, R_xlen_t i, double v);
// SEXP ALTSTRING_ELT(SEXP, R_xlen_t);
// void ALTSTRING_SET_ELT(SEXP, R_xlen_t, SEXP);
// Rcomplex ALTCOMPLEX_ELT(SEXP x, R_xlen_t i);
// void ALTCOMPLEX_SET_ELT(SEXP x, R_xlen_t i, Rcomplex v);
// Rbyte ALTRAW_ELT(SEXP x, R_xlen_t i);
// void ALTRAW_SET_ELT(SEXP x, R_xlen_t i, Rbyte v);

// R_xlen_t INTEGER_GET_REGION(SEXP sx, R_xlen_t i, R_xlen_t n, int *buf);
// R_xlen_t REAL_GET_REGION(SEXP sx, R_xlen_t i, R_xlen_t n, double *buf);
// R_xlen_t LOGICAL_GET_REGION(SEXP sx, R_xlen_t i, R_xlen_t n, int *buf);
// R_xlen_t COMPLEX_GET_REGION(SEXP sx, R_xlen_t i, R_xlen_t n, Rcomplex *buf);
// R_xlen_t RAW_GET_REGION(SEXP sx, R_xlen_t i, R_xlen_t n, Rbyte *buf);

// /* metadata access */
// int INTEGER_IS_SORTED(SEXP x);
// int INTEGER_NO_NA(SEXP x);
// int REAL_IS_SORTED(SEXP x);
// int REAL_NO_NA(SEXP x);
// int LOGICAL_IS_SORTED(SEXP x);
// int LOGICAL_NO_NA(SEXP x);
// int STRING_IS_SORTED(SEXP x);
// int STRING_NO_NA(SEXP x);

// /* invoking ALTREP class methods */
// SEXP ALTINTEGER_SUM(SEXP x, Rboolean narm);
// SEXP ALTINTEGER_MIN(SEXP x, Rboolean narm);
// SEXP ALTINTEGER_MAX(SEXP x, Rboolean narm);
// SEXP INTEGER_MATCH(SEXP, SEXP, int, SEXP, SEXP, Rboolean);
// SEXP INTEGER_IS_NA(SEXP x);
// SEXP ALTREAL_SUM(SEXP x, Rboolean narm);
// SEXP ALTREAL_MIN(SEXP x, Rboolean narm);
// SEXP ALTREAL_MAX(SEXP x, Rboolean narm);
// SEXP REAL_MATCH(SEXP, SEXP, int, SEXP, SEXP, Rboolean);
// SEXP REAL_IS_NA(SEXP x);
// SEXP ALTLOGICAL_SUM(SEXP x, Rboolean narm);

// /* constructors for internal ALTREP classes */
// SEXP R_compact_intrange(R_xlen_t n1, R_xlen_t n2);
// SEXP R_deferred_coerceToString(SEXP v, SEXP info);
// SEXP R_virtrep_vec(SEXP, SEXP);
// SEXP R_tryWrap(SEXP);
// SEXP R_tryUnwrap(SEXP);

// #ifdef LONG_VECTOR_SUPPORT
//     R_len_t NORET R_BadLongVector(SEXP, const char *, int);
// #endif

// /* checking for mis-use of multi-threading */
// #ifdef TESTING_WRITE_BARRIER
// # define THREADCHECK
// #endif
// #ifdef THREADCHECK
// void R_check_thread(const char *s);
// # define R_CHECK_THREAD R_check_thread(__func__)
// #else
// # define R_CHECK_THREAD do {} while (0)
// #endif

// /* List Access Functions */
// /* These also work for ... objects */
// #define CONS(a, b)	cons((a), (b))		/* data lists */
// #define LCONS(a, b)	lcons((a), (b))		/* language lists */
// int (BNDCELL_TAG)(SEXP e);
// void (SET_BNDCELL_TAG)(SEXP e, int v);
// double (BNDCELL_DVAL)(SEXP cell);
// int (BNDCELL_IVAL)(SEXP cell);
// int (BNDCELL_LVAL)(SEXP cell);
// void (SET_BNDCELL_DVAL)(SEXP cell, double v);
// void (SET_BNDCELL_IVAL)(SEXP cell, int v);
// void (SET_BNDCELL_LVAL)(SEXP cell, int v);
// void (INIT_BNDCELL)(SEXP cell, int type);
// void SET_BNDCELL(SEXP cell, SEXP val);

// SEXP (TAG)(SEXP e);
// SEXP (CAR0)(SEXP e);
// SEXP (CDR)(SEXP e);
// SEXP (CAAR)(SEXP e);
// SEXP (CDAR)(SEXP e);
// SEXP (CADR)(SEXP e);
// SEXP (CDDR)(SEXP e);
// SEXP (CDDDR)(SEXP e);
// SEXP (CADDR)(SEXP e);
// SEXP (CADDDR)(SEXP e);
// SEXP (CAD4R)(SEXP e);
// int  (MISSING)(SEXP x);
// void (SET_MISSING)(SEXP x, int v);
// void SET_TAG(SEXP x, SEXP y);
// SEXP SETCAR(SEXP x, SEXP y);
// SEXP SETCDR(SEXP x, SEXP y);
// SEXP SETCADR(SEXP x, SEXP y);
// SEXP SETCADDR(SEXP x, SEXP y);
// SEXP SETCADDDR(SEXP x, SEXP y);
// SEXP SETCAD4R(SEXP e, SEXP y);
// void *(EXTPTR_PTR)(SEXP);

// SEXP CONS_NR(SEXP a, SEXP b);

// /* Closure Access Functions */
// SEXP (FORMALS)(SEXP x);
// SEXP (BODY)(SEXP x);
// SEXP (CLOENV)(SEXP x);
// int  (RDEBUG)(SEXP x);
// int  (RSTEP)(SEXP x);
// int  (RTRACE)(SEXP x);
// void (SET_RDEBUG)(SEXP x, int v);
// void (SET_RSTEP)(SEXP x, int v);
// void (SET_RTRACE)(SEXP x, int v);
// void SET_FORMALS(SEXP x, SEXP v);
// void SET_BODY(SEXP x, SEXP v);
// void SET_CLOENV(SEXP x, SEXP v);

// /* Symbol Access Functions */
// SEXP (PRINTNAME)(SEXP x);
// SEXP (SYMVALUE)(SEXP x);
// SEXP (INTERNAL)(SEXP x);
// int  (DDVAL)(SEXP x);
// void (SET_DDVAL)(SEXP x, int v);
// void SET_PRINTNAME(SEXP x, SEXP v);
// void SET_SYMVALUE(SEXP x, SEXP v);
// void SET_INTERNAL(SEXP x, SEXP v);

// /* Environment Access Functions */
// SEXP (FRAME)(SEXP x);
// SEXP (ENCLOS)(SEXP x);
// SEXP (HASHTAB)(SEXP x);
// int  (ENVFLAGS)(SEXP x);
// void (SET_ENVFLAGS)(SEXP x, int v);
// void SET_FRAME(SEXP x, SEXP v);
// void SET_ENCLOS(SEXP x, SEXP v);
// void SET_HASHTAB(SEXP x, SEXP v);

// /* Promise Access Functions */
// /* First five have macro versions in Defn.h */
// SEXP (PRCODE)(SEXP x);
// SEXP (PRENV)(SEXP x);
// SEXP (PRVALUE)(SEXP x);
// int  (PRSEEN)(SEXP x);
// void (SET_PRSEEN)(SEXP x, int v);
// void SET_PRENV(SEXP x, SEXP v);
// void SET_PRVALUE(SEXP x, SEXP v);
// void SET_PRCODE(SEXP x, SEXP v);
// void SET_PRSEEN(SEXP x, int v);

// /* Hashing Functions */
// /* There are macro versions in Defn.h */
// int  (HASHASH)(SEXP x);
// int  (HASHVALUE)(SEXP x);
// void (SET_HASHASH)(SEXP x, int v);
// void (SET_HASHVALUE)(SEXP x, int v);

// /* We sometimes need to coerce a protected value and place the new
//    coerced value under protection.  For these cases PROTECT_WITH_INDEX
//    saves an index of the protection location that can be used to
//    replace the protected value using REPROTECT. */
// typedef int PROTECT_INDEX;

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
  nil_value  = C.SEXP(C.R_NilValue)
  null_value = nil_value  // alias

// LibExtern SEXP	R_UnboundValue;	    /* Unbound marker */
// LibExtern SEXP	R_MissingArg;	    /* Missing argument marker */
// LibExtern SEXP	R_InBCInterpreter;  /* To be found in BC interp. state
// 				       (marker) */
// LibExtern SEXP	R_CurrentExpression; /* Use current expression (marker) */
// #ifdef __MAIN__
// attribute_hidden
// #else
// extern
// #endif
// SEXP	R_RestartToken;     /* Marker for restarted function calls */

// /* Symbol Table Shortcuts */
// LibExtern SEXP	R_AsCharacterSymbol;/* "as.character" */
// LibExtern SEXP	R_baseSymbol; // <-- backcompatible version of:
// LibExtern SEXP	R_BaseSymbol;	// "base"
// LibExtern SEXP	R_BraceSymbol;	    /* "{" */
// LibExtern SEXP	R_Bracket2Symbol;   /* "[[" */
// LibExtern SEXP	R_BracketSymbol;    /* "[" */
// LibExtern SEXP	R_ClassSymbol;	    /* "class" */
class_symbol = C.SEXP(C.R_ClassSymbol)
// LibExtern SEXP	R_DeviceSymbol;	    /* ".Device" */
// LibExtern SEXP	R_DimNamesSymbol;   /* "dimnames" */
// LibExtern SEXP	R_DimSymbol;	    /* "dim" */
// LibExtern SEXP	R_DollarSymbol;	    /* "$" */
dollar_symbol = C.SEXP(C.R_DollarSymbol)
// LibExtern SEXP	R_DotsSymbol;	    /* "..." */
// LibExtern SEXP	R_DoubleColonSymbol;// "::"
// LibExtern SEXP	R_DropSymbol;	    /* "drop" */
// LibExtern SEXP	R_EvalSymbol;	    /* "eval" */
eval_symbol = C.SEXP(C.R_EvalSymbol)
// LibExtern SEXP	R_LastvalueSymbol;  /* ".Last.value" */
// LibExtern SEXP	R_LevelsSymbol;	    /* "levels" */
levels_symbol = C.SEXP(C.R_LevelsSymbol)
// LibExtern SEXP	R_ModeSymbol;	    /* "mode" */
// LibExtern SEXP	R_NaRmSymbol;	    /* "na.rm" */
na_rm_symbol = C.SEXP(C.R_NaRmSymbol)
// LibExtern SEXP	R_NameSymbol;	    /* "name" */
// LibExtern SEXP	R_NamesSymbol;	    /* "names" */
names_symbol = C.SEXP(C.R_NamesSymbol)
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
// /* srcref related functions */
// SEXP R_GetCurrentSrcref(int);
// SEXP R_GetSrcFilename(SEXP);

// /*--- FUNCTIONS ------------------------------------------------------ */

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


// #ifndef R_ALLOCATOR_TYPE
// #define R_ALLOCATOR_TYPE
// typedef struct R_allocator R_allocator_t;
// #endif

// typedef enum { iSILENT, iWARN, iERROR } warn_type;


// /* Other Internally Used Functions, excluding those which are inline-able*/

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
fn C.Rf_getAttrib(C.SEXP, C.SEXP) C.SEXP
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

// // ../main/character.c :
// typedef enum {Bytes, Chars, Width} nchar_type;
// int R_nchar(SEXP string, nchar_type type_,
// 	    Rboolean allowNA, Rboolean keepNA, const char* msg_name);

// Rboolean Rf_pmatch(SEXP, SEXP, Rboolean);
// Rboolean Rf_psmatch(const char *, const char *, Rboolean);
// SEXP R_ParseEvalString(const char *, SEXP);
// void Rf_PrintValue(SEXP);
// void Rf_printwhere(void);
// #ifndef INLINE_PROTECT
// SEXP Rf_protect(SEXP);
// #endif
// void Rf_readS3VarsFromFrame(SEXP, SEXP*, SEXP*, SEXP*, SEXP*, SEXP*, SEXP*);
// SEXP Rf_setAttrib(SEXP, SEXP, SEXP);
// void Rf_setSVector(SEXP*, int, SEXP);
// void Rf_setVar(SEXP, SEXP, SEXP);
// SEXP Rf_stringSuffix(SEXP, int);
// SEXPTYPE Rf_str2type(const char *);
// Rboolean Rf_StringBlank(SEXP);
// SEXP Rf_substitute(SEXP,SEXP);
// SEXP Rf_topenv(SEXP, SEXP);
// const char * Rf_translateChar(SEXP);
// const char * Rf_translateChar0(SEXP);
// const char * Rf_translateCharUTF8(SEXP);
// const char * Rf_type2char(SEXPTYPE);
// SEXP Rf_type2rstr(SEXPTYPE);
// SEXP Rf_type2str(SEXPTYPE);
// SEXP Rf_type2str_nowarn(SEXPTYPE);
// #ifndef INLINE_PROTECT
// void Rf_unprotect(int);
// #endif
// void Rf_unprotect_ptr(SEXP);

// void NORET R_signal_protect_error(void);
// void NORET R_signal_unprotect_error(void);
// void NORET R_signal_reprotect_error(PROTECT_INDEX i);

// #ifndef INLINE_PROTECT
// void R_ProtectWithIndex(SEXP, PROTECT_INDEX *);
// void R_Reprotect(SEXP, PROTECT_INDEX);
// #endif
// SEXP R_tryEval(SEXP, SEXP, int *);
// SEXP R_tryEvalSilent(SEXP, SEXP, int *);
// SEXP R_GetCurrentEnv();
// const char *R_curErrorBuf();

// Rboolean Rf_isS4(SEXP);
// SEXP Rf_asS4(SEXP, Rboolean, int);
// SEXP Rf_S3Class(SEXP);
// int Rf_isBasicClass(const char *);

// Rboolean R_cycle_detected(SEXP s, SEXP child);

// /* cetype_t is an identifier reseved by POSIX, but it is
//    well established as public.  Could remap by a #define though */
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

// 				/* match(.) NOT reached : for -Wall */
// #define error_return(msg)	{ Rf_error(msg);	   return R_NilValue; }
// #define errorcall_return(cl,msg){ Rf_errorcall(cl, msg);   return R_NilValue; }

// #ifdef __MAIN__
// #undef extern
// #undef LibExtern
// #endif

// /* Calling a function with arguments evaluated */
// SEXP R_forceAndCall(SEXP e, int n, SEXP rho);

// /* External pointer interface */
// SEXP R_MakeExternalPtr(void *p, SEXP tag, SEXP prot);
// void *R_ExternalPtrAddr(SEXP s);
// SEXP R_ExternalPtrTag(SEXP s);
// SEXP R_ExternalPtrProtected(SEXP s);
// void R_ClearExternalPtr(SEXP s);
// void R_SetExternalPtrAddr(SEXP s, void *p);
// void R_SetExternalPtrTag(SEXP s, SEXP tag);
// void R_SetExternalPtrProtected(SEXP s, SEXP p);
// // Added in R 3.4.0
// SEXP R_MakeExternalPtrFn(DL_FUNC p, SEXP tag, SEXP prot);
// DL_FUNC R_ExternalPtrAddrFn(SEXP s);

// /* Finalization interface */
// typedef void (*R_CFinalizer_t)(SEXP);
// void R_RegisterFinalizer(SEXP s, SEXP fun);
// void R_RegisterCFinalizer(SEXP s, R_CFinalizer_t fun);
// void R_RegisterFinalizerEx(SEXP s, SEXP fun, Rboolean onexit);
// void R_RegisterCFinalizerEx(SEXP s, R_CFinalizer_t fun, Rboolean onexit);
// void R_RunPendingFinalizers(void);

// /* Weak reference interface */
// SEXP R_MakeWeakRef(SEXP key, SEXP val, SEXP fin, Rboolean onexit);
// SEXP R_MakeWeakRefC(SEXP key, SEXP val, R_CFinalizer_t fin, Rboolean onexit);
// SEXP R_WeakRefKey(SEXP w);
// SEXP R_WeakRefValue(SEXP w);
// void R_RunWeakRefFinalizer(SEXP w);

// SEXP R_PromiseExpr(SEXP);
// SEXP R_ClosureExpr(SEXP);
// SEXP R_BytecodeExpr(SEXP e);
// void R_initialize_bcode(void);
// SEXP R_bcEncode(SEXP);
// SEXP R_bcDecode(SEXP);
// void R_registerBC(SEXP, SEXP);
// Rboolean R_checkConstants(Rboolean);
// Rboolean R_BCVersionOK(SEXP);
// #define PREXPR(e) R_PromiseExpr(e)
// #define BODY_EXPR(e) R_ClosureExpr(e)

// void R_init_altrep();
// void R_reinit_altrep_classes(DllInfo *);

// /* Protected evaluation */
// Rboolean R_ToplevelExec(void (*fun)(void *), void *data);
// SEXP R_ExecWithCleanup(SEXP (*fun)(void *), void *data,
// 		       void (*cleanfun)(void *), void *cleandata);
// SEXP R_tryCatch(SEXP (*)(void *), void *,       /* body closure*/
// 		SEXP,                           /* condition classes (STRSXP) */
// 		SEXP (*)(SEXP, void *), void *, /* handler closure */
// 		void (*)(void *), void *);      /* finally closure */
// SEXP R_tryCatchError(SEXP (*)(void *), void *,        /* body closure*/
// 		     SEXP (*)(SEXP, void *), void *); /* handler closure */
// SEXP R_withCallingErrorHandler(SEXP (*)(void *), void *, /* body closure*/
// 			       SEXP (*)(SEXP, void *), void *); /* handler closure */
// SEXP R_MakeUnwindCont();
// void NORET R_ContinueUnwind(SEXP cont);
// SEXP R_UnwindProtect(SEXP (*fun)(void *data), void *data,
//                      void (*cleanfun)(void *data, Rboolean jump),
//                      void *cleandata, SEXP cont);

// /* Environment and Binding Features */
// void R_RestoreHashCount(SEXP rho);
// Rboolean R_IsPackageEnv(SEXP rho);
// SEXP R_PackageEnvName(SEXP rho);
// SEXP R_FindPackageEnv(SEXP info);
// Rboolean R_IsNamespaceEnv(SEXP rho);
// SEXP R_NamespaceEnvSpec(SEXP rho);
// SEXP R_FindNamespace(SEXP info);
// void R_LockEnvironment(SEXP env, Rboolean bindings);
// Rboolean R_EnvironmentIsLocked(SEXP env);
// void R_LockBinding(SEXP sym, SEXP env);
// void R_unLockBinding(SEXP sym, SEXP env);
// void R_MakeActiveBinding(SEXP sym, SEXP fun, SEXP env);
// Rboolean R_BindingIsLocked(SEXP sym, SEXP env);
// Rboolean R_BindingIsActive(SEXP sym, SEXP env);
// SEXP R_ActiveBindingFunction(SEXP sym, SEXP env);
// Rboolean R_HasFancyBindings(SEXP rho);


// /* ../main/errors.c : */
// /* needed for R_load/savehistory handling in front ends */
// #if defined(__GNUC__) && __GNUC__ >= 3
// void Rf_errorcall(SEXP, const char *, ...) __attribute__((noreturn));
// #else
// void Rf_errorcall(SEXP, const char *, ...);
// #endif
// void Rf_warningcall(SEXP, const char *, ...);
// void Rf_warningcall_immediate(SEXP, const char *, ...);

// /* Save/Load Interface */
// #define R_XDR_DOUBLE_SIZE 8
// #define R_XDR_INTEGER_SIZE 4

// void R_XDREncodeDouble(double d, void *buf);
// double R_XDRDecodeDouble(void *buf);
// void R_XDREncodeInteger(int i, void *buf);
// int R_XDRDecodeInteger(void *buf);

// typedef void *R_pstream_data_t;

// typedef enum {
//     R_pstream_any_format,
//     R_pstream_ascii_format,
//     R_pstream_binary_format,
//     R_pstream_xdr_format,
//     R_pstream_asciihex_format
// } R_pstream_format_t;

// typedef struct R_outpstream_st *R_outpstream_t;
// struct R_outpstream_st {
//     R_pstream_data_t data;
//     R_pstream_format_t type;
//     int version;
//     void (*OutChar)(R_outpstream_t, int);
//     void (*OutBytes)(R_outpstream_t, void *, int);
//     SEXP (*OutPersistHookFunc)(SEXP, SEXP);
//     SEXP OutPersistHookData;
// };

// typedef struct R_inpstream_st *R_inpstream_t;
// #define R_CODESET_MAX 63
// struct R_inpstream_st {
//     R_pstream_data_t data;
//     R_pstream_format_t type;
//     int (*InChar)(R_inpstream_t);
//     void (*InBytes)(R_inpstream_t, void *, int);
//     SEXP (*InPersistHookFunc)(SEXP, SEXP);
//     SEXP InPersistHookData;
//     char native_encoding[R_CODESET_MAX + 1];
//     void *nat2nat_obj;
//     void *nat2utf8_obj;
// };

// void R_InitInPStream(R_inpstream_t stream, R_pstream_data_t data,
// 		     R_pstream_format_t type,
// 		     int (*inchar)(R_inpstream_t),
// 		     void (*inbytes)(R_inpstream_t, void *, int),
// 		     SEXP (*phook)(SEXP, SEXP), SEXP pdata);
// void R_InitOutPStream(R_outpstream_t stream, R_pstream_data_t data,
// 		      R_pstream_format_t type, int version,
// 		      void (*outchar)(R_outpstream_t, int),
// 		      void (*outbytes)(R_outpstream_t, void *, int),
// 		      SEXP (*phook)(SEXP, SEXP), SEXP pdata);


// #ifdef NEED_CONNECTION_PSTREAMS
// /* The connection interface is not available to packages.  To
//    allow limited use of connection pointers this defines the opaque
//    pointer type. */
// #ifndef HAVE_RCONNECTION_TYPEDEF
// typedef struct Rconn  *Rconnection;
// #define HAVE_RCONNECTION_TYPEDEF
// #endif
// void R_InitConnOutPStream(R_outpstream_t stream, Rconnection con,
// 			  R_pstream_format_t type, int version,
// 			  SEXP (*phook)(SEXP, SEXP), SEXP pdata);
// void R_InitConnInPStream(R_inpstream_t stream,  Rconnection con,
// 			 R_pstream_format_t type,
// 			 SEXP (*phook)(SEXP, SEXP), SEXP pdata);
// #endif

// void R_Serialize(SEXP s, R_outpstream_t ops);
// SEXP R_Unserialize(R_inpstream_t ips);
// SEXP R_SerializeInfo(R_inpstream_t ips);

// /* slot management (in attrib.c) */
// SEXP R_do_slot(SEXP obj, SEXP name);
// SEXP R_do_slot_assign(SEXP obj, SEXP name, SEXP value);
// int R_has_slot(SEXP obj, SEXP name);
// /* S3-S4 class (inheritance), attrib.c */
// SEXP R_S4_extends(SEXP klass, SEXP useTable);

// /* class definition, new objects (objects.c) */
// SEXP R_do_MAKE_CLASS(const char *what);
// SEXP R_getClassDef  (const char *what);
// SEXP R_getClassDef_R(SEXP what);
// Rboolean R_has_methods_attached(void);
// Rboolean R_isVirtualClass(SEXP class_def, SEXP env);
// Rboolean R_extends  (SEXP class1, SEXP class2, SEXP env);
// SEXP R_do_new_object(SEXP class_def);
// /* supporting  a C-level version of  is(., .) : */
// int R_check_class_and_super(SEXP x, const char **valid, SEXP rho);
// int R_check_class_etc      (SEXP x, const char **valid);

// /* preserve objects across GCs */
// void R_PreserveObject(SEXP);
// void R_ReleaseObject(SEXP);

// SEXP R_NewPreciousMSet(int);
// void R_PreserveInMSet(SEXP x, SEXP mset);
// void R_ReleaseFromMSet(SEXP x, SEXP mset);
// void R_ReleaseMSet(SEXP mset, int keepSize);

// /* Shutdown actions */
// void R_dot_Last(void);		/* in main.c */
// void R_RunExitFinalizers(void);	/* in memory.c */

// /* Replacements for popen and system */
// #ifdef HAVE_POPEN
// # ifdef __cplusplus
// std::FILE *R_popen(const char *, const char *);
// # else
// FILE *R_popen(const char *, const char *);
// # endif
// #endif
// int R_system(const char *);

// /* R_compute_identical:  C version of identical() function
//    The third arg to R_compute_identical() consists of bitmapped flags for non-default options:
//    currently the first 4 default to TRUE, so the flag is set for FALSE values:
//    1 = !NUM_EQ
//    2 = !SINGLE_NA
//    4 = !ATTR_AS_SET
//    8 = !IGNORE_BYTECODE
//   16 = !IGNORE_ENV
//   Default from R's default: 16
// */
// Rboolean R_compute_identical(SEXP, SEXP, int);

// SEXP R_body_no_src(SEXP x); // body(x) without "srcref" etc, ../main/utils.c

// /* C version of R's  indx <- order(..., na.last, decreasing) :
//    e.g.  arglist = Rf_lang2(x,y)  or  Rf_lang3(x,y,z) */
// void R_orderVector (int *indx, int n, SEXP arglist, Rboolean nalast, Rboolean decreasing);
// // C version of R's  indx <- order(x, na.last, decreasing) :
// void R_orderVector1(int *indx, int n, SEXP x,       Rboolean nalast, Rboolean decreasing);

// /*
//    These are the inlinable functions that are provided in Rinlinedfuns.h
//    It is *essential* that these do not appear in any other header file,
//    with or without the Rf_ prefix.
// */
// SEXP     Rf_allocVector(SEXPTYPE, R_xlen_t);
fn C.Rf_allocVector(SexpType, C.R_xlen_t) C.SEXP
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
fn C.Rf_protect(C.SEXP) C.SEXP
// void Rf_unprotect(int);
fn C.Rf_unprotect(int)
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

// void R_BadValueInRCode(SEXP value, SEXP call, SEXP rho, const char *rawmsg,
//         const char *errmsg, const char *warnmsg, const char *varname,
//         Rboolean warnByDefault);

// #endif /* R_INTERNALS_H_ */
