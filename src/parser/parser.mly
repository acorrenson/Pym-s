/**************************************************************************/
/*                                                                        */
/*         _____                                                          */
/*        |  __ \                                                         */
/*        | |__) |   _ _ __ ___ ______ ___                                */
/*        |  ___/ | | | '_ ` _ \______/ __|                               */
/*        | |   | |_| | | | | | |     \__ \                               */
/*        |_|    \__, |_| |_| |_|     |___/                               */
/*                __/ |                                                   */
/*               |___/                                                    */
/*                                                                        */
/*  Author : Arthur Correnson                                             */
/*  Email  : arthur.correnson@gmail.com                                   */
/*                                                                        */
/*  Copyright 2019                                                        */
/*  Arthur Correnson                                                      */
/*  This file is part of the Pym-s project and is distributed             */
/*  under the terms of the MIT licence.                                   */
/**************************************************************************/

%{
  open Ast
%}

%token <string> TYPENAME
%token <string> SYMBOL
%token STAR
%token OF
%token TYPEDEF
%token PIPE
%token EQUAL
%token EOF
%start main
%type <Ast.typedef list> main
%%

/* Structure of a Pyms file */
main:
  typedef_list EOF                          { $1 }
;


/* Grammar of a type definition */
typedef:
  /* Piped constructor list */
  | TYPEDEF SYMBOL EQUAL constructor_list     
    { Typedef ($2, $4) }
  
  /* Piped constructor list without pipe on first constructor */
  | TYPEDEF SYMBOL EQUAL first_constructor constructor_list 
    { Typedef ($2, [$4] @ $5) }

  /* Single constructor type definition */
  | TYPEDEF SYMBOL EQUAL first_constructor
    { Typedef ($2, [$4]) }
;


/* List of type definitions */
typedef_list:
  | typedef typedef_list
    { [$1] @ $2 }
  | typedef
    { [$1] }
;


/* Constructor without pipe */
first_constructor:
  | SYMBOL OF product
    { Constructor ($1, $3) }
;


/* Constructor with pipe */
constructor:
  | PIPE SYMBOL OF product                  { Constructor ($2, $4) }
  | PIPE SYMBOL                             { Constructor ($2, []) }
;


/* List of constructors */
constructor_list:
  | constructor
    { [$1] }
  | constructor constructor_list
    { [$1] @ $2 }
;


/* Type product */
product:
  | TYPENAME                  { [$1] }
  | SYMBOL                    { [$1] }
  | TYPENAME STAR product     { [$1] @ $3 }
  | SYMBOL STAR product       { [$1] @ $3 }
;