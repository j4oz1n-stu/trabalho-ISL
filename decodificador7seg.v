module sete_segmentos(c1,c2,c3,E,a,b,c,d,e,f,g);
      input c1,c2,c3,E;
      output a,b,c,d,e,f,g;
      or(a,c2,c3,E);
      assign b = E;
      or(c,c2,c3,E);
      or(d,c1,c2,c3);
      or(e,c1,c3);
      or(f,c2,c3,E);
      or(g,c2,E);
endmodule 
