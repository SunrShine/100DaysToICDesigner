module tester(model1_bfm bfm);
    initial begin
        bit in_data;
        bfm.reset();
        repeat(1000)begin
            in_data = ($random) % 2;
            bfm.send_data(in_data);
        end
        $stop;
    end

endmodule