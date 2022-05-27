
module data_sel_4(
   input             S0     ,
   input             S1     ,
   input             D0     ,
   input             D1     ,
   input             D2     ,
   input             D3     ,
   
   output wire        Y    
);

assign Y = ~S1 & (~S0&D0 | S0&D1) | S1&(~S0&D2 | S0&D3);
     
endmodule


//实现输出逻辑：L = A∙B + A∙~C + B∙C
module sel_exp(
   input             A     ,
   input             B     ,
   input             C     ,
   
   output wire       L            
);
    data_sel datasel1(
        .S0(~B),
        .S1(~A),
        .D0(1'b1),
        .D1(~C),
        .D2(C),
        .D3(1'b0)
        .Y(L)
        
    );
    
endmodule