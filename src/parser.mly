/* ========================= */
/* PARSER FOR PYM-S          */
/* AUTHOR : ARTHUR CORRENSON */
/* ========================= */

%{
  open Ast
%}

%token <string> TYPENAME
%token <string> SYMBOL
%token PRODUCT
%token TYPEDEF
%token PIPE
%token EQUAL
%token EOF
%start main
%type <Ast.ast> main
%%

main:
  TYPEDEF SYMBOL EQUAL typecontent EOF  { Typedef ($2, $4) }
;


typecontent:
  | constructor               { [$1] }
  | constructor typecontent   { [$1] @ $2 }
;


constructor:
  | PIPE SYMBOL product       { Constructor ($2, $3) }
;


product:
  | TYPENAME                  { [$1] }
  | TYPENAME PRODUCT product  { [$1] @ $3 }
;