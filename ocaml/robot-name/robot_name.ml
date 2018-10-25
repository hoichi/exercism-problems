open Base;;

type robot = { mutable name: string; }

let to_char start n =
  Char.of_int_exn (Char.to_int start + n)

let to_digit =
  to_char '0'

let to_letter =
  to_char 'A'

let bases = [
  (10, to_digit);
  (10, to_digit);
  (10, to_digit);
  (26, to_letter);
  (26, to_letter);
]

let possibilities =
  bases |> List.map ~f:fst |> List.reduce ~f:( * ) |> Option.value_exn

let number_to_chars num =
  bases
  |> List.fold_map
      ~init:num
      ~f:(fun rem (base, to_c) ->
        rem / base, to_c (rem % base)
      )
  |> snd
  |> List.rev

let () = Random.init 92834

let new_name () =
  Random.int possibilities
  |> number_to_chars
  |> String.of_char_list
