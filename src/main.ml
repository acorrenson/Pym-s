(* ========================= *)
(* PYM-S TRANSPILER          *)
(* AUTHOR : ARTHUR CORRENSON *)
(* ========================= *)

open Ast_processor
open Printf
open Sys
open Filename


(* =============================================== *)
(* PARSING UTILS                                   *)
(* =============================================== *)


(** Print the current position of the lexer *)
let print_position outx lexbuf =
  let pos = lexbuf.Lexing.lex_curr_p in
  fprintf outx "%s:%d:%d" pos.pos_fname
    pos.pos_lnum (pos.pos_cnum - pos.pos_bol + 1)


(** Parse with error/debug informations *)
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


(** resolve relative path *)
let resolve fname = 
  if is_relative fname then
      concat (getcwd ()) fname
  else fname


(** Process the input file *)
let process_file fname =
  printf "Pyms-s running on [ %s ]\n\n" fname;
  
  let lexbuf = Lexing.from_channel (open_in fname) in
    
  lexbuf.lex_curr_p <- { lexbuf.lex_curr_p with
    pos_fname = (basename fname) };
  
  parse_with_error lexbuf


(* process the input file with error/debug informations *)
let process_file_with_error fname = 
  let full_name = resolve fname in
  if file_exists full_name then begin 
    if check_suffix full_name "pyms" then
      process_file full_name
    else failwith "[ ERROR - input files should have .pyms extension\n" end
  else
    fprintf stderr "[ INPUT ERROR - file %s does'nt exist ]\n" fname;
    exit 1


(* =============================================== *)
(* COMMAND LINE INTERFACE SETUP                    *)
(* =============================================== *)

let _ =
  let speclist = [] in
  Arg.parse speclist (process_file) "pyms file.pyms [options]"