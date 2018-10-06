open Base.List

type dna = [ `A | `C | `G | `T ]
type rna = [ `A | `C | `G | `U ]

(* let n_to_rna = function
  | `G -> `C
  | `C -> `G
  | `T -> `A
  | `A -> `U
 *)
(** Transcribe DNA to RNA by replacing 'T' with 'U'. *)
let to_rna =
  map ~f:(function
    | `G -> `C
    | `C -> `G
    | `T -> `A
    | `A -> `U
  )
