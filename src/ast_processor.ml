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
let pclass outx ?extends:(parent="") name =
  match parent with
  | ""  -> fprintf outx "class %s:\n" name; flush outx
  | parent_name -> fprintf outx "class %s(%s):\n" name parent_name; flush outx


(** Output a python __init__ method  
  @param product List of the types associated to each field
*)
let init outx product =
  let rec step_fields remaining_fields counter =
    match remaining_fields with
    | []  -> ()
    | typename::rest ->
      fprintf outx "%sfield_%d : %s\n" (tab 4) counter typename;
      step_fields rest (counter+1)
  in

  let arg_n   i t = fprintf outx ", arg_%d : %s " i t in
  let field_n i _ = fprintf outx "%sself.field_%d = arg_%d\n" (tab 8) i i in
  
  (* write TYPE informations  *)
  step_fields product 0;
  (* write class constructor  *)
  fprintf outx "%sdef __init__(self" (tab 4);
  
  List.iteri arg_n    product;
  fprintf outx "):\n";
  List.iteri field_n  product;
  
  (* empty constructor *)
  if List.length product = 0 then fprintf outx "%s pass\n" (tab 8);

  flush outx


(* =============================================== *)
(* SUBCLASSES GENERATION - OCAML-LIKE CONSTRUCTORS *)
(* =============================================== *)


(** Output python subclasses (ocaml constructors)  *)
let rec write_sub_classes outx parent constructors =
  match constructors with
  | [] -> ()
  | Constructor (name, product)::rest ->
    write_sub_class outx parent name product;
    fprintf outx "\n";
    write_sub_classes outx parent rest;
    flush outx 
  | _ -> failwith "ERROR - SUBCLASSES ARE CREATED ONLY FROM CUSTOM CONSTRUCTORS"

and write_sub_class outx parent name product =
  pclass outx ~extends:parent name; init outx product


(* =============================================== *)
(* MAIN CLASS GENERATION - TYPE WRAPPER            *)
(* =============================================== *)


(** Output python main class (ocaml type) *)
let write_main_class outx name =
  pclass outx name; init outx []


(* =============================================== *)
(* TYPEDEF TO PYTHON CONVERSION                    *)
(* =============================================== *)


(** Convert typedef to python code *)
let write_classes outx typedef_list =
  List.iter (fun typedef -> 
    match typedef with
    | Typedef (name, constructors) ->
      write_main_class outx name;
      fprintf outx "\n";
      write_sub_classes outx name constructors;
      flush outx
    | _ ->
      failwith "ERROR - CLASS ARE CREATED ONLY FROM TYPEDEF"
  ) typedef_list