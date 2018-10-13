open Base

let find a n =
  let rec div_conq fst lst =
    if fst > lst then None else

    let k = (fst + lst) / 2 in
    match Int.compare a.(k) n with
    | 0 -> Some k
    | -1 -> div_conq (k+1) lst
    | _ -> div_conq fst (k-1)
  in

  div_conq 0 (Array.length a - 1)

