import GAM_package::* ; 

module GAM_verification_tb();

//memory layer signals 
logic clk=0;  
node_vector_T x; 
int c; 
logic reset,learning_done;
LEARNING_RECALL_T learning_recall;  

//recall module signals 
int Tk;  
node_vector_T recalling_pattern;    
 
//temp variables	
node_vector_T input_node_set[CLASS_COUNT][NODE_COUNT];     
int input_class_set[];

          
  


//modules instantiation

Memory_Layer ML (clk,x, c, reset,learning_done,learning_recall);
  
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
learning_recall=LEARNING; 
learning_done=1;
reset=1;

#clk_period  
reset=0; learning_done=0; 
x=input_node_set[1][1];c=1;

#(10*clk_period)
x=input_node_set[1][2]; 

#(10*clk_period)
x=input_node_set[1][3];

#(10*clk_period)  
learning_done=1;    
$stop();
end


 

 
//inputs
initial
begin
//class 1
input_node_set[1][1]= 128'd1234;       //16x8  
input_node_set[1][2]= 128'd22313;
input_node_set[1][3]= 128'd324234;
input_node_set[1][4]= 128'd123000000000000;
input_node_set[1][5]= {32'd54,32'd54754654,32'd32432432,32'd675656};       
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