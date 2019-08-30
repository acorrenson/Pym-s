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
let parse_with_error outx lexbuf =
  try 
    let ast = Parser.main Lexer.token lexbuf in
    write_classes outx ast; flush stdout
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
let process_file outx fname =
  fprintf stderr "Pyms-s running on [ %s ]\n\n" fname;
  flush stderr;  
  
  let lexbuf = Lexing.from_channel (open_in fname) in
    
  lexbuf.lex_curr_p <- { lexbuf.lex_curr_p with
    pos_fname = (basename fname) };
  
  parse_with_error outx lexbuf


(* process the input file with error/debug informations *)
let process_file_with_error outx fname = 
  let full_name = resolve fname in
  if file_exists full_name then (
    if check_suffix full_name "pyms" then
      process_file outx full_name
    else (
      fprintf stderr "[ INPUT ERROR - input files should have .pyms extension\n";
      exit 1
    )
  ) else (
    fprintf stderr "[ INPUT ERROR - file %s does'nt exist ]\n" fname;
    exit 1
  )


(* =============================================== *)
(* COMMAND LINE INTERFACE SETUP                    *)
(* =============================================== *)

let not_implemented () =
  fprintf stderr "OPTION NOT IMPLEMENTED\n"; exit 1

let _ =
  let speclist = [
    ("-o", Arg.Unit not_implemented,
      "output file [ not implemented ]");
    ("-d", Arg.Unit not_implemented,
      "generate dynamic type check [ not implemented ]");
    ("-v", Arg.Unit (fun () -> print_endline "Pyms v0.2"),
      "print the current version")
  ] in
  Arg.parse speclist (process_file_with_error stdout) "pyms file.pyms [options]"