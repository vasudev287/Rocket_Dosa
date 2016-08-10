import GAM_package::* ;  

module auto_associative_recall(
	input node_vector_T x,
	input int Tk,
	input LEARNING_RECALL_T learning_recall, 
	output node_vector_T recalling_pattern);

  

int ED_recall[CLASS_COUNT:1][NODE_COUNT:1];
longint ED_square[CLASS_COUNT:1][NODE_COUNT:1];    
  
int min_class,min_node;  
int unsigned min_ED_recall;        
//int ED_x_0,comp_Tk;           
   
//calculating weight sum for all nodes in ML 
//alternatively try one-by-one calculation to compare sim Vs em time/////////////
genvar class_counter,node_counter;                      

generate               
for(class_counter=1;class_counter<=CLASS_COUNT;class_counter=class_counter+1)	           
	begin  	
	for(node_counter=1;node_counter<=NODE_COUNT;node_counter=node_counter+1)	
		begin
		ED_calculator g_calc (
			x,
			memory.classes[class_counter].node[node_counter].W,
			ED_recall[class_counter][node_counter]);
		square_int square_recall (ED_recall[class_counter][node_counter], ED_square[class_counter][node_counter]);   
		end
     
	end             
endgenerate     
/////////////////////////////////////////////////////////////////////

//ED_calculator ED_alg3 (x,'0,ED_x_0); 
//subtraction_int sub_alg3 (ED_x_0, 2*min_weight_sum, comp_Tk);     
   
//find max of weight_sum  
              //eliminate_warnings     
always_comb         
begin

if(learning_recall==RECALL)
begin 
	   
	min_ED_recall='1;          
	for(int i=1;i<=CLASS_COUNT;i=i+1)	           
	begin  	   
	for(int j=1;j<=NODE_COUNT;j=j+1)	            
		begin
		//$display("i: %0d j:%0d invalid_node_list[%0d][%0d]: %b  ",i,j,i,j,invalid_node_list[i][j]);     
		if(ED_recall[i][j] < min_ED_recall  &  invalid_node_list[i][j]!=INVALID)        
			begin   
			      
			min_ED_recall=ED_recall[i][j];     
			min_class=i;
			min_node=j;  
 			$monitor ("min_ED_recall: %0d",min_ED_recall);        
			end
		end 

	end 
       
	if(ED_square[min_class][min_node]> Tk)                         
	$display("Failed to recall memorised pattern"); 
	else
	recalling_pattern=memory.classes[min_class].node[min_node].W;                   
	end  
end   
 
endmodule   