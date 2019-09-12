(**************************************************************************)
(*                                                                        *)
(*         _____                                                          *)
(*        |  __ \                                                         *)
(*        | |__) |   _ _ __ ___ ______ ___                                *)
(*        |  ___/ | | | '_ ` _ \______/ __|                               *)
(*        | |   | |_| | | | | | |     \__ \                               *)
(*        |_|    \__, |_| |_| |_|     |___/                               *)
(*                __/ |                                                   *)
(*               |___/                                                    *)
(*                                                                        *)
(*  Author : Arthur Correnson                                             *)
(*  Email  : arthur.correnson@gmail.com                                   *)
(*                                                                        *)
(*  Copyright 2019                                                        *)
(*  Arthur Correnson                                                      *)
(*  This file is part of the Pym-s project and is distributed             *)
(*  under the terms of the MIT licence.                                   *)
(**************************************************************************)

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