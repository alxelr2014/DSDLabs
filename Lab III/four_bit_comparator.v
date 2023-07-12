

module four_bit_comparator (a, b, less_out, equal_out,great_out);

	parameter	LEN = 4;
	input	wire	[LEN-1:0] a, b;
	output		less_out, great_out, equal_out;
    
	wire		[LEN:0] less,great, equal;
    
	assign	less[0]	= 0;
	assign	equal[0]= 1;
	assign	great[0] = 0;
	assign 	less_out =	less[LEN];
	assign  great_out = great[LEN];
	assign	equal_out =	equal[LEN];
    
	genvar	i;
	generate
	for (i = 0 ; i < LEN; i = i + 1) begin : compare
		one_bit_comparator comp(
		.a(a[LEN -1 - i]),
		.b(b[LEN -1 - i]),
		.less_in(less[i]),
		.great_in(great[i]),
		.equal_in(equal[i]),
		.less_out(less[i+1]),
		.great_out(great[i+1]),
		.equal_out(equal[i+1])
		);
	end
	endgenerate
    
endmodule
