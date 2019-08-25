(* ========================= *)
(* PYM-S TRANSPILER          *)
(* AUTHOR : ARTHUR CORRENSON *)
(* ========================= *)

open Ast_processor

let _ =
  try
    let lexbuf = Lexing.from_string "typedef montype = | A int * float | B string" in
    while true do
      let ast = Parser.main Lexer.token lexbuf in
      make_class ast; flush stdout;
    done
  with _ ->
    print_endline "STOP";
    exit 0