module tb_circuito;
    reg p3, p2, p1, p0, e1, e0;
    wire c1, c2, c3, E;

    // CORREÇÃO DO ERRO: Declara e atribui variáveis intermediárias
    // para que o $monitor possa imprimi-las.
    wire [3:0] peso;
    wire [1:0] eixo;
    assign peso = {p3, p2, p1, p0};
    assign eixo = {e1, e0};
    
    // Instancia o Circuito Principal (DUT)
    circuito DUT (.p3(p3), .p2(p2), .p1(p1), .p0(p0), .e1(e1), .e0(e0),
                  .c1(c1), .c2(c2), .c3(c3), .E(E));

    initial begin
        // Agora usamos as variáveis 'peso' e 'eixo' no monitor
        $monitor("t=%0d | P=%b%b%b%b (%0d) Eixo=%b%b (%0d) | C1=%b C2=%b C3=%b E=%b",
                  $time, p3, p2, p1, p0, peso, e1, e0, eixo, c1, c2, c3, E);

        // Define o formato VCD para visualização gráfica no GTKWave (opcional, mas bom)
        $dumpfile("ondas.vcd");
        $dumpvars(0, tb_circuito); 

        // ----------------------------------------------------
        // CASOS DE TESTE COBRINDO TODAS AS REGRAS E ERROS
        // ----------------------------------------------------

        // Inicializa entradas
        p3=0; p2=0; p1=0; p0=0; e1=0; e0=0; // T0: P=0 (<=7) Eixo=00 -> C1
        #10; 

        // --- Testes C1 (Peso <= 7 E Eixo = 00) ---
        p3=0; p2=1; p1=0; p0=0; e1=0; e0=0; // P=4 (<=7) Eixo=00 -> C1
        #10;
        
        // --- Testes C2 (Peso <= 12 E Eixo = 01) ---
        p3=1; p2=0; p1=0; p0=0; e1=0; e0=1; // P=8 (<=12) Eixo=01 -> C2
        #10;
        p3=1; p2=1; p1=0; p0=0; e1=0; e0=1; // P=12 (<=12) Eixo=01 -> C2
        #10;

        // --- Testes C3 (Peso > 12 E Eixo >= 10) ---
        p3=1; p2=1; p1=0; p0=1; e1=1; e0=0; // P=13 (>12) Eixo=10 -> C3
        #10;
        p3=1; p2=1; p1=1; p0=1; e1=1; e0=1; // P=15 (>12) Eixo=11 -> C3
        #10;

        // --- Testes Erro (Situações de falha de regra) ---
        p3=1; p2=0; p1=0; p0=0; e1=0; e0=0; // P=8 (>7) Eixo=00 -> Erro (Peso falha C1)
        #10;
        p3=0; p2=1; p1=1; p0=1; e1=0; e0=1; // P=7 (<=7) Eixo=01 -> Erro (Eixo falha C1, Peso falha C2)
        #10;
        p3=0; p2=0; p1=0; p0=1; e1=1; e0=1; // P=1 Eixo=11 -> Erro (Nenhuma regra atende)
        #10;
        
        $finish;
    end
endmodule