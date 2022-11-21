open Graph

let clone_nodes gr = n_fold gr (new_node) empty_graph 

let gmap gr f = e_fold gr (fun gr id1 id2 a -> new_arc gr id1 id2 (f a)) (clone_nodes gr)

let add_arc g id1 id2 n =
  match (find_arc g id1 id2) with
  | None -> new_arc g id1 id2 n
  | Some x -> new_arc g id1 id2 (x+n)
