open Base

(** Extract all digits from a string, return a list of chars *)
let extract_digits s =
  String.to_list s
  |> List.filter_map ~f:(fun c ->
    let i = Char.to_int c in
    Option.some_if (i >= Char.to_int '0' && i <= Char.to_int '9') c
  )

let number s =
  extract_digits s

  (* remove the country code *)
  |> function | '1'::num | num -> num;

  (* ensure we have exactly 10 correct digits *)
  |> function
    | '0'::_ | _::_::_::'0'::_
    | '1'::_ | _::_::_::'1'::_ -> None 
    | l when List.length l = 10 -> Some l
    | _ -> None;

  (* back to string *)
  |> Option.map ~f:String.of_char_list
