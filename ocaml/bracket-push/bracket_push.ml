open Base

type bracket =
  | Left of char
  | Right of char
  | Neither

let brackets = [
  '[',']';
  '{','}';
  '(',')';
]

let map_t2 (a, b) f = (f a, f b)

let bracket_type =
  let (lefts, rights) = map_t2
    (List.unzip brackets)
    (Set.of_list (module Char))
  in
  function
  | c when Set.mem lefts c -> Left c
  | c when Set.mem rights c -> Right c
  | _ -> Neither

let brackets_match l r =
  let matches = Map.of_alist_exn (module Char) brackets in
  Char.(Map.find_exn matches l = r)

exception Right_bracket_mismatch

let push_or_pop_exn stack c =
  match bracket_type c, stack with
  | Neither, s -> s
  | Left l, s -> l::s
  | Right r, l::s when brackets_match l r -> s
  | _ -> raise Right_bracket_mismatch

(*  Go through the characters in the string.
    When done, check if some brackets are still open. *)
let are_balanced s =
  try String.fold s ~init:[] ~f:(push_or_pop_exn) |> List.is_empty with
  | _ -> false
