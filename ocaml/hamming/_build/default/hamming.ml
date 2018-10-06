open Base

type nucleotide = A | C | G | T

let count_diff =
  let (=) = Base.Poly.(=) in
  List.fold ~init:0 ~f:(fun acc (a,b) -> if a = b then acc else acc+1)

(* Compute the hamming distance between the two lists. *)
let hamming_distance genome1 genome2 =
  List.zip genome1 genome2
    |> Option.map ~f:count_diff
