open Base

let dlm = String.to_list " ,;.?!-—"

(* Creates an acronym from a string. *)
let acronym s =
  s
  |> String.split_on_chars ~on:dlm
  |> List.filter_map ~f:(fun s ->
      match String.to_list s with
      | hd::_ -> Some (Char.uppercase hd)
      | [] -> None
    )
  |> String.of_char_list

(** todo: check if i need filter *)
