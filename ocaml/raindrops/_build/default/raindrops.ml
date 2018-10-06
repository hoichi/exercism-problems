open Base

let raindrop n =
  [(3,"Pling");(5,"Plang");(7,"Plong")]
    |> List.map ~f:(fun (d,s) -> if n % d = 0 then s else "")
    |> String.concat
    |> (fun s -> if String.is_empty s then Int.to_string n else s )
