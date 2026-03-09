`timescale 1ps/1ps

module Tb_Mux_4x1_32b;

logic [31:0] Entradas[4]; // vetor de entradas a, b, c, d (cada uma com 32bits)
logic [1:0] sel;
logic [31:0] f;
logic [31:0] saida_esperada;

// Instância do MUX;

Mux_4x1_32b dut(
    .f(f),
    .a(Entradas[0]),
    .b(Entradas[1]),
    .c(Entradas[2]),
    .d(Entradas[3]),
    .sel(sel)
);

initial begin
    // gerar bits aleatorios para as entradas
    for(int i = 0; i < 4; i++)
        Entradas[i] = $urandom;

    // imprimir as entradas:
     
    $display("Entradas geradas:");
    $display("A = %b", Entradas[0]);
    $display("B = %b", Entradas[1]);
    $display("C = %b", Entradas[2]);
    $display("D = %b", Entradas[3]);
    $display("-----------------------------");
    

    // testa toodas as configuracoes do seletore:
    for(int i =0; i < 4; i++) begin
        sel = i;
        saida_esperada = Entradas[sel]; // essencia de um mux: pegar a entrada com base naquele indice de selecao
        #10; // espera 10 seg
        
        check(); // funcao para verificar a saida esperada e entrada
    end

    $display("Teste bench finalizado");
    $finish;

end

// -------- TASK DE VERIFICAÇÃO --------

task check;

    if(f !== saida_esperada) begin
        $display("ERRO: sel=%b Entrada_esperada=%b obtido=%b", sel, saida_esperada, f);
    end
    else begin
        $display("OK: sel=%b saida=%b", sel, f);
    end

endtask

endmodule

/*
IDEIA GERAL DO TESTBENCH

O objetivo deste testbench é verificar o funcionamento de um MUX 4x1 de 32 bits.

1) CRIAÇÃO DAS ENTRADAS

Primeiramente é criado um vetor chamado "Entradas" com tamanho 4:

    logic [31:0] Entradas[4];

Esse vetor representa as quatro entradas do MUX:
    Entradas[0] -> A
    Entradas[1] -> B
    Entradas[2] -> C
    Entradas[3] -> D

Cada uma dessas entradas possui 32 bits.

Também são criadas as seguintes variáveis:
    sel              -> seletor do MUX (2 bits)
    f                -> saída produzida pelo circuito (DUT)
    saida_esperada   -> valor que esperamos que o MUX produza


2) INSTÂNCIA DO DUT (DEVICE UNDER TEST)

O módulo do MUX é instanciado conectando cada posição do vetor
às entradas do circuito.

Assim, o testbench controla os sinais de entrada e observa
a saída gerada pelo MUX.


3) GERAÇÃO DE DADOS ALEATÓRIOS

O primeiro loop "for" gera valores aleatórios para as entradas
do MUX utilizando a função:

    $urandom

Na prática, isso significa que cada entrada (A, B, C e D)
receberá um valor aleatório de 32 bits. Isso ajuda a testar
o circuito com diferentes combinações de dados.


4) TESTE DAS POSSÍVEIS SELEÇÕES

O segundo loop "for" percorre todas as possíveis configurações
do seletor do MUX.

Como o MUX é 4x1, o seletor possui 2 bits e pode assumir
quatro valores possíveis:

    sel = 0
    sel = 1
    sel = 2
    sel = 3

Para cada valor de seleção:

    sel = i;

O circuito então seleciona uma das quatro entradas.


5) CÁLCULO DA SAÍDA ESPERADA

Após definir o seletor, calculamos qual deveria ser a saída correta:

    saida_esperada = Entradas[sel];

Essa linha expressa exatamente o comportamento fundamental
de um multiplexador:

    "A saída deve ser igual à entrada indicada pelo seletor."

Por exemplo:

    sel = 2  ->  saída esperada = Entradas[2] (entrada C)


6) VERIFICAÇÃO DO RESULTADO

A task "check()" é chamada para comparar:

    saída do circuito (f)
    vs
    saída esperada (saida_esperada)

Se os valores forem diferentes, significa que o MUX
não está funcionando corretamente.

Nesse caso, uma mensagem de erro é exibida:

    ERRO: sel=... esperado=... obtido=...

Caso contrário, o teste é considerado correto e o
testbench imprime uma mensagem indicando sucesso.


7) FINALIZAÇÃO

Após testar todas as configurações do seletor,
o testbench imprime uma mensagem indicando o
fim da simulação e encerra a execução com:

    $finish;
*/

