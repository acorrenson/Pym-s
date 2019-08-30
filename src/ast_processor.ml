(* ========================= *)
(* AST PROCESSOR FOR PYM-S   *)
(* AUTHOR : ARTHUR CORRENSON *)
(* ========================= *)

open Printf
open Ast

(* =============================================== *)
(* PYTHON GENERATION UTILS                         *)
(* =============================================== *)

(** Create a i long empty string *)
let tab i = (String.make i ' ')


(** Output a python class definition header
  @param extends Name of the parent class
*)
let pclass ?extends:(parent="") name =
  match parent with
  | ""  -> printf "class %s:\n" name
  | parent_name -> printf "class %s(%s):\n" name parent_name


(** Output a python __init__ method  
  @param product List of the types associated to each field
*)
let init product =
  let rec step_fields remaining_fields counter =
    match remaining_fields with
    | []  -> ()
    | typename::rest ->
      printf "%sfield_%d : %s\n" (tab 4) counter typename;
      step_fields rest (counter+1)
  in

  let arg_n   i t = printf ", arg_%d : %s " i t in
  let field_n i _ = printf "%sself.field_%d = arg_%d\n" (tab 8) i i in
  
  (* write TYPE informations  *)
  step_fields product 0;
  (* write class constructor  *)
  printf "%sdef __init__(self" (tab 4);
  
  List.iteri arg_n    product;
  printf "):\n";
  List.iteri field_n  product;
  
  (* empty constructor *)
  if List.length product = 0 then printf "%s pass\n" (tab 8)


(* =============================================== *)
(* SUBCLASSES GENERATION - OCAML-LIKE CONSTRUCTORS *)
(* =============================================== *)


(** Output python subclasses (ocaml constructors)  *)
let rec write_sub_classes parent constructors =
  match constructors with
  | [] -> ()
  | Constructor (name, product)::rest ->
    write_sub_class parent name product;
    print_newline ();
    write_sub_classes parent rest
  | _ -> failwith "ERROR - SUBCLASSES ARE CREATED ONLY FROM CUSTOM CONSTRUCTORS"

and write_sub_class parent name product =
  pclass ~extends:parent name; init product


(* =============================================== *)
(* MAIN CLASS GENERATION - TYPE WRAPPER            *)
(* =============================================== *)


(** Output python main class (ocaml type) *)
let write_main_class name =
  pclass name; init []


(* =============================================== *)
(* TYPEDEF TO PYTHON CONVERSION                    *)
(* =============================================== *)


(** Convert typedef to python code *)
let write_classes typedef =
  match typedef with
  | Typedef (name, constructors) ->
    write_main_class name;
    print_newline ();
    write_sub_classes name constructors
  | _ ->
    failwith "ERROR - CLASS ARE CREATED ONLY FROM TYPEDEF"