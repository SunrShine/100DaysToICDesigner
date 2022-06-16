module divthree(
    input wire clk,
    input wire rst_n,
    output wire div_three
);
    reg [1:0] cnt;
    reg div_clk1;
    reg div_clk2;

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            cnt <= 0;
        end
        else if(cnt == 2)begin
            cnt <= 0;
        end
        else begin
            cnt <= cnt + 1;
        end
    end

    always @(posedge clk or negedge rst_n)begin
        if(rst_n == 1'b0)begin
            div_clk1 <= 0;
        end
        else if(cnt == 0)begin
            div_clk1 <= ~div_clk1;
        end
        else
            div_clk1 <= div_clk1;
    end
    always @(negedge clk or negedge rst_n)begin
        if(rst_n == 1'b0)begin
            div_clk2 <= 0;
        end
        else if(cnt == 2)begin
            div_clk2 <= ~div_clk2;
        end
        else
            div_clk2 <= div_clk2;
    end
assign div_three = div_clk2 ^ div_clk1;

endmodule