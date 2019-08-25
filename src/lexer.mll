(* ========================= *)
(* LEXER FOR PYM-S           *)
(* AUTHOR : ARTHUR CORRENSON *)
(* ========================= *)

{
  open Parser
}

rule token = parse
| [' ' '\t' '\n']
    { token lexbuf }
| "int" | "float" | "string" | "char"
  { TYPENAME (Lexing.lexeme lexbuf) }
| "typedef"
  { TYPEDEF }
| ['a'-'z' 'A'-'Z' '-' '_']+ ['a'-'z' 'A'-'Z' '-' '_' '0'-'9']*
  { SYMBOL (Lexing.lexeme lexbuf) }
| '*'
  { PRODUCT }
| '='
  { EQUAL }
| '|'
  { PIPE }
| eof
  { EOF }