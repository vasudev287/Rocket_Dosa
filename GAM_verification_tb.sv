`define DEBUG_MEMOMY_CONTENTS    

//write concurrent assertions to see that node(x) or class(c) values are never zero.   
 
module GAM_verification_tb;    


import GAM_package::* ;    

//memory layer signals 
logic clk=0;  
node_vector_T x; 
int c; 
logic reset,learning_done;
LEARNING_RECALL_T learning_recall;  
READY_WAIT_T ready_wait; 
  
//recall module signals 
int Tk=4;       
node_vector_T recalling_pattern;      
 
//temp variables	
node_vector_T input_node_set[CLASS_COUNT][NODE_COUNT];     //consider using queues    
//int input_class_set[];

//temp variables for this testing module, remove or modify for diff verification modules
int node_counter,class_counter; 
int node_counter_max,class_counter_max;    


              
  


//modules instantiation

Memory_Layer ML (clk,x, c, reset,learning_done,learning_recall,ready_wait);  
  
auto_associative_recall recall_alg3 (x,Tk,learning_recall,recalling_pattern);                


//Clock
int clk_period=10;

initial  
begin
forever #(clk_period/2) clk=~clk;   
end 

//inputs     
 
initial
begin
//set initial values for temp variable according to number of inputs
//remove or modify for diff verification modules
node_counter_max= 9; 	class_counter_max=1 ;       
node_counter=1 ;     	class_counter=1;     
////////////////////////////////////////////////////////////////////

learning_recall=LEARNING; 
reset=1;
`ifdef DEBUG_MEMOMY_CONTENTS
 $monitor ($time ,"\n ", 
					"\n \t node[1]: W = %0h \t Th=%0d \t M=%0d", memory.classes[1].node[1].W ,memory.classes[1].node[1].Th, memory.classes[1].node[1].M,
					"\n \t node[2]: W = %0h \t Th=%0d \t M=%0d", memory.classes[1].node[2].W ,memory.classes[1].node[2].Th, memory.classes[1].node[2].M,
					"\n \t node[3]: W = %0h \t Th=%0d \t M=%0d", memory.classes[1].node[3].W ,memory.classes[1].node[3].Th, memory.classes[1].node[3].M, 
					"\n \t node[4]: W = %0h \t Th=%0d \t M=%0d", memory.classes[1].node[4].W ,memory.classes[1].node[4].Th, memory.classes[1].node[4].M,
					"\n \t node[5]: W = %0h \t Th=%0d \t M=%0d", memory.classes[1].node[5].W ,memory.classes[1].node[5].Th, memory.classes[1].node[4].M,
					"\n \t node[6]: W = %0h \t Th=%0d \t M=%0d", memory.classes[1].node[6].W ,memory.classes[1].node[6].Th, memory.classes[1].node[4].M,
					"\n \t node[7]: W = %0h \t Th=%0d \t M=%0d", memory.classes[1].node[7].W ,memory.classes[1].node[7].Th, memory.classes[1].node[4].M,
					"\n \t node[8]: W = %0h \t Th=%0d \t M=%0d", memory.classes[1].node[8].W ,memory.classes[1].node[8].Th, memory.classes[1].node[4].M,
					"\n \t node[9]: W = %0h \t Th=%0d \t M=%0d", memory.classes[1].node[9].W ,memory.classes[1].node[9].Th, memory.classes[1].node[4].M);                   

`endif
 
#clk_period     
reset=0; 


#(clk_period*90)  learning_recall=RECALL; x= 32'h070005;                
      
#(clk_period*100 )$stop(); //change according to number of inputs or find a better way
end

always@ (ready_wait)                    
begin

if(node_counter==node_counter_max & class_counter==class_counter_max)
learning_done=1;     
else
learning_done=0;          
       
if(ready_wait==READY & !learning_done)      
	begin        
	x=input_node_set[class_counter][node_counter];
 	c=class_counter; 
	if(node_counter !=node_counter_max)
		node_counter=node_counter+1; 
	else
		begin
		if(class_counter !=class_counter_max) 
			begin
			class_counter=class_counter+1; 
			node_counter=1;  
			end
		end 
        
	end     
end                    

 
//inputs
initial
begin 
//class 1
input_node_set[1][1]= 32'h0003;       //16x8  
input_node_set[1][2]= 32'h0400;
input_node_set[1][3]= 32'h070005;  
input_node_set[1][4]= 32'h0101;
input_node_set[1][5]= 32'h0c0b0a09; 
input_node_set[1][6]= 32'h0604; 
input_node_set[1][7]= 32'h060002;
input_node_set[1][8]= 32'h0202;     
                                                   
/*
//class 2
input_node_set[2][1]=;
input_node_set[2][2]=;
input_node_set[2][3]=;
input_node_set[2][4]=; 
input_node_set[2][5]=;
//class 3;
input_node_set[3][1]=;
input_node_set[3][2]=;
input_node_set[3][3]=;
input_node_set[3][4]=;
input_node_set[3][5]=;
//class 4 
input_node_set[4][1]=;
input_node_set[4][2]=;
input_node_set[4][3]=;
input_node_set[4][4]=;
input_node_set[4][5]=; 
*/ 
end 

endmodule
                                             