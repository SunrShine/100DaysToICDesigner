module coverage( model1_bfm bfm);
    logic in;
    logic out;
    logic [2:0] state;

    covergroup cg_cov
        coverpoint in;
        coverpoint out;
        coverpoint state;
    endgroup

    cg_cov oc;
    initial begin
        oc = new();
        forever begin
            @(posedge bfm.clk);
            in = bfm.in;
            out = bfm.out;
            state =  bfm.state;
            oc.sample();
        end
    end
endmodule