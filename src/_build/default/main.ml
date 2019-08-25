(* ========================= *)
(* PYM-S TRANSPILER          *)
(* AUTHOR : ARTHUR CORRENSON *)
(* ========================= *)

open Ast

let _ =
  try
    let lexbuf = Lexing.from_string "typedef a = | Int int * float" in
    while true do
      let ast = Parser.main Lexer.token lexbuf in
      pp ast; flush stdout
    done
  with _ ->
    print_endline "STOP";
    exit 0