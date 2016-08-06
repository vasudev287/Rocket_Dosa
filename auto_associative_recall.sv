import GAM_package::* ;  

module auto_associative_recall(
	input node_vector_T x,
	input int Tk,
	input LEARNING_RECALL_T learning_recall, 
	output node_vector_T recalling_pattern);

  

int weight_sum[CLASS_COUNT:1][NODE_COUNT:1];   
int min_class,min_node; 
int min_weight_sum='1;  
int ED_x_0,comp_Tk;     
  
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
			weight_sum[class_counter][node_counter]);          
		end
     
	end           
endgenerate     
/////////////////////////////////////////////////////////////////////

ED_calculator ED_alg3 (x,'0,ED_x_0); 
subtraction_int sub_alg3 (ED_x_0, 2*min_weight_sum, comp_Tk);     
   
//find max of weight_sum  
              //eliminate_warnings     
always_comb         
begin
min_weight_sum='1; 
for(int i=1;i<=CLASS_COUNT;i=i+1)	           
	begin  	   
	for(int j=1;j<=NODE_COUNT;j=j+1)	
		begin
		if(weight_sum[i][j]<min_weight_sum)
			begin         
			min_weight_sum=weight_sum[i][j];   
			min_class=i;
			min_node=j;          
			end
		end 

	end 

if(learning_recall==RECALL)
 	begin          
	if(comp_Tk> Tk)
	$display("Failed to recall memorised pattern"); 
	else
	recalling_pattern=memory.classes[min_class].node[min_node].W;   
	end  
end   
 
endmodule  