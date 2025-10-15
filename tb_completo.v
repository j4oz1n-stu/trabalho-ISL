module tb_circuito;
    // Entradas do Circuito (Registradores para Fornecer Estímulos)
    reg p3, p2, p1, p0, e1, e0;
    
    // Saídas do Circuito (Wires para Capturar Respostas)
    wire c1, c2, c3, E;

    // Variáveis auxiliares para loop e contagem
    integer i_peso; // Contador de 0 a 15 para o Peso
    integer i_eixo; // Contador de 0 a 3 para o Eixo

    // CORREÇÃO DO ERRO E VISUALIZAÇÃO: Sinais concatenados e decimais
    // Usados para exibir o valor no $monitor e para simplificar a visualização
    wire [3:0] peso_bin;
    wire [1:0] eixo_bin;
    assign peso_bin = {p3, p2, p1, p0};
    assign eixo_bin = {e1, e0};
    
    // Instancia o Circuito Principal (Design Under Test - DUT)
    circuito DUT (.p3(p3), .p2(p2), .p1(p1), .p0(p0), .e1(e1), .e0(e0),
                  .c1(c1), .c2(c2), .c3(c3), .E(E));

    initial begin
        // ---------------------------------------------
        // COMANDOS PARA VISUALIZAÇÃO NO GTKWAVE
        // ---------------------------------------------
        $dumpfile("ondas.vcd"); // Cria o arquivo de formas de onda
        $dumpvars(0, tb_circuito); // Monitora todos os sinais no módulo tb_circuito
        
        // Monitora as alterações no terminal
        $monitor("t=%0d | P=%b%b%b%b (Dec: %0d) Eixo=%b%b (Dec: %0d) | C1=%b C2=%b C3=%b E=%b",
                  $time, p3, p2, p1, p0, peso_bin, e1, e0, eixo_bin, c1, c2, c3, E);

        // ---------------------------------------------
        // VARREDURA COMPLETA DE TODAS AS 64 COMBINAÇÕES
        // ---------------------------------------------

        // Loop externo: Varia o peso de 0 a 15
        for (i_peso = 0; i_peso < 16; i_peso = i_peso + 1) begin
            // Loop interno: Varia o eixo de 0 a 3
            for (i_eixo = 0; i_eixo < 4; i_eixo = i_eixo + 1) begin
                
                // Atribui os valores do loop aos pinos de entrada
                {p3, p2, p1, p0} = i_peso;
                {e1, e0} = i_eixo;
                
                // Aguarda 10 unidades de tempo para o circuito estabilizar
                #10;
            end
        end
        
        $finish; // Termina a simulação
    end
endmodule