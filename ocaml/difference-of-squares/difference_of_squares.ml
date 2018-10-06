open Base

(* Square the sum of the numbers up to the given number *)
let square_of_sum n =
  Int.pow ((n + 1) * n / 2) 2

(* Sum the squares of the numbers up to the given number *)
let sum_of_squares n =
  Int.((
    2 * (pow n 3) +
    3 * (pow n 2) +
    n
  ) / 6)

(* Subtract sum of squares from square of sums *)
let difference_of_squares n =
  square_of_sum n - sum_of_squares n
