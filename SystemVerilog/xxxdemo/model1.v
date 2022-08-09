module model1(
    input wire clk,
    input wire rst_n,
    input wire sel,
    
    output reg flag
);
    //检测序列101, mealy状态机
parameter s0 = 3'b001;
parameter s1 = 3'b010;
parameter s2 = 3'b100;

reg [2:0] curr_state, next_state;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        curr_state <= s0;
        next_state <= s0;
    end
    else begin
        curr_state <= next_state;
    end
end

//
always@(*)begin
    case (curr_state)
        s0:next_state = sel ? s1 : s0;
        s1:next_state = sel ? s0 : s2;
        s2:next_state = sel ? s1 : s0;
    endcase
end
//
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        flag <= 0;
    end
    else if((curr_state == s2) && (sel == 1)) begin
        flag <= 1;
    end
    else begin
        flag <= 0;
    end
end


endmodule