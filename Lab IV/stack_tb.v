`include "stack.v"
`timescale 1ns/1ns
module stack_tb;

	parameter cycle = 10;
	reg	rstN, push, pop, clk;
	reg	[3 : 0] data_in;
	wire full, empty;
	wire [3 : 0] data_out;
	integer i;
	
	stack #(.DEPTH(8),.WIDTH(4)) stack0 (
		.rstN(rstN),
		.clk(clk),
		.data_in(data_in),
		.push(push),
		.pop(pop),
		.data_out(data_out),
		.full(full),
		.empty(empty));
    
	initial begin
		clk	= 0;
		forever	#(cycle/2) clk = ~clk;
	end
    
	initial begin
		$monitor($time,"\tpush=%b, pop=%b, data_in=%d, empty=%b, full=%b, data_out=%d", push, pop, data_in, empty, full, data_out);
		$dumpfile("stack.vcd");
		$dumpvars(0,stack0);
		rstN = 0;
		push = 0;
		pop = 0;
		data_in = 0;
		#cycle rstN = 1;
  
		for (i = 1; i <= 8; i = i +1) begin
		#cycle push = 1;
		pop = 0;
		data_in = i;
		end
		
		#cycle data_in = 9;
		
		#cycle push = 0;
		pop = 1;
		for (i = 0; i <= 8; i = i + 1) begin
			#cycle ;
		end
		
		#cycle push = 1;
		data_in = 1;
		#cycle data_in = 2;
		#cycle push = 0;
		$finish;            
	end    
endmodule
