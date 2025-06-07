`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/29/2025 01:40:00 PM
// Design Name: 
// Module Name: edge_detector
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module edge_detector(
input clk,reset_n,
input level,
output p_edge,n_edge,_edge
);

 //Edge Detector with Mealy ouputs
 reg state_reg,state_next;
 parameter s0=0,s1=1;
  //Sequential State Registers
  always @(posedge clk,negedge reset_n)
  begin 
     if(~reset_n)
       state_reg <= 'b0;
     else 
       state_reg <= state_next;
   end
   
   //Next state logic 
   always @(*)
   begin  
       case(state_reg)
            s0:if(level)
                 state_next=s1;
                else
                 state_next=s0;
                 
             s1:if(level)
                 state_next=s1;
                 else
                 state_next=s0;
             
           default:state_next=s0;
           
        endcase
      end
      
      //Output logic
      assign p_edge=(state_reg==s0)&level;
      assign n_edge=(state_reg==s1)& ~level;
      assign _edge= p_edge |n_edge;    
      
endmodule
