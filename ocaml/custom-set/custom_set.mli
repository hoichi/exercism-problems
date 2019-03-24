module type ORDERED_TYPE = sig
  type t
  val compare : t -> t -> int
end;

module type CUSTOM_SET = sig
  type elt
  type t

  val of_list : elt list -> t
  val is_empty : t -> bool
  val is_member : t -> elt -> bool
  val is_subset : t -> t -> bool
  val is_disjoint : t -> t -> bool
  val equal : t -> t -> bool
  val add : t -> elt -> t
  val intersect : t -> t -> t
  val difference : t -> t -> t
  val union : t -> t -> t
end;

module Make(Ord: ORDERED_TYPE) = struct
  open Base;;

  type elt = Ord.t
  type t = Empty | Node of { l: t; r: t; v: elt }

  (* helpers *)
  let cmp = Ord.compare
  let create l r v = Node { l; r; v; }
  let empty = Empty
  let new_node el = Node { l = Empty; r = Empty; v = el; }

  (* the interface *)
  let of_list =
    List.fold ~init:empty ~f:add

  let is_empty = function
    | Empty -> true
    | _ -> false

  let rec is_member s el =
    match s with
    | Empty -> false
    | Node { l; r; v } ->
      let c = cmp el v in
      if c = 0 then true
      else if c < 0 then is_member l el
      else is_member r el

(* 
  val is_subset : t -> t -> bool — the first is a subset of the second
  val is_disjoint : t -> t -> bool
  val equal : t -> t -> bool

 *)
  
  let rec add s el =
    match s with
      | Empty -> new_node el
      | Node { l; r; v; } as t ->
        let c = cmp el v in
        if c < 0 then create (add l el) r v
        else if c > 0 then create l (add r el) v
        else t (* don’t add dupes to a set *)
        
(*   val intersect : t -> t -> t
  val difference : t -> t -> t
  val union : t -> t -> t
 *)

end;

