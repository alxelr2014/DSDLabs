

module one_bit_comparator	(a,	b,	less_in, great_in ,	equal_in,	less_out, great_out,	equal_out);

	input		a, b, equal_in, less_in, great_in,equal_in;
	output	less_out,great_out, equal_out;
    
	assign	less_out = (~equal_in & less_in & ~great_in) | (equal_in & ~a & b);
	assign  great_out = (~equal_in & ~less_in & great_in) | (equal_in & a & ~b);
	assign	equal_out   = (equal_in & ~less_in & ~great_in & ~(a ^ b));

endmodule
