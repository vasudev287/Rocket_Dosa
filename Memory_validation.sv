// Testing the EUClidian Distance module by giving it scaled down vector inputs which are 2x2 or 4x4 

// Verification Goal: TO check if memory module stores the data in correct location and gives it back on request
// Statergy: Give values to X and W, change the controller inputs and observe the change on the READ operation of controller 

import GAM_package::*; 

module Memory_validation;

 
// Inputs drivers in the testbench 

logic clk;
// Output 
int out; 
// Port mapping values 
node_vector_T X_i,W_i;
int class_i,node_i,Th_i,M_i;
logic X_c,C_c,W_c,T_c,M_c;
RD_WR_T RD_WR_c;
int class_o,node_o,Th_o,M_o;
node_vector_T X_o,W_o;

Memory_Layer_memory UUT (.class_i(class_i),.node_i(node_i),.Th_i(Th_i),.M_i(M_i),
			  .X_c(X_c),.C_c(C_c),.W_c(W_c),.T_c(T_c),.M_c(M_c),.RD_WR_c(RD_WR_c),  
			  .X_i(X_i),.W_i(W_i),.class_o(class_o),.node_o(node_o),.Th_o(Th_o),.M_o(M_o), .X_o(X_o),.W_o(W_o)); 

always 
#10 clk = ~clk;

 initial  
begin:testcase_block 
/*
X_i = 4'b 0001;
W_i = 4'b 0010;

// Observing changes by fixing a class and writing to two nodes  changing the values of others i.e. Node, X_c, W_c etc 
class_i = 2; node_i = 1; Th_i = 1; M_i = 0; X_c =1; W_c =1; {C_c,T_c,M_c} = '0;
RD_WR_c = WRITE;  	

#10
X_i = 4'b 1111;	W_i = 4'b 1111;

// Observing changes by fixing a class and writing to two nodes  changing the values of others i.e. Node, X_c, W_c etc 
class_i = 1; node_i = 2; Th_i = 1; M_i = 0; X_c =1; W_c =1; {C_c,T_c,M_c} = '0;
RD_WR_c = WRITE;  	
#10 
class_i = 1; node_i = 3; Th_i = 1; M_i = 0; X_c = 1; W_c = 1; {C_c,T_c,M_c} = '0;  RD_WR_c = WRITE;
X_i = 4'b 0000;
W_i = 4'b 0001;


#10
node_i = 3; X_c =1; W_c =1;  RD_WR_c = READ;


#10

node_i = 2; X_c =1; W_c =1;  RD_WR_c = READ;


#10

class_i = 2; node_i = 1; X_c =1; W_c =1;  RD_WR_c = READ;

*/
////////////////////////////////////////////////////////////
// Verification of other signals 
class_i = 4; node_i = 49; Th_i = 1; M_i = 1; X_c = 0; W_c = 0; {C_c,T_c,M_c} = '1;  RD_WR_c = WRITE;
X_i = 4'b 0000;
W_i = 4'b 0001;

#10
class_i = 4; node_i = 49; X_c =0; W_c =0; {C_c,T_c,M_c} = '0;  RD_WR_c = READ;
$display(" ********class_o is %0d,node_o is %0d,Th_o is %0d,M_o is %0d", class_o,node_o,Th_o,M_o);
    end                 
always @ (*)
    begin /*
	for(int j=0;j<VECTOR_LEN;j=j+1)	      
	begin  	
	$display(" Inputs  are %d:   %0d, %0d ",j, X_i[(j*8)+:8],W_i[(j*8)+:8]); //[0:9] 9 units  //8 
	$display("************************************************************************");
	$display(" Outout  are %d:   %0d, %0d ",j, X_o[(j*8)+:8],W_o[(j*8)+:8]); //[0:9] 9 units  //8 
	end */
	//$display ("Input X is %0d, W %0d", X_i, W_i); 
	$display ("Output  X is %0d, W %0d", X_o, W_o);
	$display(" class_o is %0d,node_o is %0d,Th_o is %0d,M_o is %d", class_o,node_o,Th_o,M_o);
 end 
   endmodule 		