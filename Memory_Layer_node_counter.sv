import GAM_package::* ;  

module Memory_Layer_node_counter(
	input int class_name,
	input en_node_counter,
	output int node_count
	);

node_counter_mem_T node_counter;     
	
always@(posedge en_node_counter)	
begin

node_counter.node_count[class_name]= node_counter.node_count[class_name]+1; 
node_count=node_counter.node_count[class_name]; 
end    

endmodule 