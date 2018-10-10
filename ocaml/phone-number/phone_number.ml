open Base


(*
  q: is the set memoized or recreated on every call?
  maybe make a perf test?
*)
let is_separator =
  Set.mem @@ Set.of_list (module Char) ['+';' ';'(';')';'-';]

let digits_of_string_exn s =
  String.fold

let number s =
  None
