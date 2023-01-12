open Tools
open Graph
open Gfile 

(*
1 -> définir source et puit
2 -> mettre les arcs à 0 par rapport à leur flot max
2bis -> transformer le graph en double sens
3 -> faire un BFS entre source et puit et recupérer le path
-> ajouter les enfants de la source dans la Q
-> pop l'enfant puis 
-> 

4 -> incrémenter du flot min des max les arcs du chemin
5 -> recommencer jusqu'à ce qu'il n'y ait plus de solution
6 -> export le graph
*)


type flot_arc = (int*int)

(*init the graph with a tuple --> 0 and his label==flotmax*)
let init_graph gr= gmap gr (fun x -> (0,x))

(*transform a graph into a flowgraph*)
let create_flowgraph gr = 
  let g1 = e_fold gr (fun g id1 id2 (x,y) -> if x<>0 then add_arc g id2 id1 x else g) (clone_nodes gr) in

  e_fold gr (fun g id1 id2 (x,y) -> if (y-x)<>0 then add_arc g id1 id2 (y-x) else g) g1 

let filter_zeros gr = e_fold gr (fun g id1 id2 (x) -> if x<>0 then add_arc g id1 id2 x else g) (clone_nodes gr)
(*create a tree with a flowgraph*)
let init_tree gr s=

  (* let add_child s_node l_arc g_acu = List.fold_left (fun g (x,y) -> if node_exists g x then g else new_arc (new_node g x) s_node x y) g_acu l_arc in *)

  (* let add_child s_node (x,y) g = if node_exists g x then g else new_arc (new_node g x) s_node x y in *)

  let rec loop source g_acu node_acu=
    let l_outarc = out_arcs gr source in
    (* List.fold_left (fun acu (x,y) -> loop x (add_child source l_outarc acu)) g_acu l_outarc  *)
    Printf.printf "%d" source;
    if node_exists node_acu source then g_acu else List.fold_left (fun g (x,y) ->if node_exists g x then g else loop x (new_arc (new_node g x) source x y) (new_node node_acu source)) g_acu l_outarc
  in

  loop s (new_node empty_graph s) empty_graph


(*find a path from source to destination in the tree*)
let find_path gr source puit =

  let rec loop source puit l_acu =
    if source=puit then
      Some l_acu
    else (
      let l_outarc = out_arcs gr source in
      List.find_map (fun (id, label) ->  loop id puit ((id,label)::l_acu)) l_outarc
    )
  in
  
  match loop source puit [(source,1000000000)] with 
  | Some x -> List.rev x
  | None -> []

let min path  = 
  let rec loop path a=
    match path with 
    | (_,label)::rest ->  loop rest (if label < a then label else a)
    | [] -> a
  in 
  loop path 10000000

let rec add_flow graph s path value =
  match path with 
  | (sid,_)::rest when sid = s-> add_flow graph s rest value
  | (id,_)::rest ->( let gr = add_arc graph id s value in 
                     add_flow ( add_arc gr s id (-value)) id rest value )
  | [] -> graph





