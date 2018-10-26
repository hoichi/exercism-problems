open Base;;

(* The basest *)
type robot = { mutable name: string; }


let to_char start n =
  Char.of_int_exn (Char.to_int start + n)

let to_digit = to_char '0'
let to_letter = to_char 'A'

let bases = [
  (10, to_digit);
  (10, to_digit);
  (10, to_digit);
  (26, to_letter);
  (26, to_letter);
]

let number_to_chars num =
  bases
  |> List.fold_map
      ~init:num
      ~f:( fun rem (base, to_c) -> rem / base, to_c (rem % base) )
  |> snd
  |> List.rev

(* Random_name generation *)

let possibilities =
  bases |> List.map ~f:fst |> List.reduce ~f:( * ) |> Option.value ~default:0

let () = Random.init 76543

let random = ref (Random.int possibilities)

let new_name () =
  let () = random := (!random + 1296277 ) % possibilities in
  !random
  |> number_to_chars
  |> String.of_char_list

(* The API *)

let new_robot () = {
  name = new_name ()
}

let name r
  = r.name

let reset r =
  r.name <- new_name ()
