 import GAM_package::* ;
 
 module Associative_Layer(
	input clk,
	input node_vector_T x, 
	input int c,
	input key_response,    //0:key, 1:response
	input assoc_learning_start,
	output assoc_learning_done);         
	
	   

//AL_memory_T AL_memory;

enum {idle,assoc_learning_key,assoc_learning_response,connection} present_state,next_state; 

int key_class; 
int response_class;  

always@(posedge clk)  //sensitivity list??
begin
present_state=next_state; 
end  
    
always_comb 
begin
idle: 
	begin
	assoc_learning_done=0; 
	end 
assoc_learning_key:
	begin
	AL_node_update();  //check syntax
	key_class=c; 
	end 
assoc_learning_response:
	begin
	AL_node_update();  
	response_class=c;  
	end 
connection: 
	begin
	if(!AL_memory.connection[key_class][response_class].connection_presence)
		begin
		AL_memory.connection[key_class][response_class].connection_presence=1; 
		AL_memory.connection[key_class][response_class].weight=1;
		AL_memory.node[key_class].response_class[ AL_memory.node[key_class].m]=response_class; 
		end 	   
	else	
		begin
		AL_memory.connection[key_class][response_class].weight=AL_memory.connection[key_class][response_class].weight+1;
		AL_memory.node[key_class].response_class[ AL_memory.node[key_class].m]=response_class; 
		end  
		
	assoc_learning_done=1;   
	end        
end 
 
always_comb
begin
case(present_state)
idle:
	begin 
	if(assoc_learning_start & !key_response)   //0:key 1:response
	next_state=assoc_learning_key; 
	else if(assoc_learning_start & key_response)   //0:key 1:response
	next_state=assoc_learning_response;
	else 
	next_state=idle;  
	end       
	
assoc_learning_key:
	begin 
	next_state=idle;                    
	end  
assoc_learning_response:
	begin	
	next_state=connection;         
	end 
connection: 
	begin	
	next_state=idle;          
	end
endcase 

end 

/* check syntax  
///function  AL_node_update()
if(AL_memory.node[c].class_name!=c) 
	begin
	AL_memory.node[c].class_name=c;
	AL_memory.node[c].m=0;
	AL_memory.node[c].W=x ;
	end 
else
	begin
	AL_memory.node[c].m=AL_memory.node[c].m+1 ;
	//find node with max(M) in class c in mem layer
	AL_memory.node[c].W= memory.classes[c].node[].W ;
	end 

endfunction 	
*/  	