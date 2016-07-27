module upcounter(
	input clk,load,enable,
	input int in1,
	output int out); 

int count; 

always_ff @(posedge clk)
begin
if(load) count=in1;
else if(enable)        
	begin	
	count=count+1;
	out=count;      
	end
end 
endmodule 