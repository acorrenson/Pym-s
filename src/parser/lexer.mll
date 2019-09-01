(* ========================= *)
(* LEXER FOR PYM-S           *)
(* AUTHOR : ARTHUR CORRENSON *)
(* ========================= *)

{
  open Parser
  exception Unkown_token

  let incr_linenum lexbuf = 
    let pos = lexbuf.Lexing.lex_curr_p in
    lexbuf.lex_curr_p <- { pos with
      pos_lnum  = pos.pos_lnum + 1;
      pos_bol   =  pos.pos_cnum;
    }
}

rule token = parse
| '\n'
  { incr_linenum lexbuf; token lexbuf }
| [' ' '\t']
    { token lexbuf }
| "int" | "float" | "string" | "char"
  { TYPENAME (Lexing.lexeme lexbuf) }
| "typedef"
  { TYPEDEF }
| "of"
  { OF }
| ['a'-'z' 'A'-'Z' '_']+ ['a'-'z' 'A'-'Z' '-' '_' '0'-'9']*
  { SYMBOL (Lexing.lexeme lexbuf) }
| '*'
  { STAR }
| '='
  { EQUAL }
| '|'
  { PIPE }
| eof
  { EOF }
| _
  { raise Unkown_token }