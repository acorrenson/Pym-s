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
%start main
%type <Ast.ast> main
%%

main:
  TYPEDEF SYMBOL EQUAL typecontent    { Typedef ($2, $4) }
;

constructor:
  | SYMBOL product       { Constructor ($1, $2) }
;

typecontent:
  | constructor               { [$1] }
  | constructor typecontent   { [$1] @ $2 }
;

product:
  | TYPENAME                  { [$1] }
  | TYPENAME product          { [$1] @ $2 }
;