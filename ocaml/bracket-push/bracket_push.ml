open Base
(* open Base.Continue_or_stop
open Base.Finished_or_stopped_early *)

type bracket =
  | Left of char
  | Right of char
  | Neither

let brackets = [
  '[',']';
  '{','}';
  '(',')';
]

exception Right_bracket_mismatch

let bracket_type c =
  let map_t2 (a, b) f = (f a, f b) in
  let (lefts, rights) = map_t2
    (List.unzip brackets)
    (Set.of_list (module Char))
  in
  if Set.mem lefts c then Left c
  else if Set.mem rights c then Right c
  else Neither

let brackets_match l r =
  let matches = Map.of_alist_exn (module Char) brackets in
  Char.(Map.find_exn matches l = r)

let push_or_pop_exn stack c =
  match bracket_type c, stack with
  | Neither, s -> s (* ignore *)
  | Left l, s -> l::s (* push *)
  | Right r, l::s when brackets_match l r -> s (* pop *)
  | _ -> raise Right_bracket_mismatch

(*  Go through the characters in the string.
    When done, check if some brackets are still open. *)
let are_balanced s =
  try String.fold s ~init:[] ~f:(push_or_pop_exn) |> List.is_empty with
  | _ -> false
