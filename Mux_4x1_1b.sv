module Mux_4x1_1b(
    output f, 
    input a, b, c, d,
    input [1:0] sel
);

assign f = (sel == 2'b00) ?  a:
           (sel == 2'b01) ?  b:
           (sel == 2'b10) ?  c:
           d;


endmodule