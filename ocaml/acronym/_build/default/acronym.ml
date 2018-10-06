open Base

(* Creates an acronym from a string. *)
let acronym s =
  let reducer (was_alpha, acro) c =
    let is_alpha = Char.between ~low:'A' ~high:'z' c in
    let s = if (is_alpha && not was_alpha)
      then String.(c |> of_char |> uppercase)
      else "" in
    (is_alpha, acro ^ s)
  in
    s
    |> String.fold ~init:(false, "") ~f:reducer
    |> (fun (_, acro) -> acro)
