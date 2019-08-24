(* ========================= *)
(* PYM-S TRANSPILER          *)
(* AUTHOR : ARTHUR CORRENSON *)
(* ========================= *)

let _ =
  try
    print_string "> "; flush stdout;
    let lexbuf = Lexing.from_channel stdin in
    while true do
      let _ = Parser.main Lexer.token lexbuf in
      print_endline "...";
    done
  with Lexer.Eof ->
    exit 0