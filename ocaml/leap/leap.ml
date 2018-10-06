let leap_year y = 
  let (%=) a b = a mod b = 0 in
  y %= 4 && (not (y %= 100) || y %= 400)
;
