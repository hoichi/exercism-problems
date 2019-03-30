module type COMPARABLE = sig
  type t
  val compare : t -> t -> int
end

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
end

module Make(Ord: COMPARABLE) = struct
  open Base

  type elt = Ord.t
  type t = Empty | Node of { l: t; r: t; v: elt }


  (* helpers *)

  let cmp = Ord.compare

  let create l r v = Node { l; r; v; }

  let empty = Empty

  let new_node el = Node { l = Empty; r = Empty; v = el; }

  let rec fold t ~f ~init =
    match t with
    | Empty -> init
    | Node {l; r; v} ->
      let acc_1 = f init v in
      let acc_2 = fold l ~f ~init:acc_1 in
      fold r ~f ~init:acc_2

  (* the interface *)
  let rec add s el =
    match s with
      | Empty -> new_node el
      | Node { l; r; v; } as t ->
        let c = cmp el v in
        if c < 0 then create (add l el) r v
        else if c > 0 then create l (add r el) v
        else t (* don’t add dupes to a set *)

  let of_list = List.fold ~init:empty ~f:add

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

  let is_subset t1 t2 =
    fold t1 ~init:true ~f:(fun res el -> res && is_member t2 el)

  let is_disjoint t1 t2 =
    fold t1 ~init:true ~f:(fun res el -> res && not @@ is_member t2 el)

  let equal t1 t2 = is_subset t1 t2 && is_subset t2 t1
        
  let filter ~f:filter_f =
    fold ~init:empty ~f:(fun acc el ->
      if filter_f el then add acc el
      else acc
    )

  let intersect t1 = filter ~f:(is_member t1)

  let difference t1 t2 = filter t1 ~f:(Fn.non @@ is_member t2)

  let union t1 = fold ~init:t1 ~f:add
 end

