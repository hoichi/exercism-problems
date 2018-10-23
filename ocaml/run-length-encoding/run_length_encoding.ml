open Base

let encode =
  function
  | "" -> ""
  | s -> String.fold s
      ~init:( [(s.[0], 0)] )
      ~f:(fun acc next ->
          match acc with
          | (c, n)::tl when Char.(c = next) -> (c, n+1)::tl
          | l -> (next, 1)::l
      )
    |> List.rev
    |> List.map
      ~f:(fun (c, n) ->
        (match n with | 1 -> "" | n -> Int.to_string n)
        ^ String.of_char c
      )
    |> String.concat


let decode s =
  let push_c s c = s ^ (String.of_char c) in
  let gen_seq = function
    | "" -> String.of_char
    | s -> String.make (Int.of_string s)
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
