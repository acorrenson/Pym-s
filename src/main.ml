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
let process_file_with_error input_file output_file =

  (* resolve input/ouput names *)
  let full_input_name   = resolve input_file in
  let full_output_name  = if output_file = "" 
    then
      (remove_extension input_file) ^ ".py"
    else resolve output_file in
  
  (* ERROR => No input file *)
  if input_file = "" then (
    fprintf stderr "[ INPUT ERROR - not input file provided ]\n";
    exit 1 )

  (* ERROR => Input file does'nt exist *)
  else if not (file_exists full_input_name) then (
    fprintf stderr "[ INPUT ERROR - file %s does'nt exist ]\n" input_file;
    exit 1 )
  
  (* ERROR => Wrong input file format *)
  else if not (check_suffix full_input_name "pyms") then (
    fprintf stderr "[ INPUT ERROR - input files should have .pyms extension ]\n";
    exit 1 )
  
  (* ERROR => Wrong output file format *)
  else if not (check_suffix full_output_name "py") then
  (
    fprintf stderr "[ OUTPUT ERROR - ouput files should have .py extension ]\n";
    exit 0
  ) 

  (* PROCESS => Error free *)
  else process_file (open_out full_output_name) full_input_name


(* =============================================== *)
(* COMMAND LINE INTERFACE SETUP                    *)
(* =============================================== *)

let not_implemented () =
  fprintf stderr "OPTION NOT IMPLEMENTED\n"; exit 1

let input_file  = ref ""
let output_file = ref ""

let _ =
  let speclist = [
    ("-i", Arg.Set_string input_file, "input file");
    ("-o", Arg.Unit not_implemented,
      "output file [ not implemented ]");
    ("-d", Arg.Unit not_implemented,
      "generate dynamic type check [ not implemented ]");
    ("-v", Arg.Unit (fun () -> print_endline "Pyms v0.2"; exit 0),
      "print the current version")
  ] in
  Arg.parse speclist (fun _ -> ()) "pyms file.pyms [options]";
  process_file_with_error !input_file !output_file