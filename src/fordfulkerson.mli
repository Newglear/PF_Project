open Tools
open Graph
open Gfile 

type flot_arc = (int*int)

val init_graph : int Graph.graph -> flot_arc Graph.graph

val create_flowgraph : flot_arc Graph.graph -> int Graph.graph

val filter_zeros : int Graph.graph -> int Graph.graph

val init_tree : 'a Graph.graph -> Graph.id -> 'a Graph.graph

val find_path : int Graph.graph -> Graph.id -> Graph.id -> (Graph.id * int) list option

val min : ('a * int) list -> int

val add_flow : int Graph.graph -> Graph.id -> (Graph.id * 'a) list -> int -> int Graph.graph 