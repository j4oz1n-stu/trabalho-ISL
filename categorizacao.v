module s1 (input p3, e1, e0, output s1_saida);
    nor(s1_saida, p3, e1, e0);
endmodule
module s2(input p3, p2, p1, p0, e1, e0, output s2_saida);
    wire np3, np2, ne1, z1, z2, z3;
    nor(z1, p1, p0);
    not(np3, p3);
    not(np2, p2);
    not(ne1, e1);
    or(z3, np3, np2, z1);
    and(z2, ne1, e0);
    and(s2_saida, z3, z2);
endmodule
module s3(input p3, p2, p1, p0, e1, output s3_saida);
    wire z1, z2, z3;
    and(z1, p3, p2);
    or(z2, p1, p0);
    and(z3, z2, z1);
    and(s3_saida, z3, e1);
endmodule
module error(input c1, c2, c3, output e_saida);
    nor(e_saida, c1, c2, c3);
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
