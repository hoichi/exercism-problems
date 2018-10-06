open Base

let find a n =
  let rec hlp fst lst =
    if fst > lst then None else

    let k = (fst + lst) / 2 in
    let el = a.(k) in

    if el = n then Some k
    else if el < n then hlp (k+1) lst
    else hlp fst (k-1)
  in

  hlp 0 (Array.length a - 1)

