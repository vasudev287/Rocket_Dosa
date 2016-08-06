import GAM_package::* ;

module calculate_W_Th_tb(); 

node_vector_T X_in,Ws1_in,Ws2_in;
int Ths1_in,Ms1_in,min1_ED;  
node_vector_T Ws1_out,Ws2_out;
int Ths1_out; 


calculate_W_Th calc(  
	X_in,Ws1_in,Ws2_in,
	Ths1_in,Ms1_in,min1_ED,  
	Ws1_out,Ws2_out,
	Ths1_out );   


initial 
begin
#10
X_in={8'b00000000,
8'b00010100,
8'b00000000,
8'b01111000};
Ws1_in={8'b00000000,
8'b00101000,
8'b00010100,
8'b10100000};
Ws2_in={8'b01010000,
8'b00000000,
8'b11110000,
8'b00010100}; 
Ths1_in= 4;  
Ms1_in=2; 
min1_ED=20;      


#10  $display( "Ws1=%b: %d : %h \n Ws2=%b \n Ths1=%d",Ws1_out,Ws1_out,Ws1_out,Ws2_out,Ths1_out );    
end 
endmodule   

