open Base
open Container_intf


let abc =
  List.range ~stop:`inclusive (Char.to_int 'a') (Char.to_int 'z')
  |> List.map ~f:Char.of_int_exn
  |> Set.of_list (module Char)


let tick_off_letter acc c =
  let rmn = Set.remove acc (Char.lowercase c) in
  Continue_or_stop.(
    if Set.is_empty rmn then Stop ()
    else Continue rmn
  )

let is_pangram s =
  Finished_or_stopped_early.(
    match String.fold_until s ~init:abc ~f:tick_off_letter with
    | Stopped_early _ -> true
    | Finished _ -> false
  )
