module top();

model1_bfm bfm();
coverage coverage_i(bfm);
tester tester_i(bfm);

model1 model1_i(
    .clk(bfm.clk),
    .rst_n(bfm.rst_n),
    .sel(bfm.sel),
    .flag(bfm.flag)
);

endmodule


//  vlog .\top.sv .\tester.sv .\model1_bfm.sv .\coverage.sv .\model1.v
// vopt top -o top_optimized +acc +cover=sbfec+model1_fsm

// vsim top_optimized -coverage