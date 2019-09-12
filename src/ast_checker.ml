(**************************************************************************)
(*                                                                        *)
(*         _____                                                          *)
(*        |  __ \                                                         *)
(*        | |__) |   _ _ __ ___ ______ ___                                *)
(*        |  ___/ | | | '_ ` _ \______/ __|                               *)
(*        | |   | |_| | | | | | |     \__ \                               *)
(*        |_|    \__, |_| |_| |_|     |___/                               *)
(*                __/ |                                                   *)
(*               |___/                                                    *)
(*                                                                        *)
(*  Author : Arthur Correnson                                             *)
(*  Email  : arthur.correnson@gmail.com                                   *)
(*                                                                        *)
(*  Copyright 2019                                                        *)
(*  Arthur Correnson                                                      *)
(*  This file is part of the Pym-s project and is distributed             *)
(*  under the terms of the MIT licence.                                   *)
(**************************************************************************)


open Ast
open Printf


(**
 * Check whether a typename is included in a list or not.
 *)
let includes types type_name =
  let test t a = (t = type_name) || a in
  List.fold_right test types false


(**
 * List all avaliable types accross a list of type definitions 
 * Fails if a type definition is found twice.
 *)
let available_types typedef_list =
  let add_new_type new_type types =
    match new_type with
    | Typedef (name, _) when includes types name ->
      fprintf stderr "ERRROR - type %s declared several times\n" name;
      exit 1
    | Typedef (name, _) ->
      name::types
    | Constructor (_, _) ->
      fprintf stderr "DEV ERRROR - constructors are'nt types\n";
      exit 1
  in
  List.fold_right add_new_type typedef_list [ "int"; "float"; "string"; "char" ]


(** Check if each type exists in a product *)
let check_type_product product types = 
  let check type_name =
    if includes types type_name then ()
    else (
      fprintf stderr "ERROR - Unknown type %s\n" type_name;
      exit 1
    )
  in
  List.iter check product


(** Check if each type exists in a product *)
let check_constructor constructor types =
  match constructor with
  | Constructor(_, product) -> check_type_product product types
  | Typedef (_, _) ->
    fprintf stderr "DEV ERRROR - typedefs are'nt constructors\n";
    exit 1


(** check all types in a list of type definitions *)
let check_types typedef_list =
  let types = available_types typedef_list in
  List.iter (fun x -> 
    match x with
    | Typedef (_, constructors) -> 
      List.iter (fun c -> check_constructor c types) constructors
    | Constructor (_, _) ->
      fprintf stderr "DEV ERRROR - constructors are'nt types\n";
      exit 1

  ) typedef_list