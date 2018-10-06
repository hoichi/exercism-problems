open Base

let is_true_for_range (min, max) ~f =
  let rec helper next max bool =
    bool && (
      next > max ||
      helper (next + 1) max (f next)
    )
  in helper min max true;;

let is_pangram s =
  let s_n = String.lowercase s in
  is_true_for_range
    (Char.to_int 'a', Char.to_int 'z')
    ~f:(fun c -> String.contains s_n (Char.of_int_exn c))
