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

let init_graph gr= gmap gr (fun x -> (0,x))

let create_flowgraph gr = 
  let g1 = e_fold gr (fun g id1 id2 (x,y) -> if x<>0 then add_arc g id2 id1 x else g) (clone_nodes gr) in

  e_fold gr (fun g id1 id2 (x,y) -> if (y-x)<>0 then add_arc g id1 id2 (y-x) else g) g1 


let init_tree gr s=

  (* let add_child s_node l_arc g_acu = List.fold_left (fun g (x,y) -> if node_exists g x then g else new_arc (new_node g x) s_node x y) g_acu l_arc in *)

  let add_child s_node (x,y) g = if node_exists g x then g else new_arc (new_node g x) s_node x y in


  let rec loop source g_acu =
    let l_outarc = out_arcs gr source in
    (* List.fold_left (fun acu (x,y) -> loop x (add_child source l_outarc acu)) g_acu l_outarc  *)
    List.fold_left (fun acu (x,y) -> loop x (add_child source (x,y) acu)) g_acu l_outarc
  in

  loop s (new_node empty_graph s)



let find_path gr source puit =

  let rec loop source puit l_acu =
    if source=puit then
      Some l_acu
    else (
      let l_outarc = out_arcs gr source in
      List.find_map (fun (id, label) ->  loop id puit ((id,label)::l_acu)) l_outarc
    )
  in

  loop source puit [(source,0)]

let min path  = 
  let rec loop path a=
    match path with 
    | (_,label)::rest ->  loop rest (if label < a then label else a)
    | [] -> a
  in 
  loop path 10000000

  let add_path graph s path val =
    match path with 
    | (id,_)::rest ->add path id ( add_arc graph s id val ) rest val 
    | [] -> graph
  in 

  
  

