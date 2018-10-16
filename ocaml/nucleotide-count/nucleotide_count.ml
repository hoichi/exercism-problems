open Base
open Base.Result

let check_nucleotide c =
  match c with
  | 'A' | 'C' | 'G' | 'T' -> Ok c
  | _ -> Error c

let bump_count m k =
  let cnt = Map.find m k |> Option.value ~default:0 in
  Map.set m ~key:k ~data:(cnt + 1)

let count_nucleotide dna q =
  check_nucleotide q
  >>= fun nucl -> String.fold_result dna
    ~init:0
    ~f:(fun cnt c ->
      match check_nucleotide c with
      | Error c -> Error c
      | Ok c when Char.(c = nucl) -> Ok (cnt + 1)
      | _ -> Ok cnt
    )

let count_nucleotides =
  String.fold_result
    ~init:(Map.empty (module Char))
    ~f:(fun counts c ->
      match check_nucleotide c with
      | Error c -> Error c
      | Ok nucl -> Ok (bump_count counts nucl)
    )
