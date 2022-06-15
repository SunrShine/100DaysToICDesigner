module detect101(
    input wire clk,
    input wire rst_n,
    input wire data,
    output wire flag_101
);
    parameter s0 = 0,s1 = 1, s2 = 2, s3 = 3, s4 = 4;

    reg [1:0] state;

    always @(posedge clk or negedge rst_n) begin
        if(~rst_n)begin
            state <= s0
        end
        else begin
            case(state)
            s0:
                if(data == 1)
                    state <= s1;
                else
                    state <= s0;
            s1:
                if(data == 0)
                    state <= s2;
                else
                    state <= s1;
            s2:
                if(data == 1)
                    state <= s3;
                else
                    state <= s0;
            s3:
                if(data == 1)
                    state <= s1;
                else
                    state <= s2;                                        
            endcase
        end
    end

    assign flag_101 = (state == s3) ? 1'b1 : 1'b0;
endmodule