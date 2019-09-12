/* ========================= */
/* PARSER FOR PYM-S          */
/* AUTHOR : ARTHUR CORRENSON */
/* ========================= */

%{
  open Ast
%}

%token <string> TYPENAME
%token <string> SYMBOL
%token STAR
%token OF
%token TYPEDEF
%token PIPE
%token EQUAL
%token EOF
%start main
%type <Ast.ast list> main
%%

/* Structure of a Pyms file */
main:
  typedef_list EOF                          { $1 }
;


/* Grammar of a type definition */
typedef:
  /* Piped constructor list */
  | TYPEDEF SYMBOL EQUAL constructor_list     
    { Typedef ($2, $4) }
  
  /* Piped constructor list without pipe on first constructor */
  | TYPEDEF SYMBOL EQUAL first_constructor constructor_list 
    { Typedef ($2, [$4] @ $5) }

  /* Single constructor type definition */
  | TYPEDEF SYMBOL EQUAL first_constructor
    { Typedef ($2, [$4]) }
;


/* List of type definitions */
typedef_list:
  | typedef typedef_list
    { [$1] @ $2 }
  | typedef
    { [$1] }
;


/* Constructor without pipe */
first_constructor:
  | SYMBOL OF product
    { Constructor ($1, $3) }
;


/* Constructor with pipe */
constructor:
  | PIPE SYMBOL OF product                  { Constructor ($2, $4) }
  | PIPE SYMBOL                             { Constructor ($2, []) }
;


/* List of constructors */
constructor_list:
  | constructor
    { [$1] }
  | constructor constructor_list
    { [$1] @ $2 }
;


/* Type product */
product:
  | TYPENAME                  { [$1] }
  | SYMBOL                    { [$1] }
  | TYPENAME STAR product     { [$1] @ $3 }
  | SYMBOL STAR product       { [$1] @ $3 }
;