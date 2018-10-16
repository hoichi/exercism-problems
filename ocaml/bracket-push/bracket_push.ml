open Base
open Base.Continue_or_stop

let push_or_pop stack c =
  match stack, c with
  | _,'[' | _,'{' | _,'(' -> Continue (c::stack)
  | '['::tl,']' | '{'::tl,'}' | '('::tl,')' -> Continue tl
  | _,']' | _,'}' | _,')' -> Stop false
  | stack,_ -> Continue stack

(*  Go through the characters in the string.
    When done, check if some brackets are still open. *)
let are_balanced =
  String.fold_until
    ~init:[]
    ~f:push_or_pop
    ~finish:List.is_empty
