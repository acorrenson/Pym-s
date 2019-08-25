(* ========================= *)
(* AST PROCESSOR FOR PYM-S   *)
(* AUTHOR : ARTHUR CORRENSON *)
(* ========================= *)

open Printf
open Ast

(* =============================================== *)
(* SUBCLASSES GENERATION - OCAML-LIKE CONSTRUCTORS *)
(* =============================================== *)
let rec write_sub_classes parent constructors =
  match constructors with
  | [] -> ()
  | Constructor (name, product)::rest ->
    write_sub_class parent name product;
    print_newline ();
    write_sub_classes parent rest
  | _ -> failwith "ERROR - SUBCLASSES ARE CREATED ONLY FROM CUSTOM CONSTRUCTORS"

and write_sub_class parent name product =
  printf "class %s(%s):\n    def __init__(self):\n        pass\n" name parent; ignore(product)


(* =============================================== *)
(* MAIN CLASS GENERATION - TYPE WRAPPER            *)
(* =============================================== *)
let write_main_class name =
  printf "class %s :\n    def __init__(self):\n        pass\n" name


(* =============================================== *)
(* OUTPUT PYTHON CLASSES                           *)
(* =============================================== *)
let write_class name constructors =
  write_main_class name;
  print_newline ();
  write_sub_classes name constructors


(* =============================================== *)
(* TYPEDEF TO PYTHON CONVERSION                    *)
(* =============================================== *)
let make_class typedef =
  match typedef with
  | Typedef (name, constructors)  ->
    write_class name constructors
  | _ ->
    failwith "ERROR - CLASS ARE CREATED ONLY FROM TYPEDEF"