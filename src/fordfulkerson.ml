open Tools
open Graph
open Gfile 


type flot_arc = (int*int)
(* Filter all the null arcs from the graph *)
let filter_zeros gr = e_fold gr (fun g id1 id2 (x) -> if x<>0 then add_arc g id1 id2 x else g) (clone_nodes gr)

(*create a tree with a flowgraph*)
let init_tree gr s=

  let rec loop source g_acu node_acu=
    let l_outarc = out_arcs gr source in
    Printf.printf "%d" source;
  
    (* Process only the nodes if it's not on "node_acu" (works as a marked node list) *)
    (* if the node is already marked it does nothing else it creates a new arc to the out arcs and then process them *)
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

  (* Find the lower label from the path (that will be incremented on the flow graph) *)
let min path  = 
  let rec loop path a=
    match path with 
    | (_,label)::rest ->  loop rest (if label < a then label else a)
    | [] -> a
  in 
  loop path 10000000

(* Add a value on the whole path in the graph *)
let rec add_flow graph s path value =
  match path with 
  | (sid,_)::rest when sid = s-> add_flow graph s rest value
  | (id,_)::rest ->( let gr = add_arc graph id s value in 
                     add_flow ( add_arc gr s id (-value)) id rest value )
  | [] -> graph

(* Main looping function to execute the algorythm *)
let fulk graph source dest = 

  let rec loop gr = 
    let tree = init_tree gr source in 
    let path =find_path tree source dest in
    let add = filter_zeros (add_flow gr source path (min path)) in 

    if node_exists tree dest then loop add else gr

  in 
  loop graph
(* Translating function from the flow graph to a capacity graph  *)
let capacity_graph init_graph flow_graph =
  let flow s d =
    match find_arc flow_graph s d with 
    | Some x -> x 
    | None -> 0 
  in 
  e_fold init_graph (fun g id1 id2 capacity -> new_arc g id1 id2 (flow id2 id1 ,capacity)) (clone_nodes init_graph) 

  (* Simple parsing: int*int  -> string *)
  let string_of_int_tuple (x,y) = "\""^(string_of_int x)^"/"^(string_of_int y)^"\""

