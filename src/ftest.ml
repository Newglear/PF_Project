open Gfile
open Tools
open Fordfulkerson

let () =

   (* Check the number of command-line arguments *)
   if Array.length Sys.argv <> 5 then
      begin
         Printf.printf "\nUsage: %s infile source sink outfile\n\n%!" Sys.argv.(0) ;
         exit 0
      end ;


   (* Arguments are : infile(1) source-id(2) sink-id(3) outfile(4) *)

   let infile = Sys.argv.(1)
   and outfile = Sys.argv.(4)

   (* These command-line arguments are not used for the moment. *)
   and _source = int_of_string Sys.argv.(2)
   and _sink = int_of_string Sys.argv.(3)
   in

   (* Open file *)
   let graph = from_file infile in

   (* Rewrite the graph that has been read. *)
   (* let () = write_file outfile graph in *)

   (* let graph2 = clone_nodes graph in *)
   (* let () = write_file outfile graph2 in *)

   let graph3 = gmap graph (fun x -> int_of_string x) in
   (* let graph4 = add_arc graph3 4 2 10 in
      let graph5 = gmap graph4 (fun x -> string_of_int x) in *)

   let graph6 = init_graph graph3 in
   let flow_graph = create_flowgraph graph6 in
   let tree = init_tree flow_graph 0 in 
   let path =find_path tree 0 5 in
   let () = List.iter (fun (a,b) -> Printf.printf "(%d,%d)" a b) (path) in
   let flow_graph = add_flow flow_graph 0 path (min path) in 

   let flow_graph = filter_zeros flow_graph in 
   let tree = init_tree flow_graph 0 in
   let path =find_path tree 0 5 in
   let flow_graph = add_flow flow_graph 0 path (min path) in
   let flow_graph = filter_zeros flow_graph in 

   let graph = gmap flow_graph (fun x -> string_of_int x) in
   let () = write_file outfile graph in
   let () = export graph "graphs/dotgraphoutputgwencador" in  
  ()

