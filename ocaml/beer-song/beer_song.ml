open Base;;

let bottles n =
  let count = match n with
              | 0 -> "no more"
              | n -> Int.to_string n
  in
  count ^ " bottle" ^ if n = 1 then "" else "s"
     
let of_beer s =
  s ^ " of beer"

let on_the_wall s =
  s ^ " on the wall"

let verse =
  function
  | 0 ->
    ("No more bottles" |> of_beer |> on_the_wall) ^ ", " ^
      (0 |> bottles |> of_beer) ^ ".\n" ^
    "Go to the store and buy some more, " ^
      (99 |> bottles |> of_beer |> on_the_wall) ^ ".\n"
  | n ->
    let one = if n = 1 then "it" else "one" in
    (n |> bottles |> of_beer |> on_the_wall) ^ ", " ^
      (n |> bottles |> of_beer) ^ ".\n" ^
    "Take " ^ one ^ " down and pass it around, " ^
      (n-1 |> bottles |> of_beer |> on_the_wall) ^ ".\n"

let lyrics ~from ~until =
  List.range from until ~stride:(-1) ~stop:`inclusive
    |> List.map ~f:verse
    |> String.concat ~sep:"\n"
  