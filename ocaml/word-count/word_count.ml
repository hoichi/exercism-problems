open Base

let delimiters = String.to_list " \n\".,:;?!&@$%^&"

let normalize word =
  let quotes = Set.of_list (module Char) ['\''; '"'] in
  word
    |> String.strip ~drop:(Set.mem quotes)
    |> String.lowercase

let word_count s =
  let module L = List in
  s
    |> String.split_on_chars ~on:delimiters
    |> L.filter ~f:(Fn.non String.is_empty)
    |> L.map ~f:normalize
    |> L.fold
      ~init:(Map.empty (module String))
      ~f:(Map.update ~f:(function | Some n -> n + 1 | _ -> 1))
    