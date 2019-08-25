
type ast =
  | Constructor of string * string list
  | Typedef of string * ast list


let rec sol l =
  match l with
  | t::rest -> t ^ " " ^ (sol rest)
  | []      -> ""

let rec pp a =
  match a with
  | Constructor (s, l)  ->  print_endline (s ^ " " ^ (sol l))
  | Typedef (s, l)      ->  print_endline ("Typedef : "  ^ s); List.iter pp l