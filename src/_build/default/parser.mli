type token =
  | TYPENAME of (string)
  | SYMBOL of (string)
  | PRODUCT
  | TYPEDEF
  | PIPE
  | EQUAL
  | EOF

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Ast.ast
