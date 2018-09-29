`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:28:22 09/26/2018 
// Design Name: 
// Module Name:    thunderbird 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module thunderbird(input clk, reset, left, right,
						 output reg left_a, left_b, left_c,
						 right_a, right_b, right_c
						 );
						 
	reg [5:0] currentState, nextState, l;
	
	always @* begin
		l[0] <= left_c;
		l[1] <= left_b;
		l[2] <= left_a;
		l[3] <= right_a;
		l[4] <= right_b;
		l[5] <= right_c;
	end
	

	parameter   allO = 6'b000000,
 	            firstL = 6'b001000,
               secondL = 6'b011000,
 	            allL = 6'b111000,
 	            firstR = 6'b000100,
 	            secondR = 6'b000110,
 	            allR = 6'b000111;
	
	always @(posedge clk)
		if(reset)
			currentState <= allO;
		else
			currentState <= nextState;
	
	

	always @(*)
		case (currentState)
				
				allO: begin 
					if(left & ~right) begin 
						nextState = firstL; 
					end
					else if (~left & right) begin 
						nextState = firstR; 
					end
					else begin 
						nextState = allO; 
					end
				end
				
				firstL: nextState = secondL;
				secondL: nextState = allL;
				allL: nextState = allO;
				firstR: nextState = secondR;
				secondR: nextState = allR;
				allR: nextState = allO;
				default: nextState = allO;
				
		endcase
		
		always @* begin
			l <= currentState;
			
			left_c <= l[0];
			left_b <= l[1];
			left_a <= l[2];
			right_a <= l[3];
			right_b <= l[4];
			right_c <= l[5];
		end
		
endmodule
