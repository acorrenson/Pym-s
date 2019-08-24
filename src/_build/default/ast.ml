
type ast =
  | Constructor of string * string list
  | Typedef of string * ast list