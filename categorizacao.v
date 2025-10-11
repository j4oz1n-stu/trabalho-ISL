module s1 (p3, e1, e0, s1_saida);
    input p3, e1, e0;
    output s1_saida;
    wire np3, ne1, ne0;
    assign np3 = ~p3;
    assign ne1 = ~e1;
    assign ne0 = ~e0;
    assign s1_saida= np3 & ne1 & ne0;
endmodule
module s2(input p3, p2, p1, p0, e1, e0, output s2_saida);
    wire np3, np2, ne1, z1, z2, z3;
    nor(z1, p1, p0);
    not(np3, p3);
    not(np2, p2);
    not(ne1, e1);
    assign z3 = np3|np2|z1;
    and(z2, ne1, e0);
    assign s2_saida= z3 & z2;
endmodule
module s3(input p3, p2, p1, p0, e1, output s3_saida);
    wire z1, z2, z3;
    and(z1, p3, p2);
    or(z2, p1, p0);
    and(z3, z2, z1);
    assign s3_saida= z3 & e1;
endmodule
module error(input c1, c2, c3, output e_saida);
    wire nc1, nc2, nc3;
    not(nc1, c1);
    not(nc2, c2);
    not(nc3, c3);
    assign e_saida= nc1 & nc2 & nc3;
endmodule
module circuito (
    input p3, p2, p1, p0, e1, e0,
    output c1, c2, c3, E
);

    s1 U1 (.p3(p3), .e1(e1), .e0(e0), .s1_saida(c1));
    s2 U2 (.p3(p3), .p2(p2), .p1(p1), .p0(p0), .e1(e1), .e0(e0), .s2_saida(c2));
    s3 U3 (.p3(p3), .p2(p2), .p1(p1), .p0(p0), .e1(e1), .s3_saida(c3));
    error U4 (.c1(c1), .c2(c2), .c3(c3), .e_saida(E));
endmodule
module tb_circuito;
    reg p3, p2, p1, p0, e1, e0;
    wire c1, c2, c3, E;

    circuito DUT (.p3(p3), .p2(p2), .p1(p1), .p0(p0), .e1(e1), .e0(e0),
                  .c1(c1), .c2(c2), .c3(c3), .E(E));

    initial begin
        $monitor("t=%0d | p3=%b p2=%b p1=%b p0=%b e1=%b e0=%b | c1=%b c2=%b c3=%b E=%b",
                 $time, p3, p2, p1, p0, e1, e0, c1, c2, c3, E);

        // Testes
        p3=0; p2=0; p1=0; p0=0; e1=0; e0=0;
        #10;
        p3=1; p2=1; p1=0; p0=1; e1=0; e0=1;
        #10;
        p3=0; p2=1; p1=1; p0=0; e1=1; e0=1;
        #10;
        p3=1; p2=0; p1=1; p0=1; e1=1; e0=0;
        #10;
        $finish;
    end
endmodule