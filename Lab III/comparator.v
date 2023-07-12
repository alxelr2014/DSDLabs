
module comparator (a,	b,	reset,	less_out, great_out ,	equal_out,	clk);

	input	a, b, reset, clk;
	output	less_out,great_out, equal_out;
    wire less_new, great_new,equal_new;
    wire less_up,less_down, great_up,great_down, equal_up,equal_down;
    wire not_less, not_great, not_equal;
    
    assign less_new = ~reset & ((less_out & ~great_out & ~equal_out) | (equal_out & ~a &b));
    assign great_new = ~reset & ((~less_out & great_out & ~equal_out) | (equal_out & a & ~b) );
    assign equal_new = reset | (~reset)&(~less_out & ~great_out & equal_out & ~(a ^ b));
    
    assign less_up = ~(less_new & clk);
    assign less_down = ~(~less_new & clk);
    assign great_up = ~(great_new & clk);
    assign great_down = ~(~great_new & clk);
    assign equal_up = ~(equal_new & clk);
    assign equal_down = ~(~equal_new & clk);    

	assign less_out = ~(less_up & not_less);
	assign great_out = ~(great_up & not_great);
	assign equal_out = ~(equal_up & not_equal);
	assign not_less = ~(less_down & less_out);
	assign not_great = ~(great_down & great_out);
	assign not_equal = ~(equal_down & equal_out);

endmodule
