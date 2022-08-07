module coverage( model1_bfm bfm);
    logic sel;
    logic flag;

    covergroup cg_cov
        coverpoint sel;
        coverpoint flag;
    endgroup

    initial begin
        oc = new();
        
    end
endmodule