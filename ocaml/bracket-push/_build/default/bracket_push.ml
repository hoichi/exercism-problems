open Base

(** Left brackets *)
let lefts = Set.of_list (module Char) ['(';'[';'{']

(** Left matches for right brackets *)
let pairs = Map.of_alist_exn (module Char) [
  (']'),('[');
  ('}'),('{');
  (')'),('(');
]

(** Checks if it the char is a left bracket. *)
let is_left c =
  Set.exists lefts ~f:(Char.(=) c)

(** Try to find the matching left pair *)
let match_for_right r =
  Map.find pairs r

(** Pop the left bracket if it really is in the head position *)
let pop_left stack c =
  match stack with
  | hd::tl when Char.(hd = c) -> Some tl
  | _ -> None

(** Push left brackets.
    Or pop them when a matching right one is found.
      Fail on unmatched right brackets.
    Ignore non-bracket characters. *)
let push_or_pop stack c =
  Container_intf.Continue_or_stop.(
    if is_left c
      then Continue (c::stack)
      else
        match match_for_right c with
        | None -> Continue stack
        | Some c ->
          match pop_left stack c with
          | Some tl -> Continue tl
          | None -> Stop ()
  )

(*  Go through the characters in the string.
    When done, check if some brackets are still open. *)
let are_balanced s =
  Container_intf.Finished_or_stopped_early.(
    match String.fold_until s ~init:[] ~f:(push_or_pop) with
    | Stopped_early () -> false
    | Finished leftovers ->
      match leftovers with
      | _::_ -> false
      | [] -> true
  )
