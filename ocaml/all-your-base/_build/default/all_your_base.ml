open Base

type base = int

let number_to_digits base num =
  let rec append_digit list rem =
    if rem <= 0
      then list
      else append_digit ((rem % base)::list) (rem / base)
  in

  let digits = append_digit [] num in

  match digits with
  | [] -> [0]
  | _::_ -> digits

let digits_to_number base digits =
  let add_digit i acc d = Option.map2 acc d ~f:(
      fun a d -> a + d * (Int.pow base i)
    )
  in

  digits
    |> List.rev_map ~f:(fun d -> Option.some_if (d >= 0 && d < base) d)
    |> List.foldi ~init:(Some 0) ~f:add_digit
      

let convert_bases ~from ~digits ~target =
  if from <= 1 || target <= 1
    then None
    else (digits
      |> digits_to_number from
      |> Option.map ~f:(number_to_digits target))
