module arbitor41(
    input wire clk,
    input wire rst_n,

    input wire sig1,
    input wire sig2,
    input wire sig3,
    input wire sig4,

    input wire ena,
    output reg [3:0] next_arb
    );

    parameter S1 = 2'b00;
    parameter S2 = 2'b01;
    parameter S3 = 2'b10;
    parameter S4 = 2'b11;

    reg [1:0] curr_arb;
    wire [1:0] curr_arbw;

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)begin
            curr_arb <= S1;
        end
        else if (ena) begin
            curr_arb <= next_arb;
        end
    end

    assign curr_arbw = curr_arb;
    always @(*) begin
        if (ena) begin
            case (curr_arbw)
                S1:begin
                    if (sig1) begin
                        next_arb = S1;
                    end
                    else if (sig2) begin
                        next_arb = S2;
                    end
                    else if (sig3) begin
                        next_arb = S3;
                    end
                    else if (sig4) begin
                        next_arb = S4;
                    end
                    else begin
                        next_arb = S4;
                    end
                end
                S2:begin
                    if (sig1) begin
                        next_arb = S1;
                    end
                    else if (sig2) begin
                        next_arb = S2;
                    end
                    else if (sig3) begin
                        next_arb = S3;
                    end
                    else if (sig4) begin
                        next_arb = S4;
                    end
                    else begin
                        next_arb = S4;
                    end
                end
                S3:begin
                    if (sig1) begin
                        next_arb = S1;
                    end
                    else if (sig2) begin
                        next_arb = S2;
                    end
                    else if (sig3) begin
                        next_arb = S3;
                    end
                    else if (sig4) begin
                        next_arb = S4;
                    end
                    else begin
                        next_arb = S4;
                    end
                end
                S4:begin
                    if (sig1) begin
                        next_arb = S1;
                    end
                    else if (sig2) begin
                        next_arb = S2;
                    end
                    else if (sig3) begin
                        next_arb = S3;
                    end
                    else if (sig4) begin
                        next_arb = S4;
                    end
                    else begin
                        next_arb = S4;
                    end
                end
                default: next_arb = S1;
            endcase
        end
        else begin
            next_arb <= curr_arb;
        end
    end

endmodule
