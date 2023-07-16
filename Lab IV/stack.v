module stack (rstN, clk, data_in, push, pop, data_out, full, empty);

	parameter DEPTH = 8;
	parameter WIDTH	= 4;
    
	input wire rstN, push, pop, clk;
	input wire [WIDTH - 1 : 0] data_in;
	output full, empty;
	output reg [WIDTH - 1 : 0] data_out;
    
	reg [WIDTH - 1 : 0] stack [0 : DEPTH - 1];
	reg [DEPTH : 0] hotbit_address;
	
    
	assign	empty = !hotbit_address[0];
	assign	full  = hotbit_address[DEPTH];
	integer i;

	always @(posedge clk) begin
		if (!rstN) begin
			for (i = 0 ; i < DEPTH ; i = i +1) begin
				stack[i] = {WIDTH{1'b0}};
			end
			hotbit_address = {{DEPTH-1{1'b0}}, 1'b1};
		end
		else begin
			if (push &&  !full) begin
				for ( i = 0 ; i < DEPTH; i = i+ 1) begin
					if (hotbit_address[i]) stack[i] = data_in;
				end
				hotbit_address = hotbit_address << 1;
			end
			else if (pop && empty) begin
				for ( i = 1 ; i <= DEPTH ; i = i +1) begin
					if(hotbit_address[i]) data_out = stack[i-1];
				end
				hotbit_address = hotbit_address >> 1;	
			end
		end
	end
endmodule
