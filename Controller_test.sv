import GAM_package::*;

module Controller_test;

logic clk =0;
logic reset, learning_done,assoc_learning_done;
comparator_T comparator;
logic ld_upcounter,en_upcounter,en_node_counter,assoc_learning_start;
logic en_connection, X_c,C_c,W_c,T_c,M_c;
RD_WR_T RD_WR_c;
logic [1:0] mux1,mux2,mux3,mux4,mux5,mux6,demux;    
 

Memory_Layer_controller UUT (
	 clk,reset, learning_done,assoc_learning_done, comparator,
	 ld_upcounter,en_upcounter,en_node_counter,assoc_learning_start,
   	en_connection, X_c,C_c,W_c,T_c,M_c, RD_WR_c,
	 mux1,mux2,mux3,mux4,mux5,mux6,demux);    

always 
#10 clk = ~clk;

initial 
begin
// Regular Check for the flow of code 
//reset = 1;
#10 
learning_done = 0; 
#10 
//learning_done = 1;

comparator = EQUAL; 
#20 
comparator = EQUAL; 
#10 
comparator = LESSER; // Put Greater to check the other path 
#80 
assoc_learning_done = 1;
learning_done = 1;


end 

endmodule 