module coverage( model1_bfm bfm);

    logic sel;
    logic flag;

    covergroup cg_cov;
        coverpoint sel;
        coverpoint flag;

    endgroup

    cg_cov oc;
    initial begin
        oc = new();
        forever begin
            @(posedge bfm.clk);
            sel = bfm.sel;
            flag = bfm.flag;
            oc.sample();
        end
    end
endmodule