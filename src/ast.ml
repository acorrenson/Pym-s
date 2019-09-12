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