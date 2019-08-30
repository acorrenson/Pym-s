(* ========================= *)
(* PYM-S TRANSPILER          *)
(* AUTHOR : ARTHUR CORRENSON *)
(* ========================= *)

open Ast_processor
open Printf

let print_position outx lexbuf =
  let pos = lexbuf.Lexing.lex_curr_p in
  fprintf outx "%s:%d:%d" pos.pos_fname
    pos.pos_lnum (pos.pos_cnum - pos.pos_bol + 1)


let parse_with_error lexbuf =
  try 
    let ast = Parser.main Lexer.token lexbuf in
    write_classes ast; flush stdout
  with
    | Parsing.Parse_error ->
      fprintf stderr "[ PARSING ERROR @ %a]\n" print_position lexbuf;
      exit 1
    | Lexer.Unkown_token ->
      fprintf stderr "[ LEXING ERROR @ %a]\n" print_position lexbuf;
      exit 1


let _ =
  let lexbuf = Lexing.from_channel (open_in "test.pyms") in
  lexbuf.lex_curr_p <- { lexbuf.lex_curr_p with pos_fname = "test.pyms" };
  parse_with_error lexbuf