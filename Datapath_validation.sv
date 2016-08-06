import GAM_package::* ;

module Algorithm1_validation();
logic  clk;
node_vector_T x;
int c;
logic  reset,learning_done,assoc_learning_done;
logic assoc_learning_start;  
//wait_ready_T wait_ready ;
int count = 0 ; 
Memory_Layer memory_module (
	clk,x, c, reset,learning_done,assoc_learning_done, assoc_learning_start, wait_ready);  


node_vector_T x_mem[5:1]; 
int i;

initial 
begin
x_mem[1] = 128'b 00000000_00001010_00000000_00010100_00000000_10100000_00101000_00000000_00000000_00000000_11011100_00101000_01010000_00000000_00010100_10001100;

x_mem[2] = 128'b 11111111_11111111_00001010_00011110_00001010_10101010_00110010_00001010_00001010_00001010_11100110_00110010_01011010_00001010_00011110_10010110;

//x_mem[1]= 4'b0001; 
//x_mem[2]= 4'b0011 ;
x_mem[3]= 4'b0101;
x_mem[4]= 4'b0001;
x_mem[5]= 4'b1101;  
end

always 
#10 clk = ~clk;

initial 
begin 
clk =0;
assoc_learning_done =1;
learning_done = 1;
c =1;
#10 learning_done=0;  

/*
if (wait_ready == READY && count == 0) begin 
x = 4'b0001;
c = 1;
count+=1;
end 
#10 

if (wait_ready == READY && count == 1) begin 
x = 4'b0010;
c = 3;
count+=1;
end 
#10 
if (wait_ready == READY && count == 2) begin 
x = 4'b0101;
c =2; 
count+=1;
end  
*/
end 

always@(/*wait_ready,*/learning_done)  
begin
if(wait_ready==READY & i<=5)
	begin
	x=x_mem[i];
	i=i+1;
	end

else if ( i>5) 
begin 
learning_done =1;
$stop();
end

end  


endmodule 


