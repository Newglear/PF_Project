open Tools
open Graph
open Gfile 

type flot_arc = (int*int)

(* Filter the null arcs from the graph *)
val filter_zeros : int Graph.graph -> int Graph.graph

(* Initialize a tree from a graph by going through the graph *)
val init_tree : 'a Graph.graph -> Graph.id -> 'a Graph.graph

(* Find a path from the source to the destination in a tree *)
val find_path : int Graph.graph -> Graph.id -> Graph.id -> (Graph.id * int) list

(* Fetch the minimum value label on the path *)
val min : ('a * int) list -> int

(* Add a value on a path in a flow graph  *)
val add_flow : int Graph.graph -> Graph.id -> (Graph.id * 'a) list -> int -> int Graph.graph 

(* Main function that iterates the algorithm *)
val fulk : int Graph.graph -> Graph.id -> Graph.id -> int Graph.graph

(* Translates the flow graph to a capacity graph "10 -> 3/10" *)
val capacity_graph : int Graph.graph -> int Graph.graph -> (int*int) Graph.graph

(* Parsing function: int*int -> string *)
val string_of_int_tuple : (int*int) -> string