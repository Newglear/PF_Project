open Tools
open Graph
open Gfile 

type flot_arc = (int*int)

val filter_zeros : int Graph.graph -> int Graph.graph

val init_tree : 'a Graph.graph -> Graph.id -> 'a Graph.graph

val find_path : int Graph.graph -> Graph.id -> Graph.id -> (Graph.id * int) list

val min : ('a * int) list -> int

val add_flow : int Graph.graph -> Graph.id -> (Graph.id * 'a) list -> int -> int Graph.graph 

val fulk : int Graph.graph -> Graph.id -> Graph.id -> int Graph.graph

val capacity_graph : int Graph.graph -> int Graph.graph -> (int*int) Graph.graph

val string_of_int_tuple : (int*int) -> string