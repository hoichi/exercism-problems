open Base

type planet =
  | Mercury
  | Venus
  | Earth
  | Mars
  | Jupiter
  | Saturn
  | Neptune
  | Uranus

let year_ratio =
  function
  | Earth  -> 1.
  | Mercury  -> 0.2408467
  | Venus  -> 0.61519726
  | Mars  -> 1.8808158
  | Jupiter  -> 11.862615
  | Saturn  -> 29.447498
  | Uranus  -> 84.016846
  | Neptune  -> 164.79132
  
let seconds_per_earth_year = 31557600.0


let age_on planet seconds =
  let r = year_ratio planet in
  Float.of_int seconds /. seconds_per_earth_year /. r
