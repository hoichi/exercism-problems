open Base

let check_nucleotide c =
  match c with
  | 'A' | 'C' | 'G' | 'T' -> Ok c
  | _ -> Error c

let count_nucleotide dna q =
  let open Result in
  check_nucleotide q >>= fun nucl ->
    String.fold_result dna
      ~init:0
      ~f:(fun cnt c ->
        check_nucleotide c
        >>| function
            | nxt when Char.(nxt = nucl) -> cnt + 1
            | _ -> cnt
      )

let count_nucleotides =
  let open Result in
  String.fold_result
    ~init:(Map.empty (module Char))
    ~f:(fun counts c ->
      check_nucleotide c
      >>| Map.update
            counts
            ~f:(function | Some n -> n + 1 | _ -> 1)
    )
