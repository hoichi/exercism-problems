open Base

let char_to_digit_exn =
  Fn.compose Int.of_string String.of_char

let double_mod_9 n =
  let dbl = n * 2 in
  if dbl >= 9 then dbl - 9 else dbl

let checksum_exn s =
  let len = String.length s in
  String.foldi s ~init:0 ~f:(fun i acc c ->
    let d = char_to_digit_exn c in
    acc +
      if (len - i) % 2 = 0 then double_mod_9 d else d
  )

let valid s =
  let t = String.filter s ~f:(Fn.non @@ Char.(=) ' ') in
  if String.length t <= 1 then false
  else
    try (checksum_exn t) % 10 = 0 with
    | _ -> false

