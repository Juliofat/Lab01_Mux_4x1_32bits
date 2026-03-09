module Mux_4x1_32b( 
    output [31:0] f,
    input  [31:0] a, b, c, d,
    input  [1:0]  sel
);

genvar i; // variavel usada para gerar hardware

generate 

    for(i = 0 ; i < 32; i++) begin : Vet_Mux
        Mux_4x1_1b mux_inst(
            .f(f[i]),
            .a(a[i]),
            .b(b[i]),
            .c(c[i]),
            .d(d[i]),
            .sel(sel)
        );

    end

endgenerate

endmodule







/*
Essa foi a forma inicial que eu pensei em fazer, mas pesquisei que dá para otimizar usando a maneira acima:

Mux_4x1_1b Mux0(
    .f(f[0]),
    .a(a[0]),
    .b(b[0]),
    .c(c[0]),
    .d(d[0]),
    .sel(sel)
);


Mux_4x1_1b Mux1(
    .f(f[1]),
    .a(a[1]),
    .b(b[1]),
    .c(c[1]),
    .d(d[1]),
    .sel(sel)
);

.
.
.
Mux_4x1_1b Mux31(
    .f(f[31]),
    .a(a[31]),
    .b(b[31]),
    .c(c[31]),
    .d(d[31]),
    .sel(sel)
);


*/