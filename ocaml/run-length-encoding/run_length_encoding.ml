open Base

let encode s =
  let add_letter (s, count, c) =
    s ^
    match count with
    | 0 -> ""
    | 1 ->  String.of_char c
    | n -> (Int.to_string n) ^ (String.of_char c)
  in
  s
  |> String.fold
      ~init:("", 0, '~')
      ~f:(fun (res, cnt, prev) next ->
          if Char.(next = prev)
            then res, cnt + 1, prev
            else add_letter (res, cnt, prev), 1, next
      )
  |> add_letter
  

let decode s =
  let push_c s c = s ^ (String.of_char c) in
  let gen_seq dgts c = 
    match dgts with 
      | "" -> String.of_char c
      | s -> String.make (Int.of_string s) c
  in
  s
    |> String.fold
      ~init:("","")
      ~f:(fun (res, digits) c ->
        if Char.is_digit c
          then res, (push_c digits c)
          else res ^ (gen_seq digits c), ""
      )
    |> fst;;
